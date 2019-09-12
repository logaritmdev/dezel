#include "Layout.h"
#include "Display.h"
#include "DisplayBase.h"
#include "DisplayNode.h"

#include <iostream>
#include <vector>

namespace View {

using std::vector;
using std::cout;
using std::cerr;
using std::min;
using std::max;

Layout::Layout(DisplayNode* node) : relativeLayout(node), absoluteLayout(node)
{
	this->node = node;
}

void
Layout::resolve()
{
	vector<DisplayNode*> relatives;
	vector<DisplayNode*> absolutes;

	for (auto &child : this->node->children) {

		if (child->visible == false) {
			continue;
		}

		const auto frame = child->frame;

		frame->wrapsContentWidth = frame->shouldWrapContentWidth();
		frame->wrapsContentHeight = frame->shouldWrapContentHeight();

		if (frame->isRelative()) {
			relatives.push_back(child);
		} else {
			absolutes.push_back(child);
		}
	}

	const bool hasRelativeLayout = relatives.size() > 0;
	const bool hasAbsoluteLayout = absolutes.size() > 0;

	const auto frame = this->node->frame;

	const bool autoContentW = frame->contentWidth.type == kDisplayNodeContentSizeTypeAuto;
	const bool autoContentH = frame->contentHeight.type == kDisplayNodeContentSizeTypeAuto;
	const auto lastContentW = frame->measuredContentWidth;
	const auto lastContentH = frame->measuredContentHeight;

	if (hasRelativeLayout) {
		this->relativeLayout.resolve(this->node, relatives);
	}

	if (autoContentW || autoContentH) {

		if (autoContentW) frame->measuredContentWidth = max(frame->measuredContentWidth, this->getExtentRight());
		if (autoContentH) frame->measuredContentHeight = max(frame->measuredContentHeight, this->getExtentBottom());

		if (lastContentW != frame->measuredContentWidth ||
			lastContentH != frame->measuredContentHeight) {
			this->node->didResolveContentSize();
		}
	}

	if (hasAbsoluteLayout) {
		this->absoluteLayout.resolve(this->node, absolutes);
	}
}

} 
