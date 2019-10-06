#include "BooleanValue.h"

namespace Dezel {
namespace Style {

BooleanValue::BooleanValue(bool value) : Value(kValueTypeBoolean, kValueUnitNone), value(value)
{

}

string
BooleanValue::toString()
{
	return std::to_string(this->value);
}

}
}
