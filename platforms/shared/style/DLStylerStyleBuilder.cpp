#include <string>
#include <vector>
#include <algorithm>
#include "DLStyler.h"
#include "DLStylerPrivate.h"
#include "DLStylerStyleBuilder.h"
#include "DLStylerStyleRule.h"
#include "DLStylerStyleRulePrivate.h"
#include "DLStylerStyleItem.h"
#include "DLStylerStyleItemPrivate.h"
#include "DLStylerStyleSelector.h"
#include "DLStylerStyleSelectorPrivate.h"
#include "DLStylerStyleSelectorTree.h"
#include "DLStylerStyleSelectorTreePrivate.h"

#define SNG_QUOTE '\''
#define DBL_QUOTE '\"'

using std::advance;
using std::string;
using std::vector;
using std::list;
using std::sort;
using std::prev;
using std::stod;

static string
camelize(string str) {

	string tmp;

	for (int i = 0; i < str.length(); i++){

        if (str[i] == '-') {

			tmp = str.substr(i + 1, 1);

			transform(
				tmp.begin(),
				tmp.end(),
				tmp.begin(),
				::toupper
			);

            str.erase(i, 2);
            str.insert(i, tmp);
       }
    }

	return str;
}

void
DLStylerStyleBuilder::writeAtRule(const Token &keyword, const TokenList &rule)
{
}

void
DLStylerStyleBuilder::writeRulesetStart(const Selector &selectors)
{
	for (auto &list : selectors) {

		DLStylerStyleRuleRef rule = new OpaqueDLStylerStyleRule();
		DLStylerStyleSelectorRef selector = new OpaqueDLStylerStyleSelector();
		DLStylerStyleSelectorRef previous = NULL;

		for (auto &token : list) {

			if (token.type == Token::WHITESPACE) {

				if (previous) {
					previous->next = selector;
					selector->prev = previous;
				} else {
					rule->head = selector;
				}

				if (rule->name.length() > 0) {
					rule->name.append(" ");
				}

				rule->selectors.push_back(selector);

				previous = selector;
				selector = new OpaqueDLStylerStyleSelector();
				continue;
			}

			const string str = token.c_str();

			if (str == ".") {
				selector->name.append(".");
				continue;
			}

			if (str == ":") {
				selector->name.append(":");
				continue;
			}

			if (token.type == Token::IDENTIFIER) {

				if (selector->name.length() && selector->name.back() == '.') {
					selector->name.append(str);
					selector->traits.insert(str);
					continue;
				}

				if (selector->name.length() && selector->name.back() == ':') {
					selector->name.append(str);
					selector->states.insert(str);
					continue;
				}

				selector->type = str;
				selector->name.append(str);
			}
		}

		if (previous) {
			previous->next = selector;
			selector->prev = previous;
		}

		rule->tail = selector;

		if (rule->head == NULL) {
			rule->head = selector;
		}

		rule->selectors.push_back(selector);

		for (auto &selector : rule->selectors) {

			if (rule->name.length() > 0) {
				rule->name.append(" ");
			}

			rule->name.append(selector->name);
		}

		rule->position = ++rules_count;

		new_rules.push_back(rule);
	}
}

void
DLStylerStyleBuilder::writeRulesetEnd()
{
	for (auto &rule : new_rules) {
		all_rules.push_back(rule);
	}

	new_rules.clear();
}

