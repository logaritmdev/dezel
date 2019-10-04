#include "Resolver.h"
#include "Display.h"
#include "DisplayBase.h"
#include "DisplayNode.h"

#include <iostream>

namespace Dezel {
namespace Layout {

using std::min;
using std::max;

Resolver::Resolver(DisplayNode* node) : relatives(node), absolutes(node)
{
	this->node = node;
}

void
Resolver::resolve()
{
	for (auto &child : this->node->children) {

		if (child->visible == false) {
			continue;
		}

		const auto frame = child->frame;

		frame->wrapsContentWidth = frame->shouldWrapContentWidth();
		frame->wrapsContentHeight = frame->shouldWrapContentHeight();

		if (frame->isRelative()) {
			this->relatives.append(child);
		} else {
			this->absolutes.append(child);
		}
	}

	const auto frame = this->node->frame;

	const bool autoContentW = frame->contentWidth.type == kDisplayNodeContentSizeTypeAuto;
	const bool autoContentH = frame->contentHeight.type == kDisplayNodeContentSizeTypeAuto;
	const auto lastContentW = frame->measuredContentWidth;
	const auto lastContentH = frame->measuredContentHeight;

	this->relatives.resolve();

	if (autoContentW || autoContentH) {

		if (autoContentW) frame->measuredContentWidth = max(frame->measuredContentWidth, this->getExtentRight());
		if (autoContentH) frame->measuredContentHeight = max(frame->measuredContentHeight, this->getExtentBottom());

		if (lastContentW != frame->measuredContentWidth ||
			lastContentH != frame->measuredContentHeight) {
			this->node->didResolveContentSize();
		}
	}

	this->absolutes.resolve();
}

}
} 
