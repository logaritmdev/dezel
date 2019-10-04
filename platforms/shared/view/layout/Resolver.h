#ifndef Resolver_h
#define Resolver_h

#include "RelativeNodesResolver.h"
#include "AbsoluteNodesResolver.h"

namespace Dezel {
	class DisplayNode;
}

namespace Dezel {
namespace Layout {

class Resolver {

private:

	DisplayNode* node;
	RelativeNodesResolver relatives;
	AbsoluteNodesResolver absolutes;

public:

	Resolver(DisplayNode* node);

	double getExtentTop() {
		return this->relatives.extentTop;
	}

	double getExtentLeft() {
		return this->relatives.extentLeft;
	}

	double getExtentRight() {
		return this->relatives.extentRight;
	}

	double getExtentBottom() {
		return this->relatives.extentBottom;
	}

	void resolve();
};

}
}

#endif
