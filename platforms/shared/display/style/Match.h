#ifndef Match_h
#define Match_h

#include "Specifier.h"

namespace Dezel {
namespace Style {

class Descriptor;
class Matcher;

class Match {

private:

	Descriptor* descriptor = nullptr;

public:

	friend class Matcher;
	friend class Descriptor;

	Specifier importance;

	Descriptor* getDescriptor() const {
		return this->descriptor;
	}

};

}
}

#endif 
