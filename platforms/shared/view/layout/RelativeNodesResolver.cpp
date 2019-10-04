#include "RelativeNodesResolver.h"
#include "Resolver.h"
#include "Utility.h"
#include "Display.h"
#include "DisplayNode.h"
#include "DisplayNodeFrame.h"

#include <iostream>

namespace Dezel {
namespace Layout {

using std::cerr;
using std::min;
using std::max;

RelativeNodesResolver::RelativeNodesResolver(DisplayNode* node)
{
	this->node = node;
}

bool
RelativeNodesResolver::hasInvalidSize(DisplayNode* child)
{
	const auto frame = child->frame;

	if (frame->invalidSize ||
		frame->resolvedSize == false) {
		return true;
	}

	if (frame->shrinkFactor > 0 ||
		frame->expandFactor > 0) {
		return true;
	}

	if (frame->width.unit == kDisplayNodeSizeUnitPX &&
		frame->height.unit == kDisplayNodeSizeUnitPX) {
		return false;
	}

	if (child->parent) {

		auto parent = child->parent->frame;

		if (parent->measuredContentWidthChanged || frame->hasResolvedParentChange()) {
			if (frame->width.unit == kDisplayNodeSizeUnitPC ||
				frame->width.type == kDisplayNodeSizeTypeFill) {
				return true;
			}
		}

		if (parent->measuredContentHeightChanged || frame->hasResolvedParentChange()) {
			if (frame->height.unit == kDisplayNodeSizeUnitPC ||
				frame->height.type == kDisplayNodeSizeTypeFill) {
				return true;
			}
		}

		if (parent->measuredInnerWidthChanged || frame->hasResolvedParentChange()) {
			if (frame->width.unit == kDisplayNodeSizeUnitPW ||
				frame->height.unit == kDisplayNodeSizeUnitPW) {
				return true;
			}
		}

		if (parent->measuredInnerHeightChanged || frame->hasResolvedParentChange()) {
			if (frame->width.unit == kDisplayNodeSizeUnitPH ||
				frame->height.unit == kDisplayNodeSizeUnitPH) {
				return true;
			}
		}

		if (parent->measuredContentWidthChanged || frame->hasResolvedParentChange()) {
			if (frame->width.unit == kDisplayNodeSizeUnitCW ||
				frame->height.unit == kDisplayNodeSizeUnitCW) {
				return true;
			}
		}

		if (parent->measuredContentHeightChanged || frame->hasResolvedParentChange()) {
			if (frame->width.unit == kDisplayNodeSizeUnitCH ||
				frame->height.unit == kDisplayNodeSizeUnitCH) {
				return true;
			}
		}
	}

	if (child->display->hasViewportWidthChanged()) {
		if (frame->width.unit == kDisplayNodeSizeUnitVW ||
			frame->height.unit == kDisplayNodeSizeUnitVH) {
			return true;
		}
	}

	if (child->display->hasViewportWidthChanged()) {
		if (frame->width.unit == kDisplayNodeSizeUnitVH ||
			frame->height.unit == kDisplayNodeSizeUnitVH) {
			return true;
		}
	}

	return false;
}

bool
RelativeNodesResolver::hasInvalidOrigin(DisplayNode* node)
{
	return true;
}

double
RelativeNodesResolver::measureWidth(DisplayNode* child, double remaining)
{
	const auto frame = child->frame;

	const auto type = frame->width.type;
	const auto unit = frame->width.unit;

	double value = frame->width.length;

	if (type == kDisplayNodeSizeTypeFill) {

		value = remaining - frame->measuredMarginLeft - frame->measuredMarginRight;

	} else if (type == kDisplayNodeSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kDisplayNodeSizeTypeLength) {

		switch (unit) {
			case kDisplayNodeSizeUnitPC: value = scale(value, child->parent->frame->measuredContentWidth - child->parent->frame->measuredPaddingLeft - child->parent->frame->measuredPaddingRight); break;
			case kDisplayNodeSizeUnitPW: value = scale(value, child->parent->frame->measuredInnerWidth); break;
			case kDisplayNodeSizeUnitPH: value = scale(value, child->parent->frame->measuredInnerHeight); break;
			case kDisplayNodeSizeUnitCW: value = scale(value, child->parent->frame->measuredContentWidth); break;
			case kDisplayNodeSizeUnitCH: value = scale(value, child->parent->frame->measuredContentHeight); break;
			case kDisplayNodeSizeUnitVW: value = scale(value, child->display->getViewportWidth()); break;
			case kDisplayNodeSizeUnitVH: value = scale(value, child->display->getViewportHeight()); break;
			default: break;
		}
	}

	value = clamp(
		value,
		frame->width.min,
		frame->width.max
	);

	return value;
}

double
RelativeNodesResolver::measureHeight(DisplayNode* child, double remaining)
{
	const auto frame = child->frame;

	const auto type = frame->height.type;
	const auto unit = frame->height.unit;

	double value = frame->height.length;

	if (type == kDisplayNodeSizeTypeFill) {

		value = remaining - frame->measuredMarginTop - frame->measuredMarginBottom;

	} else if (type == kDisplayNodeSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kDisplayNodeSizeTypeLength) {

		switch (unit) {
			case kDisplayNodeSizeUnitPC: value = scale(value, child->parent->frame->measuredContentHeight - child->parent->frame->measuredPaddingTop - child->parent->frame->measuredPaddingBottom); break;
			case kDisplayNodeSizeUnitPW: value = scale(value, child->parent->frame->measuredInnerWidth); break;
			case kDisplayNodeSizeUnitPH: value = scale(value, child->parent->frame->measuredInnerHeight); break;
			case kDisplayNodeSizeUnitCW: value = scale(value, child->parent->frame->measuredContentWidth); break;
			case kDisplayNodeSizeUnitCH: value = scale(value, child->parent->frame->measuredContentHeight); break;
			case kDisplayNodeSizeUnitVW: value = scale(value, child->display->getViewportWidth()); break;
			case kDisplayNodeSizeUnitVH: value = scale(value, child->display->getViewportHeight()); break;
			default: break;
		}

	}

	value = clamp(
		value,
		frame->height.min,
		frame->height.max
	);

	return value;
}

double
RelativeNodesResolver::resolveAlignment(DisplayNode* child, double remaining)
{
	double size = 0;
	double headOffset = 0;
	double tailOffset = 0;

	switch (child->parent->frame->contentDirection) {

		case kDisplayNodeContentDirectionVertical:
			size = child->frame->measuredWidth;
			headOffset = child->frame->measuredMarginLeft;
			tailOffset = child->frame->measuredMarginRight;
			break;

		case kDisplayNodeContentDirectionHorizontal:
			size = child->frame->measuredHeight;
			headOffset = child->frame->measuredMarginTop;
			tailOffset = child->frame->measuredMarginBottom;
			break;
	}

	double offset = 0;

	switch (child->parent->frame->contentAlignment) {

		case kDisplayNodeContentAlignmentStart:
			offset = headOffset;
			break;

		case kDisplayNodeContentAlignmentCenter:
			offset = alignMid(size, remaining) + headOffset - tailOffset;
			break;

		case kDisplayNodeContentAlignmentEnd:
			offset = alignEnd(size, remaining) - tailOffset;
			break;
	}

	return offset;
}

void
RelativeNodesResolver::expandNodesVertically(const vector<DisplayNode*> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		const auto frame = child->frame;

		double measuredH = frame->measuredHeight + (frame->expandFactor / weights * space);

		measuredH = round(measuredH, child->display->getScale(), remainder);

		if (frame->measuredHeight != measuredH) {
			frame->measuredHeight = measuredH;
			frame->measuredHeightChanged = true;
		}
	}
}

void
RelativeNodesResolver::expandNodesHorizontally(const vector<DisplayNode*> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		const auto frame = child->frame;

		double measuredW = frame->measuredWidth + (frame->expandFactor / weights * space);

		measuredW = round(measuredW, child->display->getScale(), remainder);

		if (frame->measuredWidth != measuredW) {
			frame->measuredWidth = measuredW;
			frame->measuredWidthChanged = true;
		}
	}
}

