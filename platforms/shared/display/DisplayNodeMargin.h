#ifndef DisplayNodeMargin_h
#define DisplayNodeMargin_h

#include "DisplayBase.h"

namespace Dezel {

class DisplayNodeMargin {

public:

	DisplayNodeMarginType type = kDisplayNodeMarginTypeLength;
	DisplayNodeMarginUnit unit = kDisplayNodeMarginUnitPX;

	double length = 0;
	double min = ABS_DBL_MIN;
	double max = ABS_DBL_MAX;

	bool equals(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}
};

}

#endif