void
DLStylerStyleBuilder::writeDeclaration(const Token &prop, const TokenList &vals)
{
	if (vals.size() > 1) {

		DLStylerStyleItemRef item = new OpaqueDLStylerStyleItem;
		item->property = camelize(prop.c_str());
		item->type = kDLStylerStyleItemTypeString;
		item->unit = kDLStylerStyleItemUnitNone;
		item->num_value = 0;
		item->boo_value = false;

		item->position = ++items_count;

		for (auto &token : vals) {
			item->str_value.append(token.c_str());
			item->raw_value.append(token.c_str());
		}

		for (auto &rule : new_rules) {
			rule->items[item->property] = item;
		}

		return;
	}

	auto token = vals.front();

	string str = token.c_str();
	string u2;
	string u3;

	if (str.front() == SNG_QUOTE ||
		str.front() == DBL_QUOTE) {
		str.erase(0, 1);
	}

	if (str.back() == SNG_QUOTE ||
		str.back() == DBL_QUOTE) {
		str.erase(str.size() - 1);
	}

	DLStylerStyleItemRef item = new OpaqueDLStylerStyleItem;
	item->property = camelize(prop.c_str());
	item->raw_value.append(str);
	item->str_value.append(str);

	item->position = ++items_count;

	if (token.type == Token::WHITESPACE) {
		item->type = kDLStylerStyleItemTypeString;
		item->unit = kDLStylerStyleItemUnitNone;
		return;
	}

	if (str == "null") {

		item->type = kDLStylerStyleItemTypeNull;
		item->unit = kDLStylerStyleItemUnitNone;

	} else if (str == "true") {

		item->type = kDLStylerStyleItemTypeBoolean;
		item->unit = kDLStylerStyleItemUnitNone;
		item->boo_value = true;

	} else if (str == "false") {

		item->type = kDLStylerStyleItemTypeBoolean;
		item->unit = kDLStylerStyleItemUnitNone;
		item->boo_value = false;

	} else {

		switch (token.type) {

			case Token::NUMBER:
				item->type = kDLStylerStyleItemTypeNumber;
				item->unit = kDLStylerStyleItemUnitNone;
				item->num_value = stod(str);
				break;

			case Token::PERCENTAGE:
				item->type = kDLStylerStyleItemTypeNumber;
				item->unit = kDLStylerStyleItemUnitPC;
				item->num_value = stod(str);
				break;

			case Token::DIMENSION:

				u2 = str.substr(str.length() - 2);
				u3 = str.substr(str.length() - 3);

				item->type = kDLStylerStyleItemTypeNumber;

				if (u2 == "px") {
					item->unit = kDLStylerStyleItemUnitPX;
				} else if (u2 == "vw") {
					item->unit = kDLStylerStyleItemUnitVW;
				} else if (u2 == "vh") {
					item->unit = kDLStylerStyleItemUnitVH;
				} else if (u2 == "pw") {
					item->unit = kDLStylerStyleItemUnitPW;
				} else if (u2 == "ph") {
					item->unit = kDLStylerStyleItemUnitPH;
				} else if (u2 == "cw") {
					item->unit = kDLStylerStyleItemUnitCW;
				} else if (u2 == "ch") {
					item->unit = kDLStylerStyleItemUnitCH;
				} else if (u3 == "deg") {
					item->unit = kDLStylerStyleItemUnitDeg;
				} else if (u3 == "rad") {
					item->unit = kDLStylerStyleItemUnitRad;
				}

				item->num_value = stod(str);

				break;

			default:
				item->type = kDLStylerStyleItemTypeString;
				item->unit = kDLStylerStyleItemUnitNone;
				item->str_value = str;
				break;
		}
	}

	for (auto &rule : new_rules) {
		rule->items[item->property] = item;
	}
}

void
DLStylerStyleBuilder::writeDeclarationDeliminator()
{
}

void
DLStylerStyleBuilder::writeComment(const Token &comment)
{
}

void
DLStylerStyleBuilder::writeMediaQueryStart(const TokenList &selector)
{
}

void
DLStylerStyleBuilder::writeMediaQueryEnd()
{
}

