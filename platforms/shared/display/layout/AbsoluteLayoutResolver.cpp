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

	if (child->width.unit == kSizeUnitPX &&
		child->height.unit == kSizeUnitPX) {
		return false;
	}

	const auto parent = child->parent;

	if (parent->measuredContentWidthChanged || child->hasNewParent()) {
		if (child->width.unit == kSizeUnitPC ||
			child->width.type == kSizeTypeFill ||
			child->right.type != kOriginTypeAuto) {
			return true;
		}
	}

	if (parent->measuredContentHeightChanged || child->hasNewParent()) {
		if (child->height.unit == kSizeUnitPC ||
			child->height.type == kSizeTypeFill ||
			child->bottom.type != kOriginTypeAuto) {
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

	if (child->display->hasViewportHeightChanged()) {
		if (child->width.unit == kSizeUnitVH ||
			child->height.unit == kSizeUnitVH) {
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

	if (child->top.unit == kOriginUnitPX &&
		child->left.unit == kOriginUnitPX &&
		child->right.type == kOriginTypeAuto &&
		child->bottom.type == kOriginTypeAuto) {
		return false;
	}

	if ((child->anchorTop.length > 0.0 && child->measuredHeightChanged) ||
		(child->anchorLeft.length > 0.0 && child->measuredWidthChanged)) {
		return true;
	}

	const auto parent = child->parent;

	if (parent->measuredContentWidthChanged || child->hasNewParent()) {
		if (child->left.unit == kOriginUnitPC ||
			child->right.unit == kOriginUnitPC) {
			return true;
		}
	}

	if (parent->measuredContentHeightChanged || child->hasNewParent()) {
		if (child->top.unit == kOriginUnitPC ||
			child->bottom.unit == kOriginUnitPC) {
			return true;
		}
	}

	if (parent->measuredInnerWidthChanged || child->hasNewParent()) {
		if (child->top.unit == kOriginUnitPW ||
			child->left.unit == kOriginUnitPW ||
			child->right.unit == kOriginUnitPW ||
			child->bottom.unit == kOriginUnitPW) {
			return true;
		}
	}

	if (parent->measuredInnerHeightChanged || child->hasNewParent()) {
		if (child->top.unit == kOriginUnitPH ||
			child->left.unit == kOriginUnitPH ||
			child->right.unit == kOriginUnitPH ||
			child->bottom.unit == kOriginUnitPH) {
			return true;
		}
	}

	if (parent->measuredContentWidthChanged || child->hasNewParent()) {
		if (child->top.unit == kOriginUnitCW ||
			child->left.unit == kOriginUnitCW ||
			child->right.unit == kOriginUnitCW ||
			child->bottom.unit == kOriginUnitCW) {
			return true;
		}
	}

	if (parent->measuredContentHeightChanged || child->hasNewParent()) {
		if (child->top.unit == kOriginUnitCH ||
			child->left.unit == kOriginUnitCH ||
			child->right.unit == kOriginUnitCH ||
			child->bottom.unit == kOriginUnitCH) {
			return true;
		}
	}

	if (child->display->hasNewViewportWidth()) {
		if (child->top.unit == kOriginUnitVW ||
			child->left.unit == kOriginUnitVW ||
			child->right.unit == kOriginUnitVW ||
			child->bottom.unit == kOriginUnitVW) {
			return true;
		}
	}

	if (child->display->hasNewViewportWidth()) {
		if (child->top.unit == kOriginUnitVH ||
			child->left.unit == kOriginUnitVH ||
			child->right.unit == kOriginUnitVH ||
			child->bottom.unit == kOriginUnitVH) {
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

	if (type == kOriginTypeLength) {

		switch (unit) {

			case kOriginUnitPC: value = scale(value, child->parent->measuredContentHeight); break;
			case kOriginUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kOriginUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kOriginUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kOriginUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kOriginUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kOriginUnitVH: value = scale(value, child->display->viewportHeight); break;
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

	if (type == kOriginTypeLength) {

		switch (unit) {

			case kOriginUnitPC: value = scale(value, child->parent->measuredContentWidth); break;
			case kOriginUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kOriginUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kOriginUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kOriginUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kOriginUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kOriginUnitVH: value = scale(value, child->display->viewportHeight); break;
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

	if (type == kOriginTypeLength) {

		switch (unit) {

			case kOriginUnitPC: value = scale(value, child->parent->measuredContentWidth); break;
			case kOriginUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kOriginUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kOriginUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kOriginUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kOriginUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kOriginUnitVH: value = scale(value, child->display->viewportHeight); break;
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

	if (type == kOriginTypeLength) {

		switch (unit) {

			case kOriginUnitPC: value = scale(value, child->parent->measuredContentHeight); break;
			case kOriginUnitPW: value = scale(value, child->parent->measuredInnerWidth); break;
			case kOriginUnitPH: value = scale(value, child->parent->measuredInnerHeight); break;
			case kOriginUnitCW: value = scale(value, child->parent->measuredContentWidth); break;
			case kOriginUnitCH: value = scale(value, child->parent->measuredContentHeight); break;
			case kOriginUnitVW: value = scale(value, child->display->viewportWidth); break;
			case kOriginUnitVH: value = scale(value, child->display->viewportHeight); break;
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

	if (l != kOriginTypeAuto) nodeL = this->measureLeft(child);
	if (r != kOriginTypeAuto) nodeR = this->measureRight(child);

	if (l != kOriginTypeAuto &&
		r != kOriginTypeAuto) {

		value = child->parent->measuredContentWidth - (nodeL + marginL) - (nodeR + marginR);

	} else if (type == kSizeTypeFill) {

		 if (l == kOriginTypeAuto &&
		 	 r == kOriginTypeAuto) {

			value = child->parent->measuredContentWidth - marginL - marginR;

		} else if (l != kOriginTypeAuto) {

			value = child->parent->measuredContentWidth - (nodeL + marginL);

		} else if (r != kOriginTypeAuto) {

			value = child->parent->measuredContentWidth - (nodeR + marginR);

		}

	} else if (type == kSizeTypeWrap) {

		throw InvalidOperationException("This method does not measuring wrapped node.");

	} else if (type == kSizeTypeLength) {

		switch (unit) {
			case kSizeUnitPC: value = scale(value, child->parent->measuredContentWidth); break;
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

	if (t != kOriginTypeAuto) nodeT = this->measureTop(child);
	if (b != kOriginTypeAuto) nodeB = this->measureBottom(child);

	if (t != kOriginTypeAuto &&
		b != kOriginTypeAuto) {

		value = child->parent->measuredContentHeight - (nodeT + marginT) - (nodeB + marginB);

	} else if (type == kSizeTypeFill) {

		if (t == kOriginTypeAuto &&
			b == kOriginTypeAuto) {

			value = child->parent->measuredContentHeight - marginT - marginB;

		} else if (t != kOriginTypeAuto) {

			value = child->parent->measuredContentHeight - (nodeT + marginT);

		} else if (b != kOriginTypeAuto) {

			value = child->parent->measuredContentHeight - (nodeB + marginB);
		}

	} else if (type == kSizeTypeWrap) {

		throw InvalidOperationException("This method does not measuring wrapped node.");

	} else if (type == kSizeTypeLength) {

		switch (unit) {
			case kSizeUnitPC: value = scale(value, child->parent->measuredContentHeight); break;
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

			if (l == kOriginTypeAuto &&
				r == kOriginTypeLength) {
				measuredL = child->parent->measuredContentWidth - measuredR - child->measuredWidth;
			}

			if (t == kOriginTypeAuto &&
				b == kOriginTypeLength) {
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
