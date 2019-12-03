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
	~FunctionValue();

	const string& getName() const {
		return this->name;
	}

	const vector<Argument*>& getArguments() {
		return this->arguments;
	}

	bool evaluate(Stylesheet* stylesheet, vector<Value*>& result);

	string toString();

};

}
}

#endif
