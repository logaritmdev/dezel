#ifndef DLStylerStyleSelectorTreePrivate_h
#define DLStylerStyleSelectorTreePrivate_h

#include <string>
#include <vector>
#include <unordered_map>
#include "DLStylerStyleRule.h"
#include "DLStylerStyleSelector.h"
#include "DLStylerStyleSelectorTree.h"

using std::string;
using std::vector;
using std::unordered_map;

/**
 * @typedef OpaqueDLStylerStyleSelectorTree
 * @since 0.3.0
 */
struct OpaqueDLStylerStyleSelectorTree {
	string name = "";
	DLStylerStyleSelectorRef selector = NULL;
	unordered_map<string, DLStylerStyleSelectorTreeRef> children;
};

#endif
