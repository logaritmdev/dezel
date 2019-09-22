#ifndef Selector_h
#define Selector_h

#include <set>
#include <string>

namespace View::Style {

using std::set;
using std::string;

class Selector {

private:
	string name = "";
	string type = "*";
	set<string> styles;
	set<string> states;

};

}

#endif
