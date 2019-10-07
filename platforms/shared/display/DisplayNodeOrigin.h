#ifndef DisplayNodeOrigin_h
#define DisplayNodeOrigin_h

#include "DisplayBase.h"

namespace Dezel {

class DisplayNodeOrigin {

public:

	DisplayNodeOriginType type = kDisplayNodeOriginTypeAuto;
	DisplayNodeOriginUnit unit = kDisplayNodeOriginUnitNone;

	double length = 0;
	double min = ABS_DBL_MIN;
	double max = ABS_DBL_MAX;

	bool equals(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}
};

}

#endif
