#include "StringValue.h"

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

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
