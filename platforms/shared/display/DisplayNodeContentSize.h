#ifndef DisplayNodeContentSize_h
#define DisplayNodeContentSize_h

#include "DisplayBase.h"

namespace Dezel {

class DisplayNodeContentSize {

public:

	DisplayNodeContentSizeType type = kDisplayNodeContentSizeTypeAuto;
	DisplayNodeContentSizeUnit unit = kDisplayNodeContentSizeUnitNone;

	double length = 0;

	bool equals(DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}
};

}

#endif
