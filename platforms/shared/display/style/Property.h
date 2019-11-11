#ifndef Property_h
#define Property_h

#include <string>
#include <vector>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;

class Parser;
class Stylesheet;
class Value;

class Property {

private:

	string name;
	vector<Value*> values;

public:

	friend class Parser;
	friend class Stylesheet;

	Property(string name);

	const string& getName() const {
		return this->name;
	}

	const vector<Value*>& getValues() const {
		return this->values;
	}

	void appendValue(Value* value);
	void insertValue(size_t index, Value* value);
	void removeValue(size_t index);

	string toString(int depth = 0);

};

}
}

#endif
