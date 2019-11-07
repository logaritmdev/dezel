#include "NullValue.h"

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

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
