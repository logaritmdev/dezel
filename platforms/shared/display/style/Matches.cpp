#include "Matches.h"
#include "Descriptor.h"
#include "Selector.h"

#include <algorithm>

namespace Dezel {
namespace Style {

static bool importance(const Match& a, const Match& b) {

	if (a.importance == b.importance) {
		return (
			a.getDescriptor()->getSelector()->getOffset() < b.getDescriptor()->getSelector()->getOffset()
		);
	}

	return a.importance < b.importance;
}

void Matches::order()
{
	std::sort(
		this->begin(),
		this->end(),
		importance
	);
}

}
}
