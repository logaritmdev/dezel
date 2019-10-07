#ifndef Stylesheet_h
#define Stylesheet_h

#include "Function.h"
#include "Variable.h"

#include <string>
#include <vector>
#include <unordered_map>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;
using std::unordered_map;

class Paser;
class Ruleset;

class Stylesheet {

private:

	unordered_map<string, Function*> functions;
	unordered_map<string, Variable*> variables;
	vector<Ruleset*> rulesets;

public:

	friend class Parser;

	void registerFunction(string name, Function* function);
	void registerVariable(string name, Variable* variable);

	void addRuleset(Ruleset* ruleset);

};

}
}

#endif
