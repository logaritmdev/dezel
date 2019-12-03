#ifndef DisplayNodeContentSize_h
#define DisplayNodeContentSize_h

#include "DisplayBase.h"

namespace Dezel {

class DisplayNodeContentSize {

public:

	ContentSizeType type = kContentSizeTypeAuto;
	ContentSizeUnit unit = kContentSizeUnitNone;

	double length = 0;

	bool equals(ContentSizeType type, ContentSizeUnit unit, double length) {
		return (
			this->type == type &&
			this->unit == unit &&
			this->length == length
		);
	}
};

}

#endif
