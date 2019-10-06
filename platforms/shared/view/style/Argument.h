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

class Argument {

private:

	vector<Value*> values;

public:

	friend class Parser;

	string toString();

};

}
}

#endif
