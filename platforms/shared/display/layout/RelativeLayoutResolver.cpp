#include "RelativeLayoutResolver.h"
#include "LayoutResolver.h"
#include "Display.h"
#include "DisplayNode.h"

#include <iostream>

namespace Dezel {
namespace Layout {

using std::cerr;
using std::min;
using std::max;

RelativeLayoutResolver::RelativeLayoutResolver(DisplayNode* node)
{
	this->node = node;
}

bool
RelativeLayoutResolver::hasInvalidSize(DisplayNode* child)
{
	if (child->invalidSize ||
		child->resolvedSize == false) {
		return true;
	}

	if (child->shrinkFactor > 0 ||
		child->expandFactor > 0) {
		return true;
	}

	if (child->width.unit == kDisplayNodeSizeUnitPX &&
		child->height.unit == kDisplayNodeSizeUnitPX) {
		return false;
	}

	auto parent = child->parent;

	if (parent->measuredContentWidthChanged || child->hasNewParent()) {
		if (child->width.unit == kDisplayNodeSizeUnitPC ||
			child->width.type == kDisplayNodeSizeTypeFill) {
			return true;
		}
	}

	if (parent->measuredContentHeightChanged || child->hasNewParent()) {
		if (child->height.unit == kDisplayNodeSizeUnitPC ||
			child->height.type == kDisplayNodeSizeTypeFill) {
			return true;
		}
	}

	if (parent->measuredInnerWidthChanged || child->hasNewParent()) {
		if (child->width.unit == kDisplayNodeSizeUnitPW ||
			child->height.unit == kDisplayNodeSizeUnitPW) {
			return true;
		}
	}

	if (parent->measuredInnerHeightChanged || child->hasNewParent()) {
		if (child->width.unit == kDisplayNodeSizeUnitPH ||
			child->height.unit == kDisplayNodeSizeUnitPH) {
			return true;
		}
	}

	if (parent->measuredContentWidthChanged || child->hasNewParent()) {
		if (child->width.unit == kDisplayNodeSizeUnitCW ||
			child->height.unit == kDisplayNodeSizeUnitCW) {
			return true;
		}
	}

	if (parent->measuredContentHeightChanged || child->hasNewParent()) {
		if (child->width.unit == kDisplayNodeSizeUnitCH ||
			child->height.unit == kDisplayNodeSizeUnitCH) {
			return true;
		}
	}

	if (child->display->hasNewViewportWidth()) {
		if (child->width.unit == kDisplayNodeSizeUnitVW ||
			child->height.unit == kDisplayNodeSizeUnitVH) {
			return true;
		}
	}

	if (child->display->hasNewViewportWidth()) {
		if (child->width.unit == kDisplayNodeSizeUnitVH ||
			child->height.unit == kDisplayNodeSizeUnitVH) {
			return true;
		}
	}

	return false;
}

bool
RelativeLayoutResolver::hasInvalidOrigin(DisplayNode* node)
{
	return true;
}

double
RelativeLayoutResolver::measureWidth(DisplayNode* child, double remaining)
{
	const auto type = child->width.type;
	const auto unit = child->width.unit;

	double value = child->width.length;

	if (type == kDisplayNodeSizeTypeFill) {

		value = remaining - child->measuredMarginLeft - child->measuredMarginRight;

	} else if (type == kDisplayNodeSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kDisplayNodeSizeTypeLength) {

		switch (unit) {
			case kDisplayNodeSizeUnitPC: value = scale(value, child->parent->measuredContentWidth - child->parent->measuredPaddingLeft - child->parent->measuredPaddingRight); break;
			case kDisplayNodeSizeUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kDisplayNodeSizeUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kDisplayNodeSizeUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kDisplayNodeSizeUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kDisplayNodeSizeUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kDisplayNodeSizeUnitVH: value = scale(value, child->display->viewportHeight); break;
			default: break;
		}
	}

	value = clamp(
		value,
		child->width.min,
		child->width.max
	);

	return value;
}

double
RelativeLayoutResolver::measureHeight(DisplayNode* child, double remaining)
{
	const auto type = child->height.type;
	const auto unit = child->height.unit;

	double value = child->height.length;

	if (type == kDisplayNodeSizeTypeFill) {

		value = remaining - child->measuredMarginTop - child->measuredMarginBottom;

	} else if (type == kDisplayNodeSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kDisplayNodeSizeTypeLength) {

		switch (unit) {
			case kDisplayNodeSizeUnitPC: value = scale(value, child->parent->measuredContentHeight - child->parent->measuredPaddingTop - child->parent->measuredPaddingBottom); break;
			case kDisplayNodeSizeUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kDisplayNodeSizeUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kDisplayNodeSizeUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kDisplayNodeSizeUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kDisplayNodeSizeUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kDisplayNodeSizeUnitVH: value = scale(value, child->display->viewportHeight); break;
			default: break;
		}

	}

	value = clamp(
		value,
		child->height.min,
		child->height.max
	);

	return value;
}

double
RelativeLayoutResolver::resolveAlignment(DisplayNode* child, double remaining)
{
	double size = 0;
	double headOffset = 0;
	double tailOffset = 0;

	switch (child->parent->contentDirection) {

		case kDisplayNodeContentDirectionVertical:
			size = child->measuredWidth;
			headOffset = child->measuredMarginLeft;
			tailOffset = child->measuredMarginRight;
			break;

		case kDisplayNodeContentDirectionHorizontal:
			size = child->measuredHeight;
			headOffset = child->measuredMarginTop;
			tailOffset = child->measuredMarginBottom;
			break;
	}

	double offset = 0;

	switch (child->parent->contentAlignment) {

		case kDisplayNodeContentAlignmentStart:
			offset = headOffset;
			break;

		case kDisplayNodeContentAlignmentCenter:
			offset = this->alignMid(size, remaining) + headOffset - tailOffset;
			break;

		case kDisplayNodeContentAlignmentEnd:
			offset = this->alignEnd(size, remaining) - tailOffset;
			break;
	}

	return offset;
}

void
RelativeLayoutResolver::expandNodesVertically(const vector<DisplayNode*> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		double measuredH = child->measuredHeight + (child->expandFactor / weights * space);

		measuredH = round(measuredH, child->display->getScale(), remainder);

		if (child->measuredHeight != measuredH) {
			child->measuredHeight = measuredH;
			child->measuredHeightChanged = true;
		}
	}
}

void
RelativeLayoutResolver::expandNodesHorizontally(const vector<DisplayNode*> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		double measuredW = child->measuredWidth + (child->expandFactor / weights * space);

		measuredW = round(measuredW, child->display->getScale(), remainder);

		if (child->measuredWidth != measuredW) {
			child->measuredWidth = measuredW;
			child->measuredWidthChanged = true;
		}
	}
}

