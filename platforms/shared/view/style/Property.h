#ifndef Property_h
#define Property_h

#include <string>
#include <vector>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;

class Value;
class Function;
class Parser;

class Property {

private:

	string name;
	vector<Value*> values;

	Function* function = nullptr;

public:

	friend class Parser;

	Property(string name);

	string toString(int depth = 0);

};

}
}

#endif
