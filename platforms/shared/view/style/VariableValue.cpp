#include "VariableValue.h"

namespace Dezel {
namespace Style {

VariableValue::VariableValue(string name) : Value(kValueTypeVariable, kValueUnitNone), name(name)
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
