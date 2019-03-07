#ifndef DLStylerPrivate_h
#define DLStylerPrivate_h

#include <set>
#include <string>
#include <vector>
#include <unordered_map>
#include "DLStylerNode.h"
#include "DLStylerStyleRule.h"
#include "DLStylerStyleRulePrivate.h"
#include "DLStylerStyleSelectorTree.h"
#include "DLStylerStyleItemPrivate.h"

/**
 * @struct OpaqueDLStyler
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLStyler {
	DLStylerNodeRef root = NULL;
	DLStylerStyleRuleRefMap rules;
	DLStylerStyleSelectorTreeRef selector_tree = NULL;
	unordered_map<string, DLStylerStyleItemRefMap> types;
	unordered_map<string, DLStylerStyleItemRefMap> cache;
	unordered_map<string, string> vars;
	bool invalid = false;
	bool resolving = false;
};

#endif
