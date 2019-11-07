#include "Property.h"
#include "FunctionValue.h"
#include "Value.h"

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

Property::Property(string name) : name(name)
{

}

string
Property::toString(int depth)
{
	string output;

	output.append(depth * 2, ' ');

	output.append(this->name);
	output.append(":");
	output.append(" ");

	for (auto value : this->values) {
		output.append(value->toString());
	}

	return output;
}

}
}
