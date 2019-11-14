#include "Function.h"
#include "InvalidInvocationException.h"

#include <string>

namespace Dezel {
namespace Style {

using std::to_string;

Function::Function(string name, Callback callback) : name(name), callback(callback)
{

}

void
Function::assertArgumentCount(const vector<Argument>& arguments, unsigned count) const
{
	if (arguments.size() != count) {
		throw InvalidInvocationException(
			"Function " + this->name + " requires " + to_string(count) + " arguments."
		);
	}
}

void
Function::assertMinArgumentCount(const vector<Argument>& arguments, unsigned count) const
{
	if (arguments.size() < count) {
		throw InvalidInvocationException(
			"Function " + this->name + " requires at least" + to_string(count) + " arguments."
		);
	}
}

void
Function::assertMaxArgumentCount(const vector<Argument>& arguments, unsigned count) const
{
	if (arguments.size() > count) {
		throw InvalidInvocationException(
			"Function " + this->name + " requires at most" + to_string(count) + " arguments."
		);
	}
}

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

}
}
