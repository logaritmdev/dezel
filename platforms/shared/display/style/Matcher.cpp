#include "Stylesheet.h"
#include "Descriptor.h"
#include "Matcher.h"
#include "Match.h"
#include "Selector.h"
#include "Fragment.h"
#include "DisplayNode.h"

namespace Dezel {
namespace Style {

using std::sort;

//------------------------------------------------------------------------------
// MARK: Private API
//------------------------------------------------------------------------------

bool
Matcher::compare(const Match& a, const Match& b)
{
	if (a.importance == b.importance) {
		return (
			a.getDescriptor()->getSelector()->getOffset() <
			b.getDescriptor()->getSelector()->getOffset()
		);
	}

	return a.importance < b.importance;
}

bool
Matcher::match(DisplayNode* node, vector<Match>& matches, const vector<Descriptor*>& descriptors)
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

	if (matched) {
		sort(
			matches.begin(),
			matches.end(),
			Matcher::compare
		);
	}

	return matched;
}

}
}
