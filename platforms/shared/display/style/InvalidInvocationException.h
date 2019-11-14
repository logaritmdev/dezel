#ifndef InvalidInvocationException_h
#define InvalidInvocationException_h

#include <string>
#include <exception>

namespace Dezel {
namespace Style {

using std::string;
using std::exception;

class InvalidInvocationException : exception {

private:

	string message;

public:

	InvalidInvocationException(string message) : message(message) {

	}

	const char* what () const throw () {
    	return this->message.c_str();
    }

};

}
}

#endif
