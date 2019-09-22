#ifndef Rule_h
#define Rule_h

#import "SelectorList.h"
#import "Selector.h"
#include <vector>

namespace View::Style {

using std::vector;

class Rule {

private:
	SelectorList selectors;
	int number = 0;
	int weight = 0;

};

}

#endif
