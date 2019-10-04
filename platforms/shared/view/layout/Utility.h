
#ifndef Utility_h
#define Utility_h

#include <cmath>

namespace Dezel {
namespace Layout {

using std::round;

inline double alignMid(double size, double container) {
	return container / 2 - size / 2;
}

inline double alignEnd(double size, double container) {
	return container - size;
}

inline double round(double value, double scale) {
	return scale > 1 ? (round((value) * scale) / scale) : round(value);
}

inline double round(double value, double scale, double &carry) {
	double number = value;
	value = value + carry;
	value = round(value, scale);
	carry = (number + carry) - value;
	return value;
}

inline double scale(double value, double ratio) {
	return (value) / 100 * (ratio);
}

inline double clamp(double value, double min, double max) {
	if (value < min) value = min;
	if (value > max) value = max;
	return value;
}

}
}

#endif
