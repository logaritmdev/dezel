#ifndef Resolver_h
#define Resolver_h

#include "RelativeLayoutResolver.h"
#include "AbsoluteLayoutResolver.h"

#include <cmath>

namespace Dezel {
	class DisplayNode;
}

namespace Dezel {
namespace Layout {

using std::round;

class LayoutResolver {

private:

	DisplayNode* node;
	RelativeLayoutResolver relativeLayout;
	AbsoluteLayoutResolver absoluteLayout;

public:

	static inline double round(double value, double scale) {
		return scale > 1 ? (std::round((value) * scale) / scale) : std::round(value);
	}

	static inline double round(double value, double scale, double &carry) {
		double number = value;
		value = value + carry;
		value = round(value, scale);
		carry = (number + carry) - value;
		return value;
	}

	static inline double scale(double value, double ratio) {
		return (value) / 100 * (ratio);
	}

	static inline double clamp(double value, double min, double max) {
		if (value < min) value = min;
		if (value > max) value = max;
		return value;
	}

	LayoutResolver(DisplayNode* node);

	double getExtentTop() {
		return this->relativeLayout.extentTop;
	}

	double getExtentLeft() {
		return this->relativeLayout.extentLeft;
	}

	double getExtentRight() {
		return this->relativeLayout.extentRight;
	}

	double getExtentBottom() {
		return this->relativeLayout.extentBottom;
	}

	void resolve();
};

}
}

#endif
