#ifndef DisplayNodeContentOrigin_h
#define DisplayNodeContentOrigin_h

#include "DisplayBase.h"

namespace Dezel {

class DisplayNodeContentOrigin {

public:

	DisplayNodeContentOriginType type = kDisplayNodeContentOriginTypeLength;
	DisplayNodeContentOriginUnit unit = kDisplayNodeContentOriginUnitNone;

	double length = 0;

	bool equals(DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}
};

}

#endif
