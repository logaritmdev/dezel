#ifndef Function_h
#define Function_h

#include "Argument.h"

#include <string>
#include <vector>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;

class Parser;

class Function {

private:

	string name;
	vector<Argument*> arguments;

public:

	friend class Parser;

	string toString(int depth = 0);

};

}
}

#endif
