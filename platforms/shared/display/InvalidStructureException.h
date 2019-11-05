#ifndef InvalidStructureException_h
#define InvalidStructureException_h

#include <exception>

namespace Dezel {

class InvalidStructureException : std::exception {

private:

	const char* message;

public:

	InvalidStructureException(const char* message) {
		this->message = message;
	}

	const char* what () const throw () {
    	return "Invalid structure.";
    }

};

}

#endif
