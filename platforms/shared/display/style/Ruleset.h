#ifndef Ruleset_h
#define Ruleset_h

#include "Rule.h"
#include "Property.h"
#include "PropertyList.h"

#include <string>
#include <vector>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;

class Parser;
class Stylesheet;
class Selector;
class SelectorList;

class Ruleset {

private:

	Ruleset* parent = nullptr;
	vector<Rule*> rules;
	vector<Ruleset*> children;

	PropertyList properties;

public:

	friend class Parser;
	friend class Stylesheet;

	Ruleset* getParent() const {
		return this->parent;
	}

	const vector<Rule*>& getRules() const {
		return this->rules;
	}

	const vector<Ruleset*>& getChildren() const {
		return this->children;
	}

	const PropertyList& getProperties() const {
		return this->properties;
	}

	string toString(int depth = 0);

};

}
}

#endif
