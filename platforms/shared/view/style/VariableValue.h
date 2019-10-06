#ifndef VariableValue_h
#define VariableValue_h

#include "Value.h"

#include <string>

namespace Dezel {
namespace Style {

using std::string;

class VariableValue : public Value {

private:

	string name;

public:

	friend class Parser;

	VariableValue(string name);

	string getName() const {
		return this->name;
	}

	string toString();
};

}
}

#endif
