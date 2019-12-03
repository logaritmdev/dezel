#ifndef DisplayNodeContentOrigin_h
#define DisplayNodeContentOrigin_h

#include "DisplayBase.h"

namespace Dezel {

class DisplayNodeContentOrigin {

public:

	ContentOriginType type = kContentOriginTypeLength;
	ContentOriginUnit unit = kContentOriginUnitNone;

	double length = 0;

	bool equals(ContentOriginType type, ContentOriginUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}
};

}

#endif
