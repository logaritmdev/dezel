#include "Stylesheet.h"
#include "Descriptor.h"
#include "Matcher.h"
#include "Matches.h"
#include "Match.h"
#include "Selector.h"
#include "Fragment.h"
#include "DisplayNode.h"

namespace Dezel {
namespace Style {

using std::sort;

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

bool
Matcher::match(DisplayNode* node, Matches& matches, const vector<Descriptor*>& descriptors)
{
	bool matched = false;

	for (auto descriptor : descriptors) {

		Importance importance;

		if (descriptor->match(node, importance)) {

			Match match;
			match.descriptor = descriptor;
			match.importance = importance;

			matches.push_back(match);
			matched = true;
		} 
	}

	return matched;
}

}
}
