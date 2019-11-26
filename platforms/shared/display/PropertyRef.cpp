#include "PropertyRef.h"
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
PropertyGetName(PropertyRef property)
{
	return reinterpret_cast<Property*>(property)->getName().c_str();
}

unsigned
PropertyGetValueCount(PropertyRef property)
{
	return static_cast<unsigned>(
		reinterpret_cast<Property*>(property)->getValues().size()
	);
}

PropertyValueType
PropertyGetValueType(PropertyRef property, unsigned index)
{
	return static_cast<PropertyValueType>(
		reinterpret_cast<Property*>(property)->getValues().at(index)->getType()
	);
}

PropertyValueUnit
PropertyGetValueUnit(PropertyRef property, unsigned index)
{
	return static_cast<PropertyValueUnit>(
		reinterpret_cast<Property*>(property)->getValues().at(index)->getUnit()
	);
}

const char*
PropertyGetValueAsString(PropertyRef property, unsigned index)
{
	return reinterpret_cast<StringValue*>(
		reinterpret_cast<Property*>(property)->getValues().at(index)
	)->getValue().c_str();
}

double
PropertyGetValueAsNumber(PropertyRef property, unsigned index)
{
	return reinterpret_cast<NumberValue*>(
		reinterpret_cast<Property*>(property)->getValues().at(index)
	)->getValue();
}

bool
PropertyGetValueAsBoolean(PropertyRef property, unsigned index)
{
	return reinterpret_cast<BooleanValue*>(
		reinterpret_cast<Property*>(property)->getValues().at(index)
	)->getValue();
}
