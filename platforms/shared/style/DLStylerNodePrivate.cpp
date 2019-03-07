#include <string>
#include <sstream>
#include <iostream>
#include <algorithm>
#include "DLStylerNode.h"
#include "DLStylerNodePrivate.h"
#include "DLStyler.h"
#include "DLStylerPrivate.h"
#include "DLStylerStyleRule.h"
#include "DLStylerStyleRulePrivate.h"
#include "DLStylerStyleItem.h"
#include "DLStylerStyleItemPrivate.h"
#include "DLStylerStyleSelector.h"
#include "DLStylerStyleSelectorPrivate.h"
#include "DLStylerStyleSelectorTree.h"
#include "DLStylerStyleSelectorTreePrivate.h"
#include "DLStylerMatch.h"

using std::set;
using std::find;
using std::sort;
using std::vector;
using std::string;
using std::stringstream;
using std::reverse;
using std::getline;

bool
DLStylerStyleApplyOrder(DLStylerStyleItemRef a, DLStylerStyleItemRef b)
{
	return a->position < b->position;
}

void
DLStyleParseTypes(DLStylerNodeRef node, const char *type)
{
	static unordered_map<string, vector<string>> cache;

	string t(type);

	if (cache.count(type) == 0) {
		string token;
		stringstream stream(type);
		while (getline(stream, token, '.')) cache[type].push_back(token);
	}

	node->type  = cache[type][0];
	node->types = cache[type];
}

void
DLStylerNodeRetrieveInitialValue(DLStylerNodeRef node, string property)
{
	if (node->fetchCallback == NULL) {
		return;
	}

	if (node->initialValues.count(property) == 0) {

		OpaqueDLStylerStyleItem prop;
		prop.property = property;
		prop.type = kDLStylerStyleItemTypeNull;
		prop.unit = kDLStylerStyleItemUnitNone;

		bool found = node->fetchCallback(node, &prop);

		if (found) {

			DLStylerStyleItemRef value = new OpaqueDLStylerStyleItem;
			value->property = prop.property;
			value->type = prop.type;
			value->unit = prop.unit;
			value->raw_value = "<provided by node>";
			value->str_value = prop.str_value;
			value->num_value = prop.num_value;
			value->boo_value = prop.boo_value;

			node->initialValues[property] = value;
		}
	}
}

void
DLStylerNodeAttachStyles(DLStylerNodeRef node, const vector<DLStylerMatchedRuleRef> &matches, DLStylerStyleItemRefMap &definition)
{
	for (auto &match : matches) {

		DLStylerNodeInvalidateChildren(node, match);

		if (node->matchedStyles.size() > 0) {
			DLStylerMatchedRuleRef under = node->matchedStyles.back();
			under->next = match;
			match->prev = under;
		}

		node->matchedStyles.push_back(match);

		for (auto &item : match->rule->items) {

			auto key = item.first;
			auto val = item.second;

			if (node->matchedValues.count(key) == 0) {
				DLStylerNodeRetrieveInitialValue(node, key);
			}

			node->matchedValues[key] = match;
			node->currentValues[key] = val;

			definition[key] = val;
		}
	}
}

void
DLStylerNodeDetachStyles(DLStylerNodeRef node)
{
	for (auto &style : node->matchedStyles) {
		DLStylerNodeInvalidateChildren(node, style);
		delete style;
	}

	node->matchedStyles.clear();
	node->matchedValues.clear();
	node->currentValues.clear();
}

void
DLStylerNodeInvalidateChildren(DLStylerNodeRef node, DLStylerMatchedRuleRef style)
{
	// TODO
	// I believe this can be optimized.

	DLStylerStyleSelectorTreeRef selector_tree = node->styler->selector_tree;

	/*
	 * Starts by finding the selector in the tree so we can find child
	 * selector and invalidate matching shadowed.
	 */

	for (auto &selector : style->rule->selectors) {
		selector_tree = selector_tree->children[selector->name];
	}

	if (selector_tree == NULL ||
		selector_tree->children.size() == 0) {
		return;
	}

	for (auto &child : selector_tree->children) {
		DLStylerNodeInvalidateChildrenMatchingSelector(node, child.second);
	}
}

void
DLStylerNodeInvalidateChildrenMatchingSelector(DLStylerNodeRef node, DLStylerStyleSelectorTreeRef tree)
{
	for (auto &element : node->shadowed) {

		if (DLStylerMatchSelector(element, tree->selector)) {
			DLStylerNodeInvalidate(element);
		}

		for (auto &child : tree->children) {
			DLStylerNodeInvalidateChildrenMatchingSelector(element, child.second);
		}
	}
}

void
DLStylerNodeApply(DLStylerNodeRef node, const DLStylerStyleItemRefMap &items)
{
	const size_t size = items.size();
	if (size == 0) {
		return;
	}

	vector<DLStylerStyleItemRef> styles;

	styles.reserve(size);

	for (auto &pair : items) {
		styles.push_back(pair.second);
	}

	/*
	 * Sort the properties to make sure they are applied in the way they
	 * appear from the styles file.
	 */
	// TODO
	// Maybe this is not required...
	sort(
		styles.begin(),
		styles.end(),
		DLStylerStyleApplyOrder
	);

	for (auto &item : styles) {
		node->applyCallback(node, item);
	}
}

void
DLStylerNodePrintName(DLStylerNodeRef node)
{
	if (node->id != "") {
		std::cout << "[#";
		std::cout << node->id;
		std::cout << "] ";
	}

	std::cout << node->type;

	for (auto &style : node->styles) {
		std::cout << ".";
		std::cout << style;
	}

	for (auto &state : node->states) {
		std::cout << ":";
		std::cout << state;
	}
}
