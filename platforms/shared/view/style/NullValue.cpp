#include "NullValue.h"

namespace Dezel {
namespace Style {

NullValue::NullValue() : Value(kValueTypeNull, kValueUnitNone)
{

}

string
NullValue::toString()
{
	return "null";
}

}
}
