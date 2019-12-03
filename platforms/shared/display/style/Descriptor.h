#ifndef Descriptor_h
#define Descriptor_h

#include "Selector.h"
#include "Fragment.h"
#include "Property.h"
#include "PropertyList.h"
#include "DisplayNode.h"

#include <string>
#include <vector>
#include <iostream>

namespace Dezel {
	class DisplayNode;
}

namespace Dezel {
namespace Style {

using std::string;
using std::vector;

class Parser;
class Stylesheet;
class Selector;
class Fragment;
class Importance;

class Descriptor {

private:

	Descriptor* parent = nullptr;

	Selector* selector;

	PropertyList properties;

	vector<Descriptor*> childDescriptors;
	vector<Descriptor*> styleDescriptors;
	vector<Descriptor*> stateDescriptors;

	void setParentSelector(Descriptor* descriptor);
	void setParentFragment(Descriptor* descriptor);

	bool matchNode(DisplayNode* node, Importance& importance);
	bool matchPath(DisplayNode* node, Importance& importance);

public:

	friend class Parser;
	friend class Stylesheet;

	Descriptor* getParent() const {
		return this->parent;
	}

	Selector* getSelector() const {
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

	void addChildDescriptor(Descriptor* child);
	void addStyleDescriptor(Descriptor* style);
	void addStateDescriptor(Descriptor* state);

	void addProperty(Property* property) {
		this->properties.add(property);
	}

	bool match(DisplayNode* node, Importance& importance);

	string toString(int depth = 0);

};

}
}

#endif
