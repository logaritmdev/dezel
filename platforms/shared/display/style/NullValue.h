#ifndef Null_h
#define Null_h

#include "Value.h"

namespace Dezel {
namespace Style {

class Parser;
class Stylesheet;

class NullValue : public Value {

public:

	friend class Parser;
	friend class Stylesheet;

	NullValue();
	string toString();

};

}
}

#endif