void
RelativeNodesResolver::shrinkNodesVertically(const vector<DisplayNode*> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		const auto frame = child->frame;

		double measuredH = frame->measuredHeight + (frame->shrinkFactor / weights * space);

		measuredH = round(measuredH, child->display->getScale(), remainder);

		if (frame->measuredHeight != measuredH) {
			frame->measuredHeight = measuredH;
			frame->measuredHeightChanged = true;
		}
	}
}

void
RelativeNodesResolver::shrinkNodesHorizontally(const vector<DisplayNode*> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		const auto frame = child->frame;

		double measuredW = frame->measuredWidth + (frame->shrinkFactor / weights * space);

		measuredW = round(measuredW, child->display->getScale(), remainder);

		if (frame->measuredWidth != measuredW) {
			frame->measuredWidth = measuredW;
			frame->measuredWidthChanged = true;
		}
	}
}

void
RelativeNodesResolver::measure(DisplayNode* child, double &remainingW, double &remainingH, double &remainder)
{
	const auto frame = child->frame;

	const bool wrapW = frame->wrapsContentWidth;
	const bool wrapH = frame->wrapsContentHeight;

	auto measuredW = frame->measuredWidth;
	auto measuredH = frame->measuredHeight;

	frame->measuredWidthChanged = false;
	frame->measuredHeightChanged = false;

	/*
	 * Resolving the node margin must be done before measuring because
	 * it might influence its size, for instance, when using negatives
	 * margins on opposite sides.
	 */

	frame->resolveMargin();

	if (this->hasInvalidSize(child)) {

		if (wrapW == false) measuredW = this->measureWidth(child, remainingW);
		if (wrapH == false) measuredH = this->measureHeight(child, remainingH);

		const double scale = child->display->getScale();

		switch (child->frame->contentDirection) {

			case kDisplayNodeContentDirectionVertical:
				if (wrapW == false) measuredW = round(measuredW, scale);
				if (wrapH == false) measuredH = round(measuredH, scale, remainder);
				break;

			case kDisplayNodeContentDirectionHorizontal:
				if (wrapW == false) measuredW = round(measuredW, scale, remainder);
				if (wrapH == false) measuredH = round(measuredH, scale);
				break;
		}
	}

	if (wrapW || wrapH) {

		frame->resolveWrapper(measuredW, measuredH);

	} else {

		if (frame->measuredWidth != measuredW) {
			frame->measuredWidth = measuredW;
			frame->measuredWidthChanged = true;
			frame->invalidateInnerSize();
		}

		if (frame->measuredHeight != measuredH) {
			frame->measuredHeight = measuredH;
			frame->measuredHeightChanged = true;
			frame->invalidateInnerSize();
		}
	}
}

