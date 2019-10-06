#ifndef Boolean_h
#define Boolean_h

#include "Value.h"

namespace Dezel {
namespace Style {

class BooleanValue : public Value {

private:

	bool value = false;

public:

	BooleanValue(bool value);

	bool getValue() const {
		return this->value;
	}

	string toString();
};

}
}

#endif
