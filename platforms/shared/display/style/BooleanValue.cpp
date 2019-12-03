#include "BooleanValue.h"

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

BooleanValue::BooleanValue(bool value) : Value(kValueTypeBoolean, kValueUnitNone), value(value)
{

}

BooleanValue::~BooleanValue()
{

}

string
BooleanValue::toString()
{
	return std::to_string(this->value);
}

}
}
