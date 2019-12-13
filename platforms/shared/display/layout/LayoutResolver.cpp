#include "LayoutResolver.h"
#include "Display.h"
#include "DisplayBase.h"
#include "DisplayNode.h"

#include <iostream>

namespace Dezel {
namespace Layout {

using std::min;
using std::max;

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

LayoutResolver::LayoutResolver(DisplayNode* node) : relativeLayout(node), absoluteLayout(node)
{
	this->node = node;
}

void
LayoutResolver::prepare()
{
	this->node->didPrepareLayout();
}

void
LayoutResolver::resolve() {

	/*
	 * The layout prepare callback is allowed to update the content size
	 * thus we need to resolve it again in case.
	 */

	this->node->resolveContentSize();
	this->node->resolvePadding();

	if (this->node->children.size() == 0) {
		return;
	}

	for (auto child : this->node->children) {

		if (child->visible == false) {
			continue;
		}

		child->resolveTraits();

		child->inheritedWrappedContentWidth = child->inheritsWrappedWidth();
		child->inheritedWrappedContentHeight = child->inheritsWrappedHeight();

		if (child->isRelative()) {
			this->relativeLayout.append(child);
		} else {
			this->absoluteLayout.append(child);
		}
	}

	const bool autoContentW = this->node->contentWidth.type == kContentSizeTypeAuto;
	const bool autoContentH = this->node->contentHeight.type == kContentSizeTypeAuto;
	const auto lastContentW = this->node->measuredContentWidth;
	const auto lastContentH = this->node->measuredContentHeight;

	this->relativeLayout.resolve();

	if (autoContentW || autoContentH) {

		if (autoContentW) this->node->measuredContentWidth = max(this->node->measuredContentWidth, this->getExtentRight());
		if (autoContentH) this->node->measuredContentHeight = max(this->node->measuredContentHeight, this->getExtentBottom());

		if (lastContentW != this->node->measuredContentWidth ||
			lastContentH != this->node->measuredContentHeight) {
			this->node->didResolveContentSize();
		}
	}

	this->absoluteLayout.resolve();

	this->node->didResolveLayout();
}

}
} 
