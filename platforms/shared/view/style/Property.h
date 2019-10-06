#ifndef Property_h
#define Property_h

#include <string>
#include <vector>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;

class Value;
class FunctionValue;
class Parser;

class Property {

private:

	string name;
	vector<Value*> values;

public:

	friend class Parser;

	Property(string name);
	string toString(int depth = 0);

};

}
}

#endif
