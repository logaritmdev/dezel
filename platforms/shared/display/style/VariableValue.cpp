#include "VariableValue.h"

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

VariableValue::VariableValue(string name) : Value(kValueTypeVariable, kValueUnitNone), name(name)
{

}

VariableValue::~VariableValue()
{
	
}

string
VariableValue::toString()
{
	string output;
	output.append("$");
	output.append(this->name);
	return output;
}

}
}
