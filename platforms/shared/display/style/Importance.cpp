#include "Importance.h"

namespace Dezel {
namespace Style {

using std::to_string;

string
Importance::toString() const
{
	string output;
	output.append("[");
	output.append("name: ");
	output.append(to_string(this->name));
	output.append(" ");
	output.append("type: ");
	output.append(to_string(this->type));
	output.append(" ");
	output.append("style: ");
	output.append(to_string(this->style));
	output.append(" ");
	output.append("state: ");
	output.append(to_string(this->state));
	output.append("]");
	return output;
}

}
}
