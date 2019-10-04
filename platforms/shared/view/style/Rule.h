#ifndef Rule_h
#define Rule_h

#include <string>

namespace Dezel {
namespace Style {

using std::string;

class Parser;
class Selector;

class Rule {

private:

	Selector* tail = nullptr;
	Selector* head = nullptr;

	unsigned length = 0;
	unsigned number = 0;
	unsigned weight = 0;

public:

	friend class Parser;

	const Selector* getTail() const {
		return this->tail;
	}

	const Selector* getHead() const {
		return this->head;
	}

	unsigned getLength() const {
		return this->length;
	}

	unsigned getNumber() const {
		return this->number;
	}

	unsigned getWeight() const {
		return this->weight;
	}

	string toString(int depth = 0);
};

}
}

#endif
