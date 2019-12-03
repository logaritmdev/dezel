#include "StringValue.h"

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

StringValue::StringValue(string value) : Value(kValueTypeString, kValueUnitNone), value(value)
{

}

StringValue::StringValue(const char* value) : Value(kValueTypeString, kValueUnitNone), value(string(value))
{

}

StringValue::~StringValue()
{

}

string
StringValue::toString()
{
	return this->value;
}

}
}
