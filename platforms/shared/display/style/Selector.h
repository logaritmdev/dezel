#ifndef Selector_h
#define Selector_h

#include "Importance.h"

#include <string>

namespace Dezel {
namespace Style {

using std::string;

class Parser;
class Stylesheet;
class Descriptor;
class Fragment;

class Selector {

private:

	Descriptor* descriptor = nullptr;

	Selector* parent = nullptr;
	Fragment* tail = nullptr;
	Fragment* head = nullptr;

	size_t length = 0;
	size_t offset = 0;

public:

	friend class Parser;
	friend class Stylesheet;
	friend class Descriptor;

	Descriptor* getDescriptor() const {
		return this->descriptor;
	}

	Selector* getParent() const {
		return this->parent;
	}

	Fragment* getTail() const {
		return this->tail;
	}

	Fragment* getHead() const {
		return this->head;
	}

	size_t getLength() const {
		return this->length;
	}

	size_t getOffset() const {
		return this->offset;
	}

	string toString(int depth = 0) const;
};

}
}

#endif
