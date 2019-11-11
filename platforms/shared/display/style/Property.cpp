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

void
Property::appendValue(Value* value)
{
	this->values.push_back(value);
}

void
Property::insertValue(size_t index, Value* value)
{
	this->values.insert(this->values.begin() + index, value);
}

void
Property::removeValue(size_t index)
{
	this->values.erase(this->values.begin() + index);
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
