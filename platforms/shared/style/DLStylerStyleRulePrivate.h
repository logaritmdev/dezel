#ifndef DLStylerStyleRulePrivate_h
#define DLStylerStyleRulePrivate_h

#include <string>
#include <vector>
#include <unordered_map>
#include "DLStylerStyleRule.h"
#include "DLStylerStyleSelector.h"
#include "DLStylerStyleItem.h"
#include "DLStylerStyleItemPrivate.h"

using std::string;
using std::vector;
using std::unordered_map;

/**
 * @typedef DLStylerStyleRuleRefMap
 * @since 0.3.0
 * @hidden
 */
typedef unordered_map<string, DLStylerStyleRuleRef> DLStylerStyleRuleRefMap;

/**
 * @struct OpaqueDLStylerStyleRule
 * @since 0.3.0
 * @hidden
 */
struct OpaqueDLStylerStyleRule {
	string name = "";
	DLStylerStyleSelectorRef head = NULL;
	DLStylerStyleSelectorRef tail = NULL;
	vector<DLStylerStyleSelectorRef> selectors;
	vector<DLStylerStyleRuleRef> children;
	DLStylerStyleItemRefMap items;
	int position = 0;
	int weight = 0;
};

#endif