void
RelativeNodesResolver::resolve()
{
	if (this->nodes.size() == 0) {
		return;
	}

	this->extentTop = 0;
	this->extentLeft = 0;
	this->extentRight = 0;
	this->extentBottom = 0;

	const double scale = this->node->display->getScale();

	const double paddingT = this->node->frame->measuredPaddingTop;
	const double paddingL = this->node->frame->measuredPaddingLeft;
	const double paddingR = this->node->frame->measuredPaddingRight;
	const double paddingB = this->node->frame->measuredPaddingBottom;

	const double contentW = max(this->node->frame->measuredContentWidth - paddingL - paddingR, 0.0);
	const double contentH = max(this->node->frame->measuredContentHeight - paddingT - paddingB, 0.0);
	const double contentT = this->node->frame->measuredContentTop + paddingT;
	const double contentL = this->node->frame->measuredContentLeft + paddingL;

	double remainder = 0;
	double remainingW = contentW;
	double remainingH = contentH;
	double expandablesWeight = 0;
	double shrinkablesWeight = 0;

	vector<DisplayNode*> shrinkables;
	vector<DisplayNode*> expandables;

	for (auto child : this->nodes) {

		const auto frame = child->frame;

		this->measure(
			child,
			remainingW,
			remainingH,
			remainder
		);

		switch (node->frame->contentDirection) {

			case kDisplayNodeContentDirectionVertical:
				remainingH -= frame->measuredHeight;
				remainingH -= frame->measuredMarginTop;
				remainingH -= frame->measuredMarginBottom;
				break;

			case kDisplayNodeContentDirectionHorizontal:
				remainingW -= frame->measuredWidth;
				remainingW -= frame->measuredMarginLeft;
				remainingW -= frame->measuredMarginRight;
				break;
		}

		if (frame->shrinkFactor > 0) {
			shrinkables.push_back(child);
			shrinkablesWeight += frame->shrinkFactor;
		}

		if (frame->expandFactor > 0) {
			expandables.push_back(child);
			expandablesWeight += frame->expandFactor;
		}
	}

	const bool wrapW = node->frame->width.type == kDisplayNodeSizeTypeWrap;
	const bool wrapH = node->frame->height.type == kDisplayNodeSizeTypeWrap;

	if (wrapW) remainingW = max(remainingW, 0.0);
	if (wrapH) remainingH = max(remainingH, 0.0);

	double directionSpace = 0;
	double alignmentSpace = 0;

	switch (node->frame->contentDirection) {

		case kDisplayNodeContentDirectionVertical:
			directionSpace = remainingH;
			alignmentSpace = remainingW;
			break;

		case kDisplayNodeContentDirectionHorizontal:
			directionSpace = remainingW;
			alignmentSpace = remainingH;
			break;
	}

	if (directionSpace > 0) {

		if (expandables.size()) {

			switch (node->frame->contentDirection) {

				case kDisplayNodeContentDirectionVertical:
					this->expandNodesVertically(expandables, remainingH, expandablesWeight);
					break;

				case kDisplayNodeContentDirectionHorizontal:
					this->expandNodesHorizontally(expandables, remainingW, expandablesWeight);
					break;
			}

			directionSpace = 0;
		}

	} else if (directionSpace < 0) {

		if (shrinkables.size()) {

			switch (node->frame->contentDirection) {

				case kDisplayNodeContentDirectionVertical:
					this->shrinkNodesVertically(shrinkables, remainingH, shrinkablesWeight);
					break;

				case kDisplayNodeContentDirectionHorizontal:
					this->shrinkNodesHorizontally(shrinkables, remainingW, shrinkablesWeight);
					break;
			}

			directionSpace = 0;
		}
	}

	for (auto child : this->nodes) {

		const auto frame = child->frame;

		if (frame->lastMeasuredWidth != frame->measuredWidth ||
			frame->lastMeasuredHeight != frame->measuredHeight) {
			frame->lastMeasuredWidth = frame->measuredWidth;
			frame->lastMeasuredHeight = frame->measuredHeight;
			child->didResolveSize();
		}
	}

	double offset = 0;
	double spacer = 0;

	switch (node->frame->contentLocation) {

		case kDisplayNodeContentLocationStart:
			offset = 0;
			break;

		case kDisplayNodeContentLocationEnd:
			offset = directionSpace;
			break;

		case kDisplayNodeContentLocationCenter:
			offset = directionSpace / 2;
			break;

		case kDisplayNodeContentLocationSpaceBetween:
			spacer = directionSpace / (nodes.size() - 1);
			offset = 0;
			break;

		case kDisplayNodeContentLocationSpaceEvenly:
			spacer = directionSpace / (nodes.size() + 1);
			offset = spacer;
			break;

		case kDisplayNodeContentLocationSpaceAround:
			spacer = directionSpace / (nodes.size() + 1);
			offset = spacer / 2;
			break;
	}

	for (auto child : this->nodes) {

		const auto frame = child->frame;

		const double marginT = frame->measuredMarginTop;
		const double marginL = frame->measuredMarginLeft;
		const double marginR = frame->measuredMarginRight;
		const double marginB = frame->measuredMarginBottom;

		const double w = frame->measuredWidth;
		const double h = frame->measuredHeight;

		double x = contentL;
		double y = contentT;

		switch (node->frame->contentDirection) {

			case kDisplayNodeContentDirectionVertical:

				x = round(x + this->resolveAlignment(child, alignmentSpace), scale);
				y = round(y + offset + marginT, scale);

				offset = offset + h + marginT + marginB + spacer;

				break;

			case kDisplayNodeContentDirectionHorizontal:

				x = round(x + offset + marginL, scale);
				y = round(y + this->resolveAlignment(child, alignmentSpace), scale);

				offset = offset + w + marginL + marginR + spacer;

				break;

			default:
				cerr << "Invalid content direction";
				abort();
		}

		const double anchorTop = frame->measureAnchorTop();
		const double anchorLeft = frame->measureAnchorLeft();

		const double measuredT = y - anchorTop;
		const double measuredL = x - anchorLeft;
		const double measuredR = (child->parent->frame->measuredContentWidth - frame->measuredWidth - x) - anchorLeft;
		const double measuredB = (child->parent->frame->measuredContentHeight - frame->measuredHeight - y) - anchorTop;

		if (frame->measuredTop != measuredT ||
			frame->measuredLeft != measuredL ||
			frame->measuredRight != measuredR ||
			frame->measuredBottom != measuredB) {

			frame->measuredTop = measuredT;
			frame->measuredLeft = measuredL;
			frame->measuredRight = measuredR;
			frame->measuredBottom = measuredB;

			child->didResolveOrigin();
		}

		this->extentTop = min(this->extentTop, frame->measuredTop + frame->measuredMarginTop);
		this->extentLeft = min(this->extentLeft, frame->measuredLeft + frame->measuredMarginBottom);
		this->extentRight = max(this->extentRight, frame->measuredLeft + frame->measuredWidth + frame->measuredMarginRight);
		this->extentBottom = max(this->extentBottom, frame->measuredTop + frame->measuredHeight + frame->measuredMarginBottom);

		frame->invalidSize = false;
		frame->invalidOrigin = false;

		frame->resolvedSize = true;
		frame->resolvedOrigin = true;
		frame->resolvedParent = node;
	}

	this->extentRight += paddingR;
	this->extentBottom += paddingB;

	this->nodes.clear();
}

}
}
