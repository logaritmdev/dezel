#include "FunctionValue.h"
#include "Stylesheet.h"

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

FunctionValue::FunctionValue(string name) : Value(kValueTypeFunction, kValueUnitNone), name(name)
{

}

FunctionValue::~FunctionValue()
{
	for (auto argument : this->arguments) delete argument;
}

bool
FunctionValue::evaluate(Stylesheet* stylesheet, vector<Value*>& result)
{
	auto function = stylesheet->getFunction(this->name);

	if (function) {
		function->invoke(this->arguments, result);
		return true;
	}

	return false;
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
