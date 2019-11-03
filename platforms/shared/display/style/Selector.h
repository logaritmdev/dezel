#ifndef Rule_h
#define Rule_h

#include <string>

namespace Dezel {
namespace Style {

using std::string;

class Parser;
class Stylesheet;
class Fragment;

class Selector {

private:

	Fragment* tail = nullptr;
	Fragment* head = nullptr;

	size_t length = 0;
	size_t number = 0;
	size_t weight = 0;

public:

	friend class Parser;
	friend class Stylesheet;

	const Fragment* getTail() const {
		return this->tail;
	}

	const Fragment* getHead() const {
		return this->head;
	}

	size_t getLength() const {
		return this->length;
	}

	size_t getNumber() const {
		return this->number;
	}

	size_t getWeight() const {
		return this->weight;
	}

	string toString(int depth = 0);
};

}
}

#endif
