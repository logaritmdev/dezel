#include "Stylesheet.h"
#include "Descriptor.h"
#include "Function.h"
#include "Variable.h"
#include "Selector.h"
#include "Fragment.h"

namespace Dezel {
namespace Style {


//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

void
Stylesheet::addDescriptor(Descriptor* descriptor)
{
	if (descriptor->parent == nullptr) {
		this->rootDescriptors.push_back(descriptor);
	}

	if (descriptor->properties.size() > 0) {
		this->ruleDescriptors.push_back(descriptor);
	}

	for (auto child : descriptor->childDescriptors) {
		this->addDescriptor(child);
	}

	for (auto style : descriptor->styleDescriptors) {
		this->addDescriptor(style);
	}

	for (auto state : descriptor->stateDescriptors) {
		this->addDescriptor(state);
	}
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

void
Stylesheet::find(DisplayNode* node, vector<Descriptor*>& result)
{

}

}
}
