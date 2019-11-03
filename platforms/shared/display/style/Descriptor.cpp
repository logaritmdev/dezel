#include "Descriptor.h"
#include "Selector.h"
#include "Fragment.h"

#include <iostream>

namespace Dezel {
namespace Style {

string
Descriptor::toString(int depth) {

	string output;

	output.append(depth * 2, ' ');
	output.append(this->selector->toString());

	output.append(" ");
	output.append("{");
	output.append("\n");

	for (auto property : this->properties) {
		output.append(property->toString(depth + 1));
		output.append(";");
		output.append("\n");
	}

	for (auto style : this->styleDescriptors) {
		output.append(style->toString(depth + 1));
	}

	for (auto state : this->stateDescriptors) {
		output.append(state->toString(depth + 1));
	}

	for (auto child : this->childDescriptors) {
		output.append(child->toString(depth + 1));
	}

	output.append(depth * 2, ' ');
	output.append("}");
	output.append("\n");

	return output;
}

}
}
