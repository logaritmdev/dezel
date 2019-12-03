#ifndef DisplayNodeAnchor_h
#define DisplayNodeAnchor_h

#include "DisplayBase.h"

namespace Dezel {

class DisplayNodeAnchor {

public:

	AnchorType type = kAnchorTypeLength;
	AnchorUnit unit = kAnchorUnitPC;

	double length = 0;

	bool equals(AnchorType type, AnchorUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}
};

}

#endif
