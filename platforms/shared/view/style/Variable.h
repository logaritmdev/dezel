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

class Variable {

private:

	string name;
	vector<Value*> values;

public:

	friend class Parser;

	Variable(string name);

	string toString();

};

}
}

#endif
