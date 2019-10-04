#ifndef Ruleset_h
#define Ruleset_h

#include "Rule.h"
#include "Property.h"

#include <string>
#include <vector>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;

class Selector;
class SelectorList;
class Parser;

class Ruleset {

private:

	Ruleset* parent = nullptr;

	vector<Rule*> rules;
	vector<Ruleset*> children;
	vector<Rule*> modifiers;
	vector<Property*> properties;
	

public:

	friend class Parser;
// TODO setter adder etc..
	Ruleset* clone();

	string toString(int depth = 0);

};

}
}

#endif
