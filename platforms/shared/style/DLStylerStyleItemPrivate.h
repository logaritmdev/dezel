#ifndef DLStylerStyleItemPrivate_hpp
#define DLStylerStyleItemPrivate_hpp

#include <string>
#include <vector>
#include <unordered_map>
#include "DLStylerStyleItem.h"

using std::string;
using std::vector;
using std::unordered_map;

/**
 * @typedef DLStylerStyleItemRefMap
 * @since 0.3.0
 * @hidden
 */
typedef unordered_map<string, DLStylerStyleItemRef> DLStylerStyleItemRefMap;

/**
 * @struct OpaqueDLStylerStyleItem
 * @since 0.3.0
 * @hidden
 */
struct OpaqueDLStylerStyleItem {
	string property = "";
	DLStylerStyleItemType type = kDLStylerStyleItemTypeNull;
	DLStylerStyleItemUnit unit = kDLStylerStyleItemUnitNone;
	string raw_value = "";
	string str_value = "";
	double num_value = 0;
	bool   boo_value = false;
	void*  data = NULL;
	int    position = 0;
};

#endif /* DLStylerStyleItemPrivate_hpp */
