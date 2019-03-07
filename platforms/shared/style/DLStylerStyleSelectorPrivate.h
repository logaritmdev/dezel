#ifndef DLStylerStyleSelectorPrivate_h
#define DLStylerStyleSelectorPrivate_h

#include <set>
#include <string>
#include <vector>
#include "DLStylerStyleSelector.h"

using std::set;
using std::string;
using std::vector;

/**
 * @struct OpaqueDLStylerStyleSelector
 * @since 0.3.0
 * @hidden
 */
struct OpaqueDLStylerStyleSelector {
	string name = "";
	string type = "*";
	set<string> traits;
	set<string> states;
	DLStylerStyleSelectorRef prev = NULL;
	DLStylerStyleSelectorRef next = NULL;
};

#endif
