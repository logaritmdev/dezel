#ifndef DisplayNodeAnchor_h
#define DisplayNodeAnchor_h

#include "DisplayBase.h"

namespace Dezel {

class DisplayNodeAnchor {

public:

	DisplayNodeAnchorType type = kDisplayNodeAnchorTypeLength;
	DisplayNodeAnchorUnit unit = kDisplayNodeAnchorUnitPC;

	double length = 0;

	bool equals(DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}
};

}

#endif
