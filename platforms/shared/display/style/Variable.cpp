#include "Variable.h"

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

Variable::Variable(string name) : name(name)
{

}

string
Variable::toString()
{
	string output;

	output.append("$");
	output.append(this->name);
	output.append(":");
	output.append(" ");

	for (auto value : this->  values) {
		output.append(value->toString());
		output.append(" ");
	}

	output.append("\n");

	return output;
}

}
}
