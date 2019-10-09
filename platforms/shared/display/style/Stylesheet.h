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

	vector<Ruleset*> rulesets;
	unordered_map<string, Variable*> variables;
	unordered_map<string, Function*> functions;

	unordered_map<string, vector<Ruleset*>> map;

public:

	friend class Parser;

	const vector<Ruleset*>& getRulesets() const {
		return this->rulesets;
	}

	const unordered_map<string, Variable*>& getVariables() const {
		return this->variables;
	}

	const unordered_map<string, Function*>& getFunctions() const {
		return this->functions;
	}

	void addFunction(string name, Function* function);
	void addVariable(string name, Variable* variable);

	void addRuleset(Ruleset* ruleset);

};

}
}

#endif
