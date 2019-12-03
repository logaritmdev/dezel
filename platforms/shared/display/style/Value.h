#ifndef Value_h
#define Value_h

#include "DisplayBase.h"

#include <string>

namespace Dezel {
namespace Style {

using std::string;

class Parser;
class Stylesheet;
class StringValue;
class NumberValue;
class BooleanValue;
class FunctionValue;
class VariableValue;

class Value {

protected:

	ValueType type;
	ValueUnit unit;

public:

	friend class Parser;
	friend class Stylesheet;

	Value(ValueType type, ValueUnit unit);

	virtual ~Value();

	ValueType getType() const {
		return this->type;
	}

	ValueUnit getUnit() const {
		return this->unit;
	}

	virtual string toString() = 0;
};

}
}

#endif