void
RelativeLayoutResolver::shrinkNodesVertically(const vector<DisplayNode*> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		double measuredH = child->measuredHeight + (child->shrinkFactor / weights * space);

		measuredH = round(measuredH, child->display->getScale(), remainder);

		if (child->measuredHeight != measuredH) {
			child->measuredHeight = measuredH;
			child->measuredHeightChanged = true;
		}
	}
}

void
RelativeLayoutResolver::shrinkNodesHorizontally(const vector<DisplayNode*> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		double measuredW = child->measuredWidth + (child->shrinkFactor / weights * space);

		measuredW = round(measuredW, child->display->getScale(), remainder);

		if (child->measuredWidth != measuredW) {
			child->measuredWidth = measuredW;
			child->measuredWidthChanged = true;
		}
	}
}

void
RelativeLayoutResolver::measure(DisplayNode* child, double &remainingW, double &remainingH, double &remainder)
{
	const bool wrapW = child->inheritedWrappedContentWidth;
	const bool wrapH = child->inheritedWrappedContentHeight;

	auto measuredW = child->measuredWidth;
	auto measuredH = child->measuredHeight;

	child->measuredWidthChanged = false;
	child->measuredHeightChanged = false;

	/*
	 * Resolving the node margin must be done before measuring because
	 * it might influence its size, for instance, when using negatives
	 * margins on opposite sides.
	 */

	child->resolveMargin();

	if (this->hasInvalidSize(child)) {

		if (wrapW == false) measuredW = this->measureWidth(child, remainingW);
		if (wrapH == false) measuredH = this->measureHeight(child, remainingH);

		const double scale = child->display->getScale();

		switch (child->contentDirection) {

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

		child->resolveWrapper(measuredW, measuredH);

	} else {

		if (child->measuredWidth != measuredW) {
			child->measuredWidth = measuredW;
			child->measuredWidthChanged = true;
			child->invalidateInnerSize();
		}

		if (child->measuredHeight != measuredH) {
			child->measuredHeight = measuredH;
			child->measuredHeightChanged = true;
			child->invalidateInnerSize();
		}
	}
}

void
RelativeLayoutResolver::resolve()
{
	if (this->nodes.size() == 0) {
		return;
	}

	this->extentTop = 0;
	this->extentLeft = 0;
	this->extentRight = 0;
	this->extentBottom = 0;

	const double scale = this->node->display->getScale();

	const double paddingT = this->node->measuredPaddingTop;
	const double paddingL = this->node->measuredPaddingLeft;
	const double paddingR = this->node->measuredPaddingRight;
	const double paddingB = this->node->measuredPaddingBottom;

	const double contentW = max(this->node->measuredContentWidth - paddingL - paddingR, 0.0);
	const double contentH = max(this->node->measuredContentHeight - paddingT - paddingB, 0.0);
	const double contentT = this->node->measuredContentTop + paddingT;
	const double contentL = this->node->measuredContentLeft + paddingL;

	double remainder = 0;
	double remainingW = contentW;
	double remainingH = contentH;
	double expandablesWeight = 0;
	double shrinkablesWeight = 0;

	vector<DisplayNode*> shrinkables;
	vector<DisplayNode*> expandables;

	for (auto child : this->nodes) {

		this->measure(
			child,
			remainingW,
			remainingH,
			remainder
		);

		switch (this->node->contentDirection) {

			case kDisplayNodeContentDirectionVertical:
				remainingH -= child->measuredHeight;
				remainingH -= child->measuredMarginTop;
				remainingH -= child->measuredMarginBottom;
				break;

			case kDisplayNodeContentDirectionHorizontal:
				remainingW -= child->measuredWidth;
				remainingW -= child->measuredMarginLeft;
				remainingW -= child->measuredMarginRight;
				break;
		}

		if (child->shrinkFactor > 0) {
			shrinkables.push_back(child);
			shrinkablesWeight += child->shrinkFactor;
		}

		if (child->expandFactor > 0) {
			expandables.push_back(child);
			expandablesWeight += child->expandFactor;
		}
	}

	const bool wrapW = this->node->width.type == kDisplayNodeSizeTypeWrap;
	const bool wrapH = this->node->height.type == kDisplayNodeSizeTypeWrap;

	if (wrapW) remainingW = max(remainingW, 0.0);
	if (wrapH) remainingH = max(remainingH, 0.0);

	double directionSpace = 0;
	double alignmentSpace = 0;

	switch (this->node->contentDirection) {

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

			switch (this->node->contentDirection) {

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

			switch (this->node->contentDirection) {

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
		if (child->lastMeasuredWidth != child->measuredWidth ||
			child->lastMeasuredHeight != child->measuredHeight) {
			child->lastMeasuredWidth = child->measuredWidth;
			child->lastMeasuredHeight = child->measuredHeight;
			child->didResolveSize();
		}
	}

	double offset = 0;
	double spacer = 0;

	switch (this->node->contentDisposition) {

		case kDisplayNodeContentDispositionStart:
			offset = 0;
			break;

		case kDisplayNodeContentDispositionEnd:
			offset = directionSpace;
			break;

		case kDisplayNodeContentDispositionCenter:
			offset = directionSpace / 2;
			break;

		case kDisplayNodeContentDispositionSpaceBetween:
			spacer = directionSpace / (nodes.size() - 1);
			offset = 0;
			break;

		case kDisplayNodeContentDispositionSpaceEvenly:
			spacer = directionSpace / (nodes.size() + 1);
			offset = spacer;
			break;

		case kDisplayNodeContentDispositionSpaceAround:
			spacer = directionSpace / (nodes.size() + 1);
			offset = spacer / 2;
			break;
	}

	for (auto child : this->nodes) {

		const double marginT = child->measuredMarginTop;
		const double marginL = child->measuredMarginLeft;
		const double marginR = child->measuredMarginRight;
		const double marginB = child->measuredMarginBottom;

		const double w = child->measuredWidth;
		const double h = child->measuredHeight;

		double x = contentL;
		double y = contentT;

		switch (this->node->contentDirection) {

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

		const double anchorTop = child->measureAnchorTop();
		const double anchorLeft = child->measureAnchorLeft();

		const double measuredT = y - anchorTop;
		const double measuredL = x - anchorLeft;
		const double measuredR = (child->parent->measuredContentWidth - child->measuredWidth - x) - anchorLeft;
		const double measuredB = (child->parent->measuredContentHeight - child->measuredHeight - y) - anchorTop;

		if (child->measuredTop != measuredT ||
			child->measuredLeft != measuredL ||
			child->measuredRight != measuredR ||
			child->measuredBottom != measuredB) {

			child->measuredTop = measuredT;
			child->measuredLeft = measuredL;
			child->measuredRight = measuredR;
			child->measuredBottom = measuredB;

			child->didResolveOrigin();
		}

		this->extentTop = min(this->extentTop, child->measuredTop + child->measuredMarginTop);
		this->extentLeft = min(this->extentLeft, child->measuredLeft + child->measuredMarginBottom);
		this->extentRight = max(this->extentRight, child->measuredLeft + child->measuredWidth + child->measuredMarginRight);
		this->extentBottom = max(this->extentBottom, child->measuredTop + child->measuredHeight + child->measuredMarginBottom);

		child->invalidSize = false;
		child->invalidOrigin = false;

		child->resolvedSize = true;
		child->resolvedOrigin = true;
		child->resolvedParent = node;
	}

	this->extentRight += paddingR;
	this->extentBottom += paddingB;

	this->nodes.clear();
}

}
}
