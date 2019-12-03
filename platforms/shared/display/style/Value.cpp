#include "Value.h"



namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

Value::~Value()
{

}

Value::Value(ValueType type, ValueUnit unit) : type(type), unit(unit)
{
	
}

}
}
