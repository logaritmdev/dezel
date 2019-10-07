#include "StringValue.h"

namespace Dezel {
namespace Style {

StringValue::StringValue(string value) : Value(kValueTypeString, kValueUnitNone), value(value)
{

}

string
StringValue::toString()
{
	return this->value;
}

}
}
