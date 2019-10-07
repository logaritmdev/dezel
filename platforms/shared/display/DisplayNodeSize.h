#ifndef DisplayNodeSize_h
#define DisplayNodeSize_h

#include "DisplayNodeRef.h"

#include <limits>

namespace Dezel {

class DisplayNodeSize {

public:

	DisplayNodeSizeType type = kDisplayNodeSizeTypeFill;
	DisplayNodeSizeUnit unit = kDisplayNodeSizeUnitNone;

	double length = 0;
	double min = 0;
	double max = ABS_DBL_MAX;

	bool equals(DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}
};

}

#endif
