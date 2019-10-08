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

	string toString(int depth = 0);

};

}
}

#endif
