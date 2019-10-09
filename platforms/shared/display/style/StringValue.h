#ifndef String_h
#define String_h

#include "Value.h"

#include <string>

namespace Dezel {
namespace Style {

using std::string;

class Parser;
class Stylesheet;

class StringValue : public Value {

private:

	string value;

public:

	friend class Parser;
	friend class Stylesheet;

	StringValue(string value);

	const string& getValue() const {
		return this->value;
	}

	string toString();
};

}
}

#endif