void
DLStylerStyleBuilder::build()
{
	vector<DLStylerStyleRuleRef> rules;
	vector<DLStylerStyleRuleRef> types;

	expand_rules();

	/*
	 * Once we have all the rules, we need to compute its weight. This is done
	 * by adding the sum of all its selectors' weight. Using the weight we
	 * can differentiate rules that define a type from rules that are basically
	 * a path to a node. Type rules are rule that contains a single selector
	 * that identifies a type without traits or states.
	 */

	for (auto &rule : all_rules) {

		for (auto &selector : rule->selectors) {
			rule->weight += 1;
			rule->weight += selector->traits.size() * 100;
			rule->weight += selector->states.size() * 1000;
		}

		if (rule->weight == 1) {

			auto selector = rule->head;

			if (selector->type != "*" &&
				selector->traits.size() == 0 &&
				selector->states.size() == 0) {
				types.push_back(rule);
				continue;
			}
		}

		rules.push_back(rule);
	}

	merge_types(types);
	merge_rules(rules);
	build_tree();
}

void
DLStylerStyleBuilder::expand_rules()
{
	unordered_map<string, DLStylerStyleRuleRef> existing_rules;

	for (auto &rule : all_rules) {
		existing_rules[rule->name] = rule;
	}

	vector<DLStylerStyleRuleRef> rules;

	/*
	 * Some selectors are basically containers. They do not define any
	 * properties but they specify a hierarchy. We need to create empty rule
	 * for these only so they can invalidate the child rules upon being matched.
	 */

	for (auto &rule : all_rules) {

		if (rule->selectors.size() == 1) {

			/*
		 	 * Since what we're doing here is only used to properly invalidate
		 	 * child styles, if the rule only has one selector it means
		 	 * there will be no child to invalidate on this rule. skip.
		 	 */

			continue;
		}

		vector<DLStylerStyleSelectorRef> selectors;

		string name = "";

		for (auto &selector : rule->selectors) {

			if (selector == rule->tail) {
				break;
			}

			if (name.length() > 0) {
				name.append(" ");
			}

			name.append(selector->name);

			selectors.push_back(selector);

			if (existing_rules.count(name) == 0) {

				DLStylerStyleRuleRef new_rule = new OpaqueDLStylerStyleRule;
				new_rule->name = name;
				new_rule->head = selectors[0];
				new_rule->tail = selectors.back();
				new_rule->selectors = selectors;
				new_rule->position = rule->position;
				existing_rules[name] = new_rule;

				rules.push_back(new_rule);
			}
		}
	}

	all_rules.insert(
		all_rules.end(),
		rules.begin(),
		rules.end()
	);
}

void
DLStylerStyleBuilder::merge_types(const vector<DLStylerStyleRuleRef> &types)
{
	for (auto &type : types) {

		if (context->types.count(type->name) == 0) {
			context->types[type->name] = type->items;
			continue;
		}

		for (auto &item : type->items) {
			auto key = item.first;
			auto val = item.second;
			context->types[type->name][key] = val;
		}
	}
}

void
DLStylerStyleBuilder::merge_rules(const vector<DLStylerStyleRuleRef> &rules)
{
	for (auto &rule : rules) {

		if (context->rules.count(rule->name) == 0) {
			context->rules[rule->name] = rule;
			continue;
		}

		for (auto &item : rule->items) {
			auto key = item.first;
			auto val = item.second;
			context->rules[rule->name]->items[key] = val;
		}
	}
}

void
DLStylerStyleBuilder::build_tree()
{
	/*
	 * Builds the relationship tree between selectors. This is useful to
	 * determine child element from a selector that needs to be invalidated
	 * when a parent selector is invalidated
	 */

	if (context->selector_tree == NULL) {
		context->selector_tree = new OpaqueDLStylerStyleSelectorTree;
	}

	for (auto &pair : context->rules) {

		auto rule = pair.second;
		auto tree = context->selector_tree;
		auto path = string("");

		for (auto &selector : rule->selectors) {

			auto name = selector->name;

			if (path.length() > 0) {
				path.append(" ");
			}

			path.append(name);

			if (tree->children.count(name) == 0) {
				tree->children[name] = new OpaqueDLStylerStyleSelectorTree;
				tree->children[name]->name = name;
				tree->children[name]->selector = selector;
			}

			tree = tree->children[name];

			if (path == selector->name) {
				tree->selector = selector;
			}
		}
	}
}


