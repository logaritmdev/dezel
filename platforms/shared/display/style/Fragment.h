#ifndef Selector_h
#define Selector_h

#include <set>
#include <string>

namespace Dezel {
namespace Style {

using std::set;
using std::string;
using std::sort;

class Selector;
class Parser;
class Stylesheet;

class Fragment {

private:

	Fragment* prev = nullptr;
	Fragment* next = nullptr;

	string name = "";
	string type = "";
	string style = ""; // for style at-rule
	string state = ""; // for state at-rule

public:

	friend class Parser;
	friend class Stylesheet;

	Fragment* getPrev() const {
		return this->prev;
	}

	Fragment* getNext() const {
		return this->next;
	}

	const string& getName() const {
		return this->name;
	}

	const string& getType() const {
		return this->type;
	}

	const string& getStyle() const {
		return this->style;
	}

	const string& getState() const {
		return this->state;
	}

	string toString(int depth = 0);

};

}
}

#endif
