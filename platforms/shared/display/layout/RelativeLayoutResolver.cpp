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

//------------------------------------------------------------------------------
// MARK: Private API
//------------------------------------------------------------------------------

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

	if (child->width.unit == kSizeUnitPX &&
		child->height.unit == kSizeUnitPX) {
		return false;
	}

	auto parent = child->parent;

	if (parent->measuredContentWidthChanged || child->hasNewParent()) {
		if (child->width.unit == kSizeUnitPC ||
			child->width.type == kSizeTypeFill) {
			return true;
		}
	}

	if (parent->measuredContentHeightChanged || child->hasNewParent()) {
		if (child->height.unit == kSizeUnitPC ||
			child->height.type == kSizeTypeFill) {
			return true;
		}
	}

	if (parent->measuredInnerWidthChanged || child->hasNewParent()) {
		if (child->width.unit == kSizeUnitPW ||
			child->height.unit == kSizeUnitPW) {
			return true;
		}
	}

	if (parent->measuredInnerHeightChanged || child->hasNewParent()) {
		if (child->width.unit == kSizeUnitPH ||
			child->height.unit == kSizeUnitPH) {
			return true;
		}
	}

	if (parent->measuredContentWidthChanged || child->hasNewParent()) {
		if (child->width.unit == kSizeUnitCW ||
			child->height.unit == kSizeUnitCW) {
			return true;
		}
	}

	if (parent->measuredContentHeightChanged || child->hasNewParent()) {
		if (child->width.unit == kSizeUnitCH ||
			child->height.unit == kSizeUnitCH) {
			return true;
		}
	}

	if (child->display->hasNewViewportWidth()) {
		if (child->width.unit == kSizeUnitVW ||
			child->height.unit == kSizeUnitVH) {
			return true;
		}
	}

	if (child->display->hasNewViewportWidth()) {
		if (child->width.unit == kSizeUnitVH ||
			child->height.unit == kSizeUnitVH) {
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

	if (type == kSizeTypeFill) {

		value = remaining - child->measuredMarginLeft - child->measuredMarginRight;

	} else if (type == kSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kSizeTypeLength) {

		switch (unit) {
			case kSizeUnitPC: value = scale(value, child->parent->measuredContentWidth - child->parent->measuredPaddingLeft - child->parent->measuredPaddingRight); break;
			case kSizeUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kSizeUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kSizeUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kSizeUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kSizeUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kSizeUnitVH: value = scale(value, child->display->viewportHeight); break;
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

	if (type == kSizeTypeFill) {

		value = remaining - child->measuredMarginTop - child->measuredMarginBottom;

	} else if (type == kSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kSizeTypeLength) {

		switch (unit) {
			case kSizeUnitPC: value = scale(value, child->parent->measuredContentHeight - child->parent->measuredPaddingTop - child->parent->measuredPaddingBottom); break;
			case kSizeUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kSizeUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kSizeUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kSizeUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kSizeUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kSizeUnitVH: value = scale(value, child->display->viewportHeight); break;
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

		case kContentDirectionVertical:
			size = child->measuredWidth;
			headOffset = child->measuredMarginLeft;
			tailOffset = child->measuredMarginRight;
			break;

		case kContentDirectionHorizontal:
			size = child->measuredHeight;
			headOffset = child->measuredMarginTop;
			tailOffset = child->measuredMarginBottom;
			break;
	}

	double offset = 0;

	switch (child->parent->contentAlignment) {

		case kContentAlignmentStart:
			offset = headOffset;
			break;

		case kContentAlignmentCenter:
			offset = this->alignMid(size, remaining) + headOffset - tailOffset;
			break;

		case kContentAlignmentEnd:
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

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

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

			case kContentDirectionVertical:
				if (wrapW == false) measuredW = round(measuredW, scale);
				if (wrapH == false) measuredH = round(measuredH, scale, remainder);
				break;

			case kContentDirectionHorizontal:
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

			case kContentDirectionVertical:
				remainingH -= child->measuredHeight;
				remainingH -= child->measuredMarginTop;
				remainingH -= child->measuredMarginBottom;
				break;

			case kContentDirectionHorizontal:
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

	const bool wrapW = this->node->width.type == kSizeTypeWrap;
	const bool wrapH = this->node->height.type == kSizeTypeWrap;

	if (wrapW) remainingW = max(remainingW, 0.0);
	if (wrapH) remainingH = max(remainingH, 0.0);

	double directionSpace = 0;
	double alignmentSpace = 0;

	switch (this->node->contentDirection) {

		case kContentDirectionVertical:
			directionSpace = remainingH;
			alignmentSpace = remainingW;
			break;

		case kContentDirectionHorizontal:
			directionSpace = remainingW;
			alignmentSpace = remainingH;
			break;
	}

	if (directionSpace > 0) {

		if (expandables.size()) {

			switch (this->node->contentDirection) {

				case kContentDirectionVertical:
					this->expandNodesVertically(expandables, remainingH, expandablesWeight);
					break;

				case kContentDirectionHorizontal:
					this->expandNodesHorizontally(expandables, remainingW, expandablesWeight);
					break;
			}

			directionSpace = 0;
		}

	} else if (directionSpace < 0) {

		if (shrinkables.size()) {

			switch (this->node->contentDirection) {

				case kContentDirectionVertical:
					this->shrinkNodesVertically(shrinkables, remainingH, shrinkablesWeight);
					break;

				case kContentDirectionHorizontal:
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

		case kContentDispositionStart:
			offset = 0;
			break;

		case kContentDispositionEnd:
			offset = directionSpace;
			break;

		case kContentDispositionCenter:
			offset = directionSpace / 2;
			break;

		case kContentDispositionSpaceBetween:
			spacer = directionSpace / (nodes.size() - 1);
			offset = 0;
			break;

		case kContentDispositionSpaceEvenly:
			spacer = directionSpace / (nodes.size() + 1);
			offset = spacer;
			break;

		case kContentDispositionSpaceAround:
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

			case kContentDirectionVertical:

				x = round(x + this->resolveAlignment(child, alignmentSpace), scale);
				y = round(y + offset + marginT, scale);

				offset = offset + h + marginT + marginB + spacer;

				break;

			case kContentDirectionHorizontal:

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
		child->resolvedParent = this->node;
	}

	this->extentRight += paddingR;
	this->extentBottom += paddingB;

	this->nodes.clear();
}

}
}
