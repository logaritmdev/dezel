#include <string>
#include "DLStylerStyleItem.h"
#include "DLStylerStyleItemPrivate.h"

using std::string;

const char*
DLStylerStyleItemGetProperty(DLStylerStyleItemRef item)
{
	return item->property.c_str();
}

void
DLStylerStyleItemSetValueType(DLStylerStyleItemRef item, DLStylerStyleItemType type)
{
	item->type = type;
}

DLStylerStyleItemType
DLStylerStyleItemGetValueType(DLStylerStyleItemRef item)
{
	return item->type;
}

void
DLStylerStyleItemSetValueUnit(DLStylerStyleItemRef item, DLStylerStyleItemUnit unit)
{
	item->unit = unit;
}

DLStylerStyleItemUnit
DLStylerStyleItemGetValueUnit(DLStylerStyleItemRef item)
{
	return item->unit;
}

void
DLStylerStyleItemSetValueWithString(DLStylerStyleItemRef item, const char* value)
{
	item->str_value = string(value);
}

const char*
DLStylerStyleItemGetValueAsString(DLStylerStyleItemRef item)
{
	return item->str_value.c_str();
}

void
DLStylerStyleItemSetValueWithNumber(DLStylerStyleItemRef item, double value)
{
	item->num_value = value;
}

double
DLStylerStyleItemGetValueAsNumber(DLStylerStyleItemRef item)
{
	return item->num_value;
}

void
DLStylerStyleItemSetValueWithBoolean(DLStylerStyleItemRef item, bool value)
{
	item->boo_value = value;
}

bool
DLStylerStyleItemGetValueAsBoolean(DLStylerStyleItemRef item)
{
	return item->boo_value;
}

void
DLStylerStyleItemSetData(DLStylerStyleItemRef item, void *data)
{
	item->data = data;
}

void*
DLStylerStyleItemGetData(DLStylerStyleItemRef item)
{
	return item->data;
}
