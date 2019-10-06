#ifndef Null_h
#define Null_h

#include "Value.h"

namespace Dezel {
namespace Style {

class NullValue : public Value {

public:
	NullValue();
	string toString();

};

}
}

#endif
