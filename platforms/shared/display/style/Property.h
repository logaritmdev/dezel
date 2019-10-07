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
	string toString(int depth = 0);

};

}
}

#endif
