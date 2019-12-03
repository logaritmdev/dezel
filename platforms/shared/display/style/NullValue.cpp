#include "NullValue.h"

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

NullValue::NullValue() : Value(kValueTypeNull, kValueUnitNone)
{

}

NullValue::~NullValue()
{

}

string
NullValue::toString()
{
	return "null";
}

}
}
