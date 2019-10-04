#ifndef Stylesheet_h
#define Stylesheet_h

#include "Function.h"
#include "Variable.h"

#include <string>
#include <unordered_map>

namespace Dezel {
namespace Style {

using std::string;
using std::unordered_map;

class Stylesheet {

private:

	unordered_map<string, Function> functions;
	unordered_map<string, Variable> variables;

public:


};

}
}

#endif
