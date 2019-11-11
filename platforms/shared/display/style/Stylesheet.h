#ifndef Stylesheet_h
#define Stylesheet_h

#include "Function.h"
#include "Variable.h"
#include "Trait.h"

#include <string>
#include <vector>
#include <unordered_map>

namespace Dezel {
	class Display;
	class DisplayNode;
}

namespace Dezel {
namespace Style {

using std::string;
using std::vector;
using std::unordered_map;

using Style::Trait;

class Paser;
class Descriptor;

class Stylesheet {

private:

	vector<Descriptor*> rootDescriptors;
	vector<Descriptor*> ruleDescriptors;
	vector<Descriptor*> typeDescriptors;
	vector<Descriptor*> styleDescriptors;
	vector<Descriptor*> stateDescriptors;

	unordered_map<string, Variable*> variables;
	unordered_map<string, Function*> functions;

public:

	friend class Parser;

	void addVariable(Variable* variable);
	void addFunction(Function* function);
	void addDescriptor(Descriptor* descriptor);

	const vector<Descriptor*>& getRootDescriptors() const {
		return this->rootDescriptors;
	}

	const vector<Descriptor*>& getRuleDescriptors() const {
		return this->ruleDescriptors;
	}

	const vector<Descriptor*>& getTypeDescriptors() const {
		return this->typeDescriptors;
	}

	const vector<Descriptor*>& getStyleDescriptors() const {
		return this->styleDescriptors;
	}

	const vector<Descriptor*>& getStateDescriptors() const {
		return this->stateDescriptors;
	}

	const unordered_map<string, Variable*>& getVariables() const {
		return this->variables;
	}

	const unordered_map<string, Function*>& getFunctions() const {
		return this->functions;
	}

};

}
}

#endif
