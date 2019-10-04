#include "Property.h"
#include "Function.h"
#include "Value.h"

namespace Dezel {
namespace Style {

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

	if (this->function) {

		output.append(this->function->toString());

	} else {

		for (auto value : this->values) {
			output.append(value->toString());
		}
		
	}

	return output;
}

}
}
