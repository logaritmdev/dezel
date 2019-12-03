#ifndef NumberValue_h
#define NumberValue_h

#include "Value.h"

#include <string>

namespace Dezel {
namespace Style {

using std::string;

class Parser;
class Stylesheet;

class NumberValue : public Value {

private:

	double value = 0.0;

public:

	friend class Parser;
	friend class Stylesheet;

	NumberValue(string value, ValueUnit unit);
	NumberValue(double value, ValueUnit unit);
	~NumberValue();

	double getValue() const {
		return this->value;
	}

	string toString();
};

}
}

#endif
