#include "PropertyRef.h"
#include "Property.h"
#include "Value.h"
#include "StringValue.h"
#include "NumberValue.h"
#include "BooleanValue.h"

#include <string>
#include <vector>

using std::string;
using std::vector;

using Dezel::Style::Property;
using Dezel::Style::Value;
using Dezel::Style::StringValue;
using Dezel::Style::NumberValue;
using Dezel::Style::BooleanValue;

const char*
PropertyGetName(PropertyRef property)
{
	return reinterpret_cast<Property*>(property)->getName().c_str();
}

ValueListRef
PropertyGetValues(PropertyRef property)
{
	return reinterpret_cast<ValueListRef>(
		const_cast<vector<Value*>*>(&reinterpret_cast<Property*>(property)->getValues())
	);
}

