#ifndef String_h
#define String_h

#include "Value.h"

#include <string>

namespace Dezel {
namespace Style {

using std::string;

class Parser;

class StringValue : public Value {

private:

	string value;

public:

	friend class Parser;

	StringValue(string value);

	string getValue() const {
		return this->value;
	}

	string toString();
};

}
}

#endif
