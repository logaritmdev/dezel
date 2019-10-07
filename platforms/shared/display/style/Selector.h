#ifndef Selector_h
#define Selector_h

#include <set>
#include <string>

namespace Dezel {
namespace Style {

using std::set;
using std::string;

enum Combinator {
	kCombinatorNone,
	kCombinatorParent
};

class Rule;
class Parser;
class Stylesheet;

class Selector {

private:

	Selector* prev = nullptr;
	Selector* next = nullptr;

	string name = "";
	string type = "";
	set<string> styles;
	set<string> states;

	Combinator combinator = kCombinatorNone;

public:

	friend class Parser;
	friend class Stylesheet;

	Selector* getPrev() const {
		return this->prev;
	}

	Selector* getNext() const {
		return this->next;
	}

	const string& getName() const {
		return this->name;
	}

	const string& getType() const {
		return this->type;
	}

	const set<string>& getStyles() const {
		return this->styles;
	}

	const set<string>& getStates() const {
		return this->states;
	}

	string toString(int depth = 0);

};

}
}

#endif
