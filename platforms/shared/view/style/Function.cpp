#include "Function.h"

namespace Dezel {
namespace Style {

string
Function::toString(int depth)
{
	string output;

	output.append(depth * 2, ' ');
	output.append(this->name);
	output.append("(");
	output.append(")");

	return output;
}

}
}
