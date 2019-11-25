#include "DisplayNodePropertyRef.h"
#include "Property.h"
#include "Value.h"
#include "StringValue.h"
#include "NumberValue.h"
#include "BooleanValue.h"

#include <string>

using Dezel::Style::Property;
using Dezel::Style::Value;
using Dezel::Style::ValueType;
using Dezel::Style::ValueUnit;
using Dezel::Style::StringValue;
using Dezel::Style::NumberValue;
using Dezel::Style::BooleanValue;

using std::string;

const char*
DisplayNodePropertyGetName(DisplayNodePropertyRef property)
{
	return reinterpret_cast<Property*>(property)->getName().c_str();
}

unsigned
DisplayNodePropertyGetValueCount(DisplayNodePropertyRef property)
{
	return static_cast<unsigned>(reinterpret_cast<Property*>(property)->getValues().size());
}

DisplayNodePropertyValueType
DisplayNodePropertyGetValueType(DisplayNodePropertyRef property, unsigned index)
{
	return static_cast<DisplayNodePropertyValueType>(reinterpret_cast<Property*>(property)->getValues().at(index)->getType());
}

DisplayNodePropertyValueUnit
DisplayNodePropertyGetValueUnit(DisplayNodePropertyRef property, unsigned index)
{
	return static_cast<DisplayNodePropertyValueUnit>(reinterpret_cast<Property*>(property)->getValues().at(index)->getUnit());
}

const char*
DisplayNodePropertyGetValueAsString(DisplayNodePropertyRef property, unsigned index)
{
	return reinterpret_cast<StringValue*>(
		reinterpret_cast<Property*>(property)->getValues().at(index)
	)->getValue().c_str();
}

double
DisplayNodePropertyGetValueAsNumber(DisplayNodePropertyRef property, unsigned index)
{
	return reinterpret_cast<NumberValue*>(
		reinterpret_cast<Property*>(property)->getValues().at(index)
	)->getValue();
}

bool
DisplayNodePropertyGetValueAsBoolean(DisplayNodePropertyRef property, unsigned index)
{
	return reinterpret_cast<BooleanValue*>(
		reinterpret_cast<Property*>(property)->getValues().at(index)
	)->getValue();
}

void
DisplayNodePropertyInsertValueWithString(DisplayNodePropertyRef property, unsigned index, const char* value)
{
	reinterpret_cast<Property*>(property)->insertValue(index, new StringValue(value));
}

void
DisplayNodePropertyInsertValueWithNumber(DisplayNodePropertyRef property, unsigned index, double value, DisplayNodePropertyValueUnit unit)
{
	reinterpret_cast<Property*>(property)->insertValue(index, new NumberValue(value, static_cast<ValueUnit>(unit)));
}

void
DisplayNodePropertyInsertValueAsBoolean(DisplayNodePropertyRef property, unsigned index, bool value)
{
	reinterpret_cast<Property*>(property)->insertValue(index, new BooleanValue(value));
}
