
#ifndef InvalidOperationException_h
#define InvalidOperationException_h

#include <exception>

namespace Dezel {

class InvalidOperationException : std::exception {

private:

	const char* message;

public:

	InvalidOperationException(const char* message) {
		this->message = message;
	}

	const char* what () const throw () {
    	return this->message;
    }

};

}

#endif
