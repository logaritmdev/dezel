#ifndef StringValue_h
#define StringValue_h

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
	StringValue(const char* value);
	~StringValue();

	const string& getValue() const {
		return this->value;
	}

	string toString();
};

}
}

#endif
