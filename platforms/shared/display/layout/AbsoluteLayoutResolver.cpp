#include "AbsoluteLayoutResolver.h"
#include "LayoutResolver.h"
#include "Display.h"
#include "DisplayNode.h"
#include "DisplayNodeFrame.h"

#include <iostream>
#include <cstdlib>

namespace Dezel {
namespace Layout {

using std::abort;
using std::cerr;
using std::cout;
using std::min;
using std::max;

AbsoluteLayoutResolver::AbsoluteLayoutResolver(DisplayNode* node)
{
	this->node = node;
}

bool
AbsoluteLayoutResolver::hasInvalidSize(DisplayNode* child)
{
	const auto frame = child->frame;

	if (frame->invalidSize ||
		frame->resolvedSize == false) {
		return true;
	}

	if (frame->width.unit == kDisplayNodeSizeUnitPX &&
		frame->height.unit == kDisplayNodeSizeUnitPX) {
		return false;
	}

	if (child->parent) {

		const auto frame = child->parent->frame;

		if (frame->measuredContentWidthChanged || frame->hasResolvedParentChange()) {
			if (frame->width.unit == kDisplayNodeSizeUnitPC ||
				frame->width.type == kDisplayNodeSizeTypeFill ||
				frame->right.type != kDisplayNodeOriginTypeAuto) {
				return true;
			}
		}

		if (frame->measuredContentHeightChanged || frame->hasResolvedParentChange()) {
			if (frame->height.unit == kDisplayNodeSizeUnitPC ||
				frame->height.type == kDisplayNodeSizeTypeFill ||
				frame->bottom.type != kDisplayNodeOriginTypeAuto) {
				return true;
			}
		}

		if (frame->measuredInnerWidthChanged || frame->hasResolvedParentChange()) {
			if (frame->width.unit == kDisplayNodeSizeUnitPW ||
				frame->height.unit == kDisplayNodeSizeUnitPW) {
				return true;
			}
		}

		if (frame->measuredInnerHeightChanged || frame->hasResolvedParentChange()) {
			if (frame->width.unit == kDisplayNodeSizeUnitPH ||
				frame->height.unit == kDisplayNodeSizeUnitPH) {
				return true;
			}
		}

		if (frame->measuredContentWidthChanged || frame->hasResolvedParentChange()) {
			if (frame->width.unit == kDisplayNodeSizeUnitCW ||
				frame->height.unit == kDisplayNodeSizeUnitCW) {
				return true;
			}
		}

		if (frame->measuredContentHeightChanged || frame->hasResolvedParentChange()) {
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

	if (child->display->hasViewportHeightChanged()) {
		if (frame->width.unit == kDisplayNodeSizeUnitVH ||
			frame->height.unit == kDisplayNodeSizeUnitVH) {
			return true;
		}
	}

	return false;
}

bool
AbsoluteLayoutResolver::hasInvalidOrigin(DisplayNode* node)
{
	const auto frame = node->frame;

	if (frame->invalidOrigin ||
		frame->resolvedOrigin == false) {
		return true;
	}

	if (frame->top.unit == kDisplayNodeOriginUnitPX &&
		frame->left.unit == kDisplayNodeOriginUnitPX &&
		frame->right.type == kDisplayNodeOriginTypeAuto &&
		frame->bottom.type == kDisplayNodeOriginTypeAuto) {
		return false;
	}

	if ((frame->anchorTop.length > 0.0 && frame->measuredHeightChanged) ||
		(frame->anchorLeft.length > 0.0 && frame->measuredWidthChanged)) {
		return true;
	}

	if (node->parent) {

		const auto parent = node->parent->frame;

		if (parent->measuredContentWidthChanged || frame->hasResolvedParentChange()) {
			if (frame->left.unit == kDisplayNodeOriginUnitPC ||
				frame->right.unit == kDisplayNodeOriginUnitPC) {
				return true;
			}
		}

		if (parent->measuredContentHeightChanged || frame->hasResolvedParentChange()) {
			if (frame->top.unit == kDisplayNodeOriginUnitPC ||
				frame->bottom.unit == kDisplayNodeOriginUnitPC) {
				return true;
			}
		}

		if (parent->measuredInnerWidthChanged || frame->hasResolvedParentChange()) {
			if (frame->top.unit == kDisplayNodeOriginUnitPW ||
				frame->left.unit == kDisplayNodeOriginUnitPW ||
				frame->right.unit == kDisplayNodeOriginUnitPW ||
				frame->bottom.unit == kDisplayNodeOriginUnitPW) {
				return true;
			}
		}

		if (parent->measuredInnerHeightChanged || frame->hasResolvedParentChange()) {
			if (frame->top.unit == kDisplayNodeOriginUnitPH ||
				frame->left.unit == kDisplayNodeOriginUnitPH ||
				frame->right.unit == kDisplayNodeOriginUnitPH ||
				frame->bottom.unit == kDisplayNodeOriginUnitPH) {
				return true;
			}
		}

		if (parent->measuredContentWidthChanged || frame->hasResolvedParentChange()) {
			if (frame->top.unit == kDisplayNodeOriginUnitCW ||
				frame->left.unit == kDisplayNodeOriginUnitCW ||
				frame->right.unit == kDisplayNodeOriginUnitCW ||
				frame->bottom.unit == kDisplayNodeOriginUnitCW) {
				return true;
			}
		}

		if (parent->measuredContentHeightChanged || frame->hasResolvedParentChange()) {
			if (frame->top.unit == kDisplayNodeOriginUnitCH ||
				frame->left.unit == kDisplayNodeOriginUnitCH ||
				frame->right.unit == kDisplayNodeOriginUnitCH ||
				frame->bottom.unit == kDisplayNodeOriginUnitCH) {
				return true;
			}
		}
	}

	if (node->display->hasViewportWidthChanged()) {
		if (frame->top.unit == kDisplayNodeOriginUnitVW ||
			frame->left.unit == kDisplayNodeOriginUnitVW ||
			frame->right.unit == kDisplayNodeOriginUnitVW ||
			frame->bottom.unit == kDisplayNodeOriginUnitVW) {
			return true;
		}
	}

	if (node->display->hasViewportWidthChanged()) {
		if (frame->top.unit == kDisplayNodeOriginUnitVH ||
			frame->left.unit == kDisplayNodeOriginUnitVH ||
			frame->right.unit == kDisplayNodeOriginUnitVH ||
			frame->bottom.unit == kDisplayNodeOriginUnitVH) {
			return true;
		}
	}

	return false;
}

double
AbsoluteLayoutResolver::measureTop(DisplayNode* child)
{
	const auto frame = child->frame;

	const auto type = frame->top.type;
	const auto unit = frame->top.unit;

	double value = frame->top.length;

	if (type == kDisplayNodeOriginTypeLength) {

		switch (unit) {

			case kDisplayNodeOriginUnitPC: value = LayoutResolver::scale(value, child->parent->frame->measuredContentHeight); break;
			case kDisplayNodeOriginUnitPW: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerWidth); break;
			case kDisplayNodeOriginUnitPH: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerHeight); break;
			case kDisplayNodeOriginUnitCW: value = LayoutResolver::scale(value, child->parent->frame->measuredContentWidth); break;
			case kDisplayNodeOriginUnitCH: value = LayoutResolver::scale(value, child->parent->frame->measuredContentHeight); break;
			case kDisplayNodeOriginUnitVW: value = LayoutResolver::scale(value, child->display->getViewportWidth()); break;
			case kDisplayNodeOriginUnitVH: value = LayoutResolver::scale(value, child->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = LayoutResolver::clamp(
		value,
		frame->top.min,
		frame->top.max
	);

	value += child->parent->frame->measuredContentTop;

	return LayoutResolver::round(value, child->display->getScale());;
}

double
AbsoluteLayoutResolver::measureLeft(DisplayNode* child)
{
	const auto frame = child->frame;

	const auto type = frame->left.type;
	const auto unit = frame->left.unit;

	double value = frame->left.length;

	if (type == kDisplayNodeOriginTypeLength) {

		switch (unit) {

			case kDisplayNodeOriginUnitPC: value = LayoutResolver::scale(value, child->parent->frame->measuredContentWidth); break;
			case kDisplayNodeOriginUnitPW: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerWidth); break;
			case kDisplayNodeOriginUnitPH: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerHeight); break;
			case kDisplayNodeOriginUnitCW: value = LayoutResolver::scale(value, child->parent->frame->measuredContentWidth); break;
			case kDisplayNodeOriginUnitCH: value = LayoutResolver::scale(value, child->parent->frame->measuredContentHeight); break;
			case kDisplayNodeOriginUnitVW: value = LayoutResolver::scale(value, child->display->getViewportWidth()); break;
			case kDisplayNodeOriginUnitVH: value = LayoutResolver::scale(value, child->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = LayoutResolver::clamp(
		value,
		frame->left.min,
		frame->left.max
	);

	value += child->parent->frame->measuredContentLeft;

	return LayoutResolver::round(value, child->display->getScale());
}

double
AbsoluteLayoutResolver::measureRight(DisplayNode* child)
{
	const auto frame = child->frame;

	const auto type = frame->right.type;
	const auto unit = frame->right.unit;

	double value = frame->right.length;

	if (type == kDisplayNodeOriginTypeLength) {

		switch (unit) {

			case kDisplayNodeOriginUnitPC: value = LayoutResolver::scale(value, child->parent->frame->measuredContentWidth); break;
			case kDisplayNodeOriginUnitPW: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerWidth); break;
			case kDisplayNodeOriginUnitPH: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerHeight); break;
			case kDisplayNodeOriginUnitCW: value = LayoutResolver::scale(value, child->parent->frame->measuredContentWidth); break;
			case kDisplayNodeOriginUnitCH: value = LayoutResolver::scale(value, child->parent->frame->measuredContentHeight); break;
			case kDisplayNodeOriginUnitVW: value = LayoutResolver::scale(value, child->display->getViewportWidth()); break;
			case kDisplayNodeOriginUnitVH: value = LayoutResolver::scale(value, child->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = LayoutResolver::clamp(
		value,
		frame->right.min,
		frame->right.max
	);

	value += child->parent->frame->measuredContentLeft;

	return LayoutResolver::round(value, child->display->getScale());
}

double
AbsoluteLayoutResolver::measureBottom(DisplayNode* child)
{
	const auto frame = child->frame;

	const auto type = frame->bottom.type;
	const auto unit = frame->bottom.unit;

	double value = frame->bottom.length;

	if (type == kDisplayNodeOriginTypeLength) {

		switch (unit) {

			case kDisplayNodeOriginUnitPC: value = LayoutResolver::scale(value, child->parent->frame->measuredContentHeight); break;
			case kDisplayNodeOriginUnitPW: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerWidth); break;
			case kDisplayNodeOriginUnitPH: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerHeight); break;
			case kDisplayNodeOriginUnitCW: value = LayoutResolver::scale(value, child->parent->frame->measuredContentWidth); break;
			case kDisplayNodeOriginUnitCH: value = LayoutResolver::scale(value, child->parent->frame->measuredContentHeight); break;
			case kDisplayNodeOriginUnitVW: value = LayoutResolver::scale(value, child->display->getViewportWidth()); break;
			case kDisplayNodeOriginUnitVH: value = LayoutResolver::scale(value, child->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = LayoutResolver::clamp(
		value,
		frame->bottom.min,
		frame->bottom.max
	);

	value += child->parent->frame->measuredContentTop;

	return LayoutResolver::round(value, child->display->getScale());
}

double
AbsoluteLayoutResolver::measureWidth(DisplayNode* child)
{
	const auto frame = child->frame;

	const auto marginL = frame->measuredMarginLeft;
	const auto marginR = frame->measuredMarginRight;

	const auto type = frame->width.type;
	const auto unit = frame->width.unit;

	const auto l = frame->left.type;
	const auto r = frame->right.type;

	double value = frame->width.length;
	double nodeL = 0;
	double nodeR = 0;

	if (l != kDisplayNodeOriginTypeAuto) nodeL = this->measureLeft(child);
	if (r != kDisplayNodeOriginTypeAuto) nodeR = this->measureRight(child);

	if (l != kDisplayNodeOriginTypeAuto &&
		r != kDisplayNodeOriginTypeAuto) {

		value = child->parent->frame->measuredContentWidth - (nodeL + marginL) - (nodeR + marginR);

	} else if (type == kDisplayNodeSizeTypeFill) {

		 if (l == kDisplayNodeOriginTypeAuto &&
		 	 r == kDisplayNodeOriginTypeAuto) {

			value = child->parent->frame->measuredContentWidth - marginL - marginR;

		} else if (l != kDisplayNodeOriginTypeAuto) {

			value = child->parent->frame->measuredContentWidth - (nodeL + marginL);

		} else if (r != kDisplayNodeOriginTypeAuto) {

			value = child->parent->frame->measuredContentWidth - (nodeR + marginR);

		}

	} else if (type == kDisplayNodeSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kDisplayNodeSizeTypeLength) {

		switch (unit) {
			case kDisplayNodeSizeUnitPC: value = LayoutResolver::scale(value, child->parent->frame->measuredContentWidth); break;
			case kDisplayNodeSizeUnitPW: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerWidth); break;
			case kDisplayNodeSizeUnitPH: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerHeight); break;
			case kDisplayNodeSizeUnitCW: value = LayoutResolver::scale(value, child->parent->frame->measuredContentWidth); break;
			case kDisplayNodeSizeUnitCH: value = LayoutResolver::scale(value, child->parent->frame->measuredContentHeight); break;
			case kDisplayNodeSizeUnitVW: value = LayoutResolver::scale(value, child->display->getViewportWidth()); break;
			case kDisplayNodeSizeUnitVH: value = LayoutResolver::scale(value, child->display->getViewportHeight()); break;
			default: break;
		}

	}

	value = LayoutResolver::clamp(
		value,
		frame->width.min,
		frame->width.max
	);

	return LayoutResolver::round(value, child->display->getScale());
}

double
AbsoluteLayoutResolver::measureHeight(DisplayNode* child)
{
	const auto frame = child->frame;

	const auto marginT = frame->measuredMarginTop;
	const auto marginB = frame->measuredMarginBottom;

	const auto type = frame->height.type;
	const auto unit = frame->height.unit;

	const auto t = frame->top.type;
	const auto b = frame->bottom.type;

	double nodeT = 0;
	double nodeB = 0;
	double value = frame->height.length;

	if (t != kDisplayNodeOriginTypeAuto) nodeT = this->measureTop(child);
	if (b != kDisplayNodeOriginTypeAuto) nodeB = this->measureBottom(child);

	if (t != kDisplayNodeOriginTypeAuto &&
		b != kDisplayNodeOriginTypeAuto) {

		value = child->parent->frame->measuredContentHeight - (nodeT + marginT) - (nodeB + marginB);

	} else if (type == kDisplayNodeSizeTypeFill) {

		if (t == kDisplayNodeOriginTypeAuto &&
			b == kDisplayNodeOriginTypeAuto) {

			value = child->parent->frame->measuredContentHeight - marginT - marginB;

		} else if (t != kDisplayNodeOriginTypeAuto) {

			value = child->parent->frame->measuredContentHeight - (nodeT + marginT);

		} else if (b != kDisplayNodeOriginTypeAuto) {

			value = child->parent->frame->measuredContentHeight - (nodeB + marginB);
		}

	} else if (type == kDisplayNodeSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kDisplayNodeSizeTypeLength) {

		switch (unit) {
			case kDisplayNodeSizeUnitPC: value = LayoutResolver::scale(value, child->parent->frame->measuredContentHeight); break;
			case kDisplayNodeSizeUnitPW: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerWidth); break;
			case kDisplayNodeSizeUnitPH: value = LayoutResolver::scale(value, child->parent->frame->measuredInnerHeight); break;
			case kDisplayNodeSizeUnitCW: value = LayoutResolver::scale(value, child->parent->frame->measuredContentWidth); break;
			case kDisplayNodeSizeUnitCH: value = LayoutResolver::scale(value, child->parent->frame->measuredContentHeight); break;
			case kDisplayNodeSizeUnitVW: value = LayoutResolver::scale(value, child->display->getViewportWidth()); break;
			case kDisplayNodeSizeUnitVH: value = LayoutResolver::scale(value, child->display->getViewportHeight()); break;
			default: break;
		}

	}

	value = LayoutResolver::clamp(
		value,
		frame->height.min,
		frame->height.max
	);

	return LayoutResolver::round(value, child->display->getScale());
}

void
AbsoluteLayoutResolver::measure(DisplayNode* child)
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
		if (wrapW == false) measuredW = this->measureWidth(child);
		if (wrapH == false) measuredH = this->measureHeight(child);
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
AbsoluteLayoutResolver::resolve()
{
	if (this->nodes.size() == 0) {
		return;
	}

	for (auto child : this->nodes) {

		const auto frame = child->frame;

		this->measure(child);

		if (frame->lastMeasuredWidth != frame->measuredWidth ||
			frame->lastMeasuredHeight != frame->measuredHeight) {
			frame->lastMeasuredWidth = frame->measuredWidth;
			frame->lastMeasuredHeight = frame->measuredHeight;
			child->didResolveSize();
		}

		if (this->hasInvalidOrigin(child)) {

			double measuredT = this->measureTop(child);
			double measuredL = this->measureLeft(child);
			double measuredR = this->measureRight(child);
			double measuredB = this->measureBottom(child);

			const auto t = frame->top.type;
			const auto l = frame->left.type;
			const auto r = frame->right.type;
			const auto b = frame->bottom.type;

			if (l == kDisplayNodeOriginTypeAuto &&
				r == kDisplayNodeOriginTypeLength) {
				measuredL = child->parent->frame->measuredContentWidth - measuredR - frame->measuredWidth;
			}

			if (t == kDisplayNodeOriginTypeAuto &&
				b == kDisplayNodeOriginTypeLength) {
				measuredT = child->parent->frame->measuredContentHeight - measuredB - frame->measuredHeight;
			}

			const auto anchorT = frame->measureAnchorTop();
			const auto anchorL = frame->measureAnchorLeft();

			measuredT = measuredT + frame->measuredMarginTop - anchorT;
			measuredL = measuredL + frame->measuredMarginLeft - anchorL;
			measuredR = measuredR + frame->measuredMarginRight - anchorL;
			measuredB = measuredB + frame->measuredMarginBottom - anchorT;

			if (frame->measuredTop != measuredT ||
				frame->measuredLeft != measuredL) {

				frame->measuredTop = measuredT;
				frame->measuredLeft = measuredL;
				frame->measuredRight = measuredR;
				frame->measuredBottom = measuredB;

				child->didResolveOrigin();
			}
		}

		frame->resolvedSize = true;
		frame->resolvedOrigin = true;
		frame->resolvedParent = node;

		frame->invalidSize = false;
		frame->invalidOrigin = false;
	}

	this->nodes.clear();
}

}
}
