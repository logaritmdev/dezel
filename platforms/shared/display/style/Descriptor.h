#ifndef Ruleset_h
#define Ruleset_h

#include "Selector.h"
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
class Fragment;

class Descriptor {

private:

	Descriptor* parent = nullptr;

	Selector* selector;
	PropertyList properties;

	vector<Descriptor*> styleRules;
	vector<Descriptor*> stateRules;
	vector<Descriptor*> childRules;

public:

	friend class Parser;
	friend class Stylesheet;

	Descriptor* getParent() const {
		return this->parent;
	}

	const Selector* getSelector() const {
		return this->selector;
	}

	const PropertyList& getProperties() const {
		return this->properties;
	}

	const vector<Descriptor*>& getStyleRules() const {
		return this->styleRules;
	}

	const vector<Descriptor*>& getStateRules() const {
		return this->stateRules;
	}

	const vector<Descriptor*>& getChildRules() const {
		return this->childRules;
	}

	string toString(int depth = 0);

};

}
}

#endif
