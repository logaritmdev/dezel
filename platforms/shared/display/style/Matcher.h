#ifndef Matcher_h
#define Matcher_h

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
class Matches;

class Matcher {

public:

	bool match(DisplayNode* node, Matches& matches, const vector<Descriptor*>& descriptors);
	// tood matcher recursive
};

}
}

#endif
