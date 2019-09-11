#ifndef Resolver_h
#define Resolver_h

#include "RelativeLayout.h"
#include "AbsoluteLayout.h"
#include <cmath>

namespace View {

using std::round;

static double alignMid(double size, double container) {
	return container / 2 - size / 2;
}

static double alignEnd(double size, double container) {
	return container - size;
}

static double round(double value, double scale) {
	return scale > 1 ? (std::round((value) * scale) / scale) : std::round(value);
}

static double round(double value, double scale, double &carry) {
	const double number = value;
	value = value + carry;
	value = round(value, scale);
	carry = (number + carry) - value;
	return value;
}

static double scale(double value, double ratio) {
	return (value) / 100 * (ratio);
}

static double clamp(double value, double min, double max) {
	if (value < min) value = min;
	if (value > max) value = max;
	return value;
}

class DisplayNode;
class Layout {

private:

	DisplayNode* node;
	RelativeLayout relativeLayout;
	AbsoluteLayout absoluteLayout;

public:

	Layout(DisplayNode* node);

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

#endif
