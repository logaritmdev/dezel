#ifndef Number_h
#define Number_h

#include "Value.h"

#include <string>

namespace Dezel {
namespace Style {

using std::string;

class NumberValue : public Value {

private:

	double value = 0.0;

public:

	friend class Parser;

	NumberValue(string value, ValueUnit unit);
	NumberValue(double value, ValueUnit unit);

	double getValue() const {
		return this->value;
	}

	string toString();
};

}
}

#endif
