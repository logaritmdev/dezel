#include "Selector.h"
#include "Rule.h"

namespace Dezel {
namespace Style {

string
Selector::toString(int depth)
{
	string output;

	if (this->modifier) {
		output.append("&");
	}

	output.append(this->type);

	if (this->name.size()) {
		output.append("#");
		output.append(this->name);
	}

	for (auto style : this->styles) {
		output.append(".");
		output.append(style);
	}

	for (auto state : this->states) {
		output.append(":");
		output.append(state);
	}

	return output;
}

}
}
