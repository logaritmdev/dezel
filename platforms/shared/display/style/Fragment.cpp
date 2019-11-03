#include "Fragment.h"
#include "Selector.h"

namespace Dezel {
namespace Style {

string
Fragment::toString(int depth)
{
	string output;

	output.append(this->type);

	if (this->name.size()) {
		output.append("#");
		output.append(this->name);
	}

	if (this->style.size()) {
		output.append("@style ");
		output.append(this->style);
	}

	if (this->state.size()) {
		output.append("@state ");
		output.append(this->state);
	}

	return output;
}

}
}
