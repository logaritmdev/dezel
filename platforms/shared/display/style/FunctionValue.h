#ifndef FunctionValue_h
#define FunctionValue_h

#include "Argument.h"
#include "Value.h"

#include <string>
#include <vector>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;

class Parser;
class Stylesheet;

class FunctionValue : public Value {

private:

	string name;
	vector<Argument*> arguments;

public:

	friend class Parser;
	friend class Stylesheet;

	FunctionValue(string name);

	string getName() const {
		return this->name;
	}

	string toString();

};

}
}

#endif
