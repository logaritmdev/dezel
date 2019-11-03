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
class Descriptor;

class Stylesheet {

private:

	vector<Descriptor*> descriptors;
	unordered_map<string, Variable*> variables;
	unordered_map<string, Function*> functions;

	unordered_map<string, vector<Descriptor*>> map;

public:

	friend class Parser;

	const vector<Descriptor*>& getDescriptors() const {
		return this->descriptors;
	}

	const unordered_map<string, Variable*>& getVariables() const {
		return this->variables;
	}

	const unordered_map<string, Function*>& getFunctions() const {
		return this->functions;
	}

	void addVariable(Variable* variable);
	void addFunction(Function* function);
	void addDescriptor(Descriptor* descriptor);

};

}
}

#endif
