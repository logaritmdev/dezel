#ifndef Matcher_h
#define Matcher_h

#include "Match.h"

#include <vector>

namespace Dezel {
	class DisplayNode;
}

namespace Dezel {
namespace Style {

using std::vector;

class Stylesheet;
class Descriptor;
class Selector;
class Fragment;

class Matcher {

public:

	bool match(DisplayNode* node, vector<Match>& matches, const vector<Descriptor*>& descriptors);

};

}
}

#endif
