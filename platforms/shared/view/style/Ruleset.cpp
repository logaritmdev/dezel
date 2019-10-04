#include "Ruleset.h"
#include "Rule.h"
#include "Selector.h"

#include <iostream>

namespace Dezel {
namespace Style {

string
Ruleset::toString(int depth) {

	string output;

	for (auto rule : this->rules) {

		output.append(depth * 2, ' ');
		output.append(rule->toString());

		if (rule == this->rules.back()) {
			output.append(" ");
			output.append("{");
			output.append("\n");
		} else {
			output.append(",");
			output.append("\n");
		}

	}

	for (auto property : this->properties) {
		output.append(property->toString(depth + 1));
		output.append(";");
		output.append("\n");
	}

	for (auto child : this->children) {
		output.append(child->toString(depth + 1));
	}

	output.append(depth * 2, ' ');
	output.append("}");
	output.append("\n");

	return output;
}

}
}
