#include "AbsoluteLayoutResolver.h"
#include "LayoutResolver.h"
#include "Display.h"
#include "DisplayNode.h"
#include "InvalidOperationException.h"

#include <iostream>
#include <cstdlib>

namespace Dezel {
namespace Layout {

using std::min;
using std::max;

AbsoluteLayoutResolver::AbsoluteLayoutResolver(DisplayNode* node)
{
	this->node = node;
}

//------------------------------------------------------------------------------
// MARK: Private API
//------------------------------------------------------------------------------

bool
AbsoluteLayoutResolver::hasInvalidSize(DisplayNode* child)
{
	if (child->invalidSize ||
		child->resolvedSize == false) {
		return true;
	}

	if (child->width.unit == kDisplayNodeSizeUnitPX &&
		child->height.unit == kDisplayNodeSizeUnitPX) {
		return false;
	}

	const auto parent = child->parent;

	if (parent->measuredContentWidthChanged || child->hasNewParent()) {
		if (child->width.unit == kDisplayNodeSizeUnitPC ||
			child->width.type == kDisplayNodeSizeTypeFill ||
			child->right.type != kDisplayNodeOriginTypeAuto) {
			return true;
		}
	}

	if (parent->measuredContentHeightChanged || child->hasNewParent()) {
		if (child->height.unit == kDisplayNodeSizeUnitPC ||
			child->height.type == kDisplayNodeSizeTypeFill ||
			child->bottom.type != kDisplayNodeOriginTypeAuto) {
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

	if (child->display->hasViewportHeightChanged()) {
		if (child->width.unit == kDisplayNodeSizeUnitVH ||
			child->height.unit == kDisplayNodeSizeUnitVH) {
			return true;
		}
	}

	return false;
}

bool
AbsoluteLayoutResolver::hasInvalidOrigin(DisplayNode* child)
{
	if (child->invalidOrigin ||
		child->resolvedOrigin == false) {
		return true;
	}

	if (child->top.unit == kDisplayNodeOriginUnitPX &&
		child->left.unit == kDisplayNodeOriginUnitPX &&
		child->right.type == kDisplayNodeOriginTypeAuto &&
		child->bottom.type == kDisplayNodeOriginTypeAuto) {
		return false;
	}

	if ((child->anchorTop.length > 0.0 && child->measuredHeightChanged) ||
		(child->anchorLeft.length > 0.0 && child->measuredWidthChanged)) {
		return true;
	}

	const auto parent = child->parent;

	if (parent->measuredContentWidthChanged || child->hasNewParent()) {
		if (child->left.unit == kDisplayNodeOriginUnitPC ||
			child->right.unit == kDisplayNodeOriginUnitPC) {
			return true;
		}
	}

	if (parent->measuredContentHeightChanged || child->hasNewParent()) {
		if (child->top.unit == kDisplayNodeOriginUnitPC ||
			child->bottom.unit == kDisplayNodeOriginUnitPC) {
			return true;
		}
	}

	if (parent->measuredInnerWidthChanged || child->hasNewParent()) {
		if (child->top.unit == kDisplayNodeOriginUnitPW ||
			child->left.unit == kDisplayNodeOriginUnitPW ||
			child->right.unit == kDisplayNodeOriginUnitPW ||
			child->bottom.unit == kDisplayNodeOriginUnitPW) {
			return true;
		}
	}

	if (parent->measuredInnerHeightChanged || child->hasNewParent()) {
		if (child->top.unit == kDisplayNodeOriginUnitPH ||
			child->left.unit == kDisplayNodeOriginUnitPH ||
			child->right.unit == kDisplayNodeOriginUnitPH ||
			child->bottom.unit == kDisplayNodeOriginUnitPH) {
			return true;
		}
	}

	if (parent->measuredContentWidthChanged || child->hasNewParent()) {
		if (child->top.unit == kDisplayNodeOriginUnitCW ||
			child->left.unit == kDisplayNodeOriginUnitCW ||
			child->right.unit == kDisplayNodeOriginUnitCW ||
			child->bottom.unit == kDisplayNodeOriginUnitCW) {
			return true;
		}
	}

	if (parent->measuredContentHeightChanged || child->hasNewParent()) {
		if (child->top.unit == kDisplayNodeOriginUnitCH ||
			child->left.unit == kDisplayNodeOriginUnitCH ||
			child->right.unit == kDisplayNodeOriginUnitCH ||
			child->bottom.unit == kDisplayNodeOriginUnitCH) {
			return true;
		}
	}

	if (child->display->hasNewViewportWidth()) {
		if (child->top.unit == kDisplayNodeOriginUnitVW ||
			child->left.unit == kDisplayNodeOriginUnitVW ||
			child->right.unit == kDisplayNodeOriginUnitVW ||
			child->bottom.unit == kDisplayNodeOriginUnitVW) {
			return true;
		}
	}

	if (child->display->hasNewViewportWidth()) {
		if (child->top.unit == kDisplayNodeOriginUnitVH ||
			child->left.unit == kDisplayNodeOriginUnitVH ||
			child->right.unit == kDisplayNodeOriginUnitVH ||
			child->bottom.unit == kDisplayNodeOriginUnitVH) {
			return true;
		}
	}

	return false;
}

double
AbsoluteLayoutResolver::measureTop(DisplayNode* child)
{
	const auto type = child->top.type;
	const auto unit = child->top.unit;

	double value = child->top.length;

	if (type == kDisplayNodeOriginTypeLength) {

		switch (unit) {

			case kDisplayNodeOriginUnitPC: value = scale(value, child->parent->measuredContentHeight); break;
			case kDisplayNodeOriginUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kDisplayNodeOriginUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kDisplayNodeOriginUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kDisplayNodeOriginUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kDisplayNodeOriginUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kDisplayNodeOriginUnitVH: value = scale(value, child->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		child->top.min,
		child->top.max
	);

	value += child->parent->measuredContentTop;

	return round(value, child->display->scale);;
}

double
AbsoluteLayoutResolver::measureLeft(DisplayNode* child)
{
	const auto type = child->left.type;
	const auto unit = child->left.unit;

	double value = child->left.length;

	if (type == kDisplayNodeOriginTypeLength) {

		switch (unit) {

			case kDisplayNodeOriginUnitPC: value = scale(value, child->parent->measuredContentWidth); break;
			case kDisplayNodeOriginUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kDisplayNodeOriginUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kDisplayNodeOriginUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kDisplayNodeOriginUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kDisplayNodeOriginUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kDisplayNodeOriginUnitVH: value = scale(value, child->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		child->left.min,
		child->left.max
	);

	value += child->parent->measuredContentLeft;

	return round(value, child->display->scale);
}

double
AbsoluteLayoutResolver::measureRight(DisplayNode* child)
{
	const auto type = child->right.type;
	const auto unit = child->right.unit;

	double value = child->right.length;

	if (type == kDisplayNodeOriginTypeLength) {

		switch (unit) {

			case kDisplayNodeOriginUnitPC: value = scale(value, child->parent->measuredContentWidth); break;
			case kDisplayNodeOriginUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kDisplayNodeOriginUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kDisplayNodeOriginUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kDisplayNodeOriginUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kDisplayNodeOriginUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kDisplayNodeOriginUnitVH: value = scale(value, child->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		child->right.min,
		child->right.max
	);

	value += child->parent->measuredContentLeft;

	return round(value, child->display->scale);
}

double
AbsoluteLayoutResolver::measureBottom(DisplayNode* child)
{
	const auto type = child->bottom.type;
	const auto unit = child->bottom.unit;

	double value = child->bottom.length;

	if (type == kDisplayNodeOriginTypeLength) {

		switch (unit) {

			case kDisplayNodeOriginUnitPC: value = scale(value, child->parent->measuredContentHeight); break;
			case kDisplayNodeOriginUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kDisplayNodeOriginUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kDisplayNodeOriginUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kDisplayNodeOriginUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kDisplayNodeOriginUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kDisplayNodeOriginUnitVH: value = scale(value, child->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		child->bottom.min,
		child->bottom.max
	);

	value += child->parent->measuredContentTop;

	return round(value, child->display->scale);
}

double
AbsoluteLayoutResolver::measureWidth(DisplayNode* child)
{
	const auto marginL = child->measuredMarginLeft;
	const auto marginR = child->measuredMarginRight;

	const auto type = child->width.type;
	const auto unit = child->width.unit;

	const auto l = child->left.type;
	const auto r = child->right.type;

	double value = child->width.length;
	double nodeL = 0;
	double nodeR = 0;

	if (l != kDisplayNodeOriginTypeAuto) nodeL = this->measureLeft(child);
	if (r != kDisplayNodeOriginTypeAuto) nodeR = this->measureRight(child);

	if (l != kDisplayNodeOriginTypeAuto &&
		r != kDisplayNodeOriginTypeAuto) {

		value = child->parent->measuredContentWidth - (nodeL + marginL) - (nodeR + marginR);

	} else if (type == kDisplayNodeSizeTypeFill) {

		 if (l == kDisplayNodeOriginTypeAuto &&
		 	 r == kDisplayNodeOriginTypeAuto) {

			value = child->parent->measuredContentWidth - marginL - marginR;

		} else if (l != kDisplayNodeOriginTypeAuto) {

			value = child->parent->measuredContentWidth - (nodeL + marginL);

		} else if (r != kDisplayNodeOriginTypeAuto) {

			value = child->parent->measuredContentWidth - (nodeR + marginR);

		}

	} else if (type == kDisplayNodeSizeTypeWrap) {

		throw InvalidOperationException("This method does not measuring wrapped node.");

	} else if (type == kDisplayNodeSizeTypeLength) {

		switch (unit) {
			case kDisplayNodeSizeUnitPC: value = scale(value, child->parent->measuredContentWidth); break;
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

	return round(value, child->display->scale);
}

double
AbsoluteLayoutResolver::measureHeight(DisplayNode* child)
{
	const auto marginT = child->measuredMarginTop;
	const auto marginB = child->measuredMarginBottom;

	const auto type = child->height.type;
	const auto unit = child->height.unit;

	const auto t = child->top.type;
	const auto b = child->bottom.type;

	double nodeT = 0;
	double nodeB = 0;
	double value = child->height.length;

	if (t != kDisplayNodeOriginTypeAuto) nodeT = this->measureTop(child);
	if (b != kDisplayNodeOriginTypeAuto) nodeB = this->measureBottom(child);

	if (t != kDisplayNodeOriginTypeAuto &&
		b != kDisplayNodeOriginTypeAuto) {

		value = child->parent->measuredContentHeight - (nodeT + marginT) - (nodeB + marginB);

	} else if (type == kDisplayNodeSizeTypeFill) {

		if (t == kDisplayNodeOriginTypeAuto &&
			b == kDisplayNodeOriginTypeAuto) {

			value = child->parent->measuredContentHeight - marginT - marginB;

		} else if (t != kDisplayNodeOriginTypeAuto) {

			value = child->parent->measuredContentHeight - (nodeT + marginT);

		} else if (b != kDisplayNodeOriginTypeAuto) {

			value = child->parent->measuredContentHeight - (nodeB + marginB);
		}

	} else if (type == kDisplayNodeSizeTypeWrap) {

		throw InvalidOperationException("This method does not measuring wrapped node.");

	} else if (type == kDisplayNodeSizeTypeLength) {

		switch (unit) {
			case kDisplayNodeSizeUnitPC: value = scale(value, child->parent->measuredContentHeight); break;
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

	return round(value, child->display->scale);
}

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

void
AbsoluteLayoutResolver::measure(DisplayNode* child)
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
		if (wrapW == false) measuredW = this->measureWidth(child);
		if (wrapH == false) measuredH = this->measureHeight(child);
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
AbsoluteLayoutResolver::resolve()
{
	if (this->nodes.size() == 0) {
		return;
	}

	for (auto child : this->nodes) {

		this->measure(child);

		if (child->lastMeasuredWidth != child->measuredWidth ||
			child->lastMeasuredHeight != child->measuredHeight) {
			child->lastMeasuredWidth = child->measuredWidth;
			child->lastMeasuredHeight = child->measuredHeight;
			child->didResolveSize();
		}

		if (this->hasInvalidOrigin(child)) {

			double measuredT = this->measureTop(child);
			double measuredL = this->measureLeft(child);
			double measuredR = this->measureRight(child);
			double measuredB = this->measureBottom(child);

			const auto t = child->top.type;
			const auto l = child->left.type;
			const auto r = child->right.type;
			const auto b = child->bottom.type;

			if (l == kDisplayNodeOriginTypeAuto &&
				r == kDisplayNodeOriginTypeLength) {
				measuredL = child->parent->measuredContentWidth - measuredR - child->measuredWidth;
			}

			if (t == kDisplayNodeOriginTypeAuto &&
				b == kDisplayNodeOriginTypeLength) {
				measuredT = child->parent->measuredContentHeight - measuredB - child->measuredHeight;
			}

			const auto anchorT = child->measureAnchorTop();
			const auto anchorL = child->measureAnchorLeft();

			measuredT = measuredT + child->measuredMarginTop - anchorT;
			measuredL = measuredL + child->measuredMarginLeft - anchorL;
			measuredR = measuredR + child->measuredMarginRight - anchorL;
			measuredB = measuredB + child->measuredMarginBottom - anchorT;

			if (child->measuredTop != measuredT ||
				child->measuredLeft != measuredL) {

				child->measuredTop = measuredT;
				child->measuredLeft = measuredL;
				child->measuredRight = measuredR;
				child->measuredBottom = measuredB;

				child->didResolveOrigin();
			}
		}

		child->resolvedSize = true;
		child->resolvedOrigin = true;
		child->resolvedParent = node;

		child->invalidSize = false;
		child->invalidOrigin = false;
	}

	this->nodes.clear();
}

}
}
