#ifndef Function_h
#define Function_h

#include "Argument.h"

#include <string>
#include <vector>

namespace Dezel {
namespace Style {

using std::string;
using std::vector;
using std::to_string;

class Function {

public:

	typedef void (*Callback)(const Function* function, const vector<Argument*>& arguments, vector<Value*>& result);

private:

	string name = "";

	Callback callback;

	int minArgumentCount = -1;
	int maxArgumentCount = -1;

public:

	friend class Parser;
	friend class Stylesheet;

	Function(string name, Callback callback);

	const string& getName() const {
		return this->name;
	}

	const void invoke(const vector<Argument*>& arguments, vector<Value*>& result) const {
		this->callback(this, arguments, result);
	}
};

}
}

#endif
