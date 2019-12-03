#ifndef Argument_h
#define Argument_h

#include "Value.h"

#include <string>
#include <vector>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;

class Parser;
class Stylesheet;

class Argument {

private:

	vector<Value*> values;

public:

	friend class Parser;
	friend class Stylesheet;

	~Argument();

	const vector<Value*>& getValues() const {
		return this->values;
	}

	string toString();

};

}
}

#endif
