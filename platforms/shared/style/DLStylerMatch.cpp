#include <iostream>
#include <vector>
#include "DLStylerMatch.h"
#include "DLStyler.h"
#include "DLStylerPrivate.h"
#include "DLStylerNode.h"
#include "DLStylerNodePrivate.h"
#include "DLStylerStyleSelector.h"
#include "DLStylerStyleSelectorPrivate.h"
#include "DLStylerStyleRule.h"
#include "DLStylerStyleRulePrivate.h"

using std::vector;

bool
DLMatchedRulesCompare(DLStylerMatchedRuleRef a, DLStylerMatchedRuleRef b)
{
	return a->rule->weight == b->rule->weight ? a->rule->position < b->rule->position : a->rule->weight < b->rule->weight;
}

void
DLStylerMatchRules(DLStylerNodeRef node, vector<DLStylerMatchedRuleRef> &matches)
{
	for (auto &pair : node->styler->rules) {

		auto name = pair.first;
		auto rule = pair.second;

		if (DLStylerMatchSelector(node, rule->tail) == false ||
			DLStylerMatchSelectorHierarchy(node, rule->tail) == false) {
			continue;
		}

		DLStylerMatchedRuleRef match = new OpaqueDLStylerMatchedRule;
		match->rule = rule;
		matches.push_back(match);
	}

	sort(
		matches.begin(),
		matches.end(),
		DLMatchedRulesCompare
	);
}

bool
DLStylerMatchSelectorType(DLStylerNodeRef node, const string &type)
{
	/*
	 * One of the node type must match the specified type unless
	 * it's an all-type.
	 */

	if (type == "*") {
		return true;
	}

	auto it = find(
		node->types.begin(),
		node->types.end(),
		type
	);

	return it != node->types.end();
}

bool
DLStylerMatchSelector(DLStylerNodeRef node, DLStylerStyleSelectorRef selector)
{
	return (
		DLStylerMatchSelectorType(node, selector->type) &&
		DLStylerMatchSelectorTraits(node, selector->traits) &&
		DLStylerMatchSelectorStates(node, selector->states)
	);
}

bool
DLStylerMatchSelectorTraits(DLStylerNodeRef node, const set<string> &styles)
{
	if (styles.size() == 0) {
		return true;
	}

	for (auto &style : styles) {

		auto it = find(
			node->styles.begin(),
			node->styles.end(),
			style
		);

		if (it != node->styles.end()) {
			return true;
		}
	}

	return false;
}

bool
DLStylerMatchSelectorStates(DLStylerNodeRef node, const set<string> &states)
{
	if (states.size() == 0) {
		return true;
	}

	for (auto &state : states) {

		if (state == "first-child" ||
			state == "last-child") {

			if (state == "first-child" && node->parent->children[0] == node) {
				return true;
			}

			if (state == "last-child" && node->parent->children.back() == node) {
				return true;
			}

			return false;
		}

		auto it = find(
			node->states.begin(),
			node->states.end(),
			state
		);

		if (it != node->states.end()) {
			return true;
		}
	}

	return false;
}

bool
DLStylerMatchSelectorHierarchy(DLStylerNodeRef node, DLStylerStyleSelectorRef expression)
{
	// TODO
	// Allow other selectors in between that are possibly not the shadow root.

	DLStylerNodeRef host = node->host;
	DLStylerStyleSelectorRef prev = expression->prev;

	while (host && prev) {

		if (DLStylerMatchSelector(host, prev) == false) {
			return false;
		}

		host = host->host;
		prev = prev->prev;
	}

	return true;
}
