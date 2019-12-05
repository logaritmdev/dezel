#ifndef Stylesheet_h
#define Stylesheet_h

#include "Function.h"
#include "Variable.h"

#include <iostream>
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

class Paser;
class Descriptor;

class Stylesheet {

private:

	vector<Descriptor*> rootDescriptors;
	vector<Descriptor*> ruleDescriptors;

	unordered_map<string, Variable*> variables;
	unordered_map<string, Function*> functions;

public:

	friend class Parser;

	Stylesheet();

	~Stylesheet();

	void setVariable(string name, string value);

	void evaluate(string source);
	void evaluate(string source, string url);

	void addVariable(Variable* variable);
	void addFunction(Function* function);
	void addDescriptor(Descriptor* descriptor);

	const vector<Descriptor*>& getRootDescriptors() const {
		return this->rootDescriptors;
	}

	const vector<Descriptor*>& getRuleDescriptors() const {
		return this->ruleDescriptors;
	}

	const unordered_map<string, Variable*>& getVariables() const {
		return this->variables;
	}

	const unordered_map<string, Function*>& getFunctions() const {
		return this->functions;
	}

	Variable* getVariable(string name) const {
		return this->variables.find(name) != this->variables.end() ? this->variables.at(name) : nullptr;
	}

	Function* getFunction(string name) const {
		return this->functions.find(name) != this->functions.end() ? this->functions.at(name) : nullptr;
	}
};

}
}

#endif
