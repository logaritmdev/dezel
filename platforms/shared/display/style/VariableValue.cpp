#include "VariableValue.h"
#include "Stylesheet.h"

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

bool
VariableValue::evaluate(Stylesheet* stylesheet, vector<Value*>& result)
{
	auto variable = stylesheet->getVariable(this->name);

	if (variable) {

		result.insert(
			result.begin(),
			variable->getValues().begin(),
			variable->getValues().end()
		);

		return true;
	}

	return false;
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
