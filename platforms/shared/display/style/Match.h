#ifndef Match_h
#define Match_h

#include "Importance.h"

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

	Importance importance;

	Descriptor* getDescriptor() const {
		return this->descriptor;
	}

};

}
}

#endif 
