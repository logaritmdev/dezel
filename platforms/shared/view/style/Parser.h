#ifndef Parser_h
#define Parser_h

#include "Sheet.h"
#include "Rule.h"

namespace View::Style {

using std::string;

class Parser {

private:
	Sheet* sheet;

public:

	Parser();
	void parse(const string string);

};

}

#endif
