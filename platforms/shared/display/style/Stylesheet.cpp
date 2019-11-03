#include "Stylesheet.h"
#include "Function.h"
#include "Variable.h"

namespace Dezel {
namespace Style {

void
Stylesheet::addDescriptor(Descriptor* ruleset)
{
	this->descriptors.push_back(ruleset);
}

void
Stylesheet::addVariable(Variable* variable)
{
	this->variables[variable->name] = variable;
}

void
Stylesheet::addFunction(Function* function)
{
	this->functions[function->name] = function;
}

}
}
