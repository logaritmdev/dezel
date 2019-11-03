#ifndef Ruleset_h
#define Ruleset_h

#include "Selector.h"
#include "Property.h"
#include "PropertyList.h"

#include <string>
#include <vector>
#include <iostream>

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

	vector<Descriptor*> childDescriptors;
	vector<Descriptor*> styleDescriptors;
	vector<Descriptor*> stateDescriptors;

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

	const vector<Descriptor*>& getChildDescriptors() const {
		return this->childDescriptors;
	}

	const vector<Descriptor*>& getStyleDescriptors() const {
		return this->styleDescriptors;
	}

	const vector<Descriptor*>& getStateDescriptors() const {
		return this->stateDescriptors;
	}

	void addProperty(Property* property) {
		this->properties.set(property->getName(), property);
	}

	void addChildDescriptor(Descriptor* child) {
		child->parent = this;
		this->childDescriptors.push_back(child);
	}

	void addStyleDescriptor(Descriptor* style) {
		style->parent = this;
		this->styleDescriptors.push_back(style);
	}

	void addStateDescriptor(Descriptor* state) {
		state->parent = this;
		this->stateDescriptors.push_back(state);
	}

	string toString(int depth = 0);

};

}
}

#endif
