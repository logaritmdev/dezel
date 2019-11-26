#ifndef ParseException_h
#define ParseException_h

#include <string>
#include <exception>

namespace Dezel {
namespace Style {

using std::string;
using std::exception;

class ParseException : exception {

private:

	string message = "";
	string error;
	string token;
	string file;
	size_t col;
	size_t row;

public:

	ParseException(string error, string token, string file, size_t col, size_t row) : error(error), token(token), file(file), col(col), row(row) {
		this->message.append(error);
		this->message.append(" ");
		this->message.append(token);
		this->message.append(" at ");
		this->message.append("line ");
		this->message.append(std::to_string(row));
		this->message.append(" ");
		this->message.append("column ");
		this->message.append(std::to_string(col));
		this->message.append(" in ");
		this->message.append(file);
	}

	const string& getMessage() {
		return this->message;
	}

	const string& getFile() {
		return this->file;
	}

	size_t getCol() {
		return this->col;
	}

	size_t getRow() {
		return this->row;
	}

	const char* what () const throw () {
    	return this->message.c_str();
    }

};

}
}

#endif
