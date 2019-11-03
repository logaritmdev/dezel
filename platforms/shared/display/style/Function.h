#ifndef Function_h
#define Function_h

#include <string>

namespace Dezel {
namespace Style {

using std::string;

class Function {

private:

	string name = "";

public:

	friend class Parser;
	friend class Stylesheet;
	
	const string& getName() const {
		return this->name;
	}

};

}
}

#endif
