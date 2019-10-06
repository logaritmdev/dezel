#include "Argument.h"

namespace Dezel {
namespace Style {

string
Argument::toString()
{
	string output;

	for (auto value : this->values) {

		if (output.length()) {
			output.append(" ");
		}

		output.append(value->toString());
	}

	return output;
}

}
}
