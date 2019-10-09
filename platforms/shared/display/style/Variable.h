#ifndef Variable_h
#define Variable_h

#include "Value.h"

#include <string>
#include <vector>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;

class Parser;
class Stylesheet;

class Variable {

private:

	string name;
	vector<Value*> values;

public:

	friend class Parser;
	friend class Stylesheet;

	Variable(string name);

	const vector<Value*>& getValues() const {
		return this->values;
	}

	string toString();

};

}
}

#endif
