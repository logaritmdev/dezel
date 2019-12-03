#ifndef DisplayNodeBorder_h
#define DisplayNodeBorder_h

#include "DisplayBase.h"

namespace Dezel {

class DisplayNodeBorder {

public:

    BorderType type = kBorderTypeLength;
    BorderUnit unit = kBorderUnitPX;

    double length = 0;
    double min = 0;
    double max = ABS_DBL_MAX;

	bool equals(BorderType type, BorderUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}

};

}

#endif
