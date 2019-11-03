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

	return output;
}

}
}
