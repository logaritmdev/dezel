#include "FunctionValue.h"

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

FunctionValue::FunctionValue(string name) : Value(kValueTypeFunction, kValueUnitNone), name(name)
{

}

string
FunctionValue::toString()
{
	string output;

	output.append(this->name);
	output.append("(");

	string arguments;

	for (auto argument : this->arguments) {

		if (arguments.length()) {
			arguments.append(",");
			arguments.append(" ");
		}

		arguments.append(argument->toString());
	}

	output.append(arguments);
	output.append(")");

	return output;
}

}
}
