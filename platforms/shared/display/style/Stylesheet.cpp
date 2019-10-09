#include "Stylesheet.h"
#include "Function.h"
#include "Variable.h"

namespace Dezel {
namespace Style {

void
Stylesheet::addFunction(string name, Function* function)
{
	this->functions[name] = function;
}

void
Stylesheet::addVariable(string name, Variable* variable)
{
	this->variables[name] = variable;
}

void
Stylesheet::addRuleset(Ruleset* ruleset)
{
	this->rulesets.push_back(ruleset);
}

}
}
