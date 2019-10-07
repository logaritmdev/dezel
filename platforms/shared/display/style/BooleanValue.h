#ifndef Boolean_h
#define Boolean_h

#include "Value.h"

namespace Dezel {
namespace Style {

class Parser;
class Stylesheet;

class BooleanValue : public Value {

private:

	bool value = false;

public:

	friend class Parser;
	friend class Stylesheet;

	BooleanValue(bool value);

	bool getValue() const {
		return this->value;
	}

	string toString();
};

}
}

#endif
