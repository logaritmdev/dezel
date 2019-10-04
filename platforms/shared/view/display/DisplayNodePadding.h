#ifndef DisplayNodePadding_h
#define DisplayNodePadding_h

#include "DisplayBase.h"

namespace Dezel {

class DisplayNodePadding {

public:

	DisplayNodePaddingType type = kDisplayNodePaddingTypeLength;
	DisplayNodePaddingUnit unit = kDisplayNodePaddingUnitPX;

	double length = 0;
	double min = 0;
    double max = ABS_DBL_MAX;

	bool equals(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}
};

}

#endif 
