#ifndef Selector_h
#define Selector_h

#include <string>
#include <vector>

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
class Importance;

class Fragment {

private:

	Selector* selector = nullptr;

	Fragment* parent = nullptr;
	Fragment* prev = nullptr;
	Fragment* next = nullptr;

	string name = "";
	string type = "";
	string style = "";
	string state = "";

	bool matchName(DisplayNode* node, Importance& importance);
	bool matchType(DisplayNode* node, Importance& importance);
	bool matchStyle(DisplayNode* node, Importance& importance);
	bool matchState(DisplayNode* node, Importance& importance);

public:

	friend class Parser;
	friend class Stylesheet;
	friend class Descriptor;

	Selector* getSelector() const {
		return this->selector;
	}

	Fragment* getParent() const {
		return this->prev ? this->prev : this->parent;
	}

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

	bool isStyle() const {
		return this->style.length() > 0;
	}

	bool isState() const {
		return this->state.length() > 0;
	}

	bool match(DisplayNode* node, Importance& importance);

	string toString(int depth = 0);

};

}
}

#endif
