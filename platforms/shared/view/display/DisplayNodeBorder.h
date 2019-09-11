#ifndef DisplayNodeBorder_h
#define DisplayNodeBorder_h

#include "DisplayBase.h"

namespace View {

class DisplayNodeBorder {

public:

    DisplayNodeBorderType type = kDisplayNodeBorderTypeLength;
    DisplayNodeBorderUnit unit = kDisplayNodeBorderUnitPX;

    double length = 0;
    double min = 0;
    double max = ABS_DBL_MAX;

	bool equals(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}

};

}

#endif
