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
		frame->wrapContentWidth = frame->shouldWrapContentWidth();
		frame->wrapContentHeight = frame->shouldWrapContentHeight();

		if (frame->isRelative()) {
			relatives.push_back(child);
		} else {
			absolutes.push_back(child);
		}
	}

	const bool hasRelativeLayout = relatives.size() > 0;
	const bool hasAbsoluteLayout = absolutes.size() > 0;

	if (hasRelativeLayout) {
		this->relativeLayout.resolve(this->node, relatives);
	}

	const auto frame = this->node->frame;

	const bool autoContentW = frame->contentWidth.type == kDisplayNodeContentSizeTypeAuto;
	const bool autoContentH = frame->contentHeight.type == kDisplayNodeContentSizeTypeAuto;

	if (autoContentW || autoContentH) {

		const double lastContentW = frame->measuredContentWidth;
		const double lastContentH = frame->measuredContentHeight;

		if (autoContentW) frame->measuredContentWidth = max(frame->measuredContentWidth, this->getExtentRight());
		if (autoContentH) frame->measuredContentHeight = max(frame->measuredContentHeight, this->getExtentBottom());

		if (lastContentW != this->node->frame->measuredContentWidth ||
			lastContentH != this->node->frame->measuredContentHeight) {
			this->node->didResolveContentSize();
		}
	}

	if (hasAbsoluteLayout) {
		this->absoluteLayout.resolve(this->node, absolutes);
	}
}

} 
