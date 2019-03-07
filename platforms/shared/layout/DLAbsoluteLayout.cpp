#include <iostream>
#include <cstdlib>
#include "DLLayoutNode.h"
#include "DLLayoutNodePrivate.h"
#include "DLLayout.h"
#include "DLLayoutPrivate.h"
#include "DLAbsoluteLayout.h"

#include <chrono>
using namespace std;
using namespace std::chrono;

using std::min;
using std::max;
using std::cerr;
using std::abort;

inline bool
DLAbsoluteLayoutNodeInvalidSize(DLLayoutNodeRef node)
{
	if (node->invalidSize || node->resolvedSize == false) {
		return true;
	}

	if (node->width.unit == kDLLayoutSizeUnitPX &&
		node->height.unit == kDLLayoutSizeUnitPX) {
		return false;
	}

	if (node->parent == NULL) {
		return false;
	}

	bool parentChanged = node->parent != node->resolvedParent;

	if (node->parent->measuredContentWidthUpdated || parentChanged) {
		if (node->width.unit == kDLLayoutSizeUnitPC ||
			node->width.type == kDLLayoutSizeTypeFill ||
			node->right.type != kDLLayoutPositionTypeAuto) {
			return true;
		}
	}

	if (node->parent->measuredContentHeightUpdated || parentChanged) {
		if (node->height.unit == kDLLayoutSizeUnitPC ||
			node->height.type == kDLLayoutSizeTypeFill ||
			node->bottom.type != kDLLayoutPositionTypeAuto) {
			return true;
		}
	}

	if (node->parent->measuredInnerWidthUpdated || parentChanged) {
		if (node->width.unit == kDLLayoutSizeUnitPW ||
			node->height.unit == kDLLayoutSizeUnitPW) {
			return true;
		}
	}

	if (node->parent->measuredInnerHeightUpdated || parentChanged) {
		if (node->width.unit == kDLLayoutSizeUnitPH ||
			node->height.unit == kDLLayoutSizeUnitPH) {
			return true;
		}
	}

	if (node->parent->measuredContentWidthUpdated || parentChanged) {
		if (node->width.unit == kDLLayoutSizeUnitCW ||
			node->height.unit == kDLLayoutSizeUnitCW) {
			return true;
		}
	}

	if (node->parent->measuredContentHeightUpdated || parentChanged) {
		if (node->width.unit == kDLLayoutSizeUnitCH ||
			node->height.unit == kDLLayoutSizeUnitCH) {
			return true;
		}
	}

	if (node->layout->viewportWidthUpdated) {
		if (node->width.unit == kDLLayoutSizeUnitVW ||
			node->height.unit == kDLLayoutSizeUnitVH) {
			return true;
		}
	}

	if (node->layout->viewportHeightUpdated) {
		if (node->width.unit == kDLLayoutSizeUnitVH ||
			node->height.unit == kDLLayoutSizeUnitVH) {
			return true;
		}
	}

	return false;
}

inline bool
DLAbsoluteLayoutNodeInvalidPosition(DLLayoutNodeRef node)
{
	if (node->invalidPosition || node->resolvedPosition == false) {
		return true;
	}

	if (node->top.unit == kDLLayoutPositionUnitPX &&
		node->left.unit == kDLLayoutPositionUnitPX &&
		node->right.type == kDLLayoutPositionTypeAuto &&
		node->bottom.type == kDLLayoutPositionTypeAuto) {
		return false;
	}

	if ((node->anchorTop.length > 0.0 && node->measuredHeightUpdated) ||
		(node->anchorLeft.length > 0.0 && node->measuredWidthUpdated)) {
		return true;
	}

	if (node->parent == NULL) {
		return false;
	}

	bool parentChanged = node->parent != node->resolvedParent;

	if (node->parent->measuredContentWidthUpdated || parentChanged) {
		if (node->left.unit == kDLLayoutPositionUnitPC ||
			node->right.unit == kDLLayoutPositionUnitPC) {
			return true;
		}
	}

	if (node->parent->measuredContentHeightUpdated || parentChanged) {
		if (node->top.unit == kDLLayoutPositionUnitPC ||
			node->bottom.unit == kDLLayoutPositionUnitPC) {
			return true;
		}
	}

	if (node->parent->measuredInnerWidthUpdated || parentChanged) {
		if (node->top.unit == kDLLayoutPositionUnitPW ||
			node->left.unit == kDLLayoutPositionUnitPW ||
			node->right.unit == kDLLayoutPositionUnitPW ||
			node->bottom.unit == kDLLayoutPositionUnitPW) {
			return true;
		}
	}

	if (node->parent->measuredInnerHeightUpdated || parentChanged) {
		if (node->top.unit == kDLLayoutPositionUnitPH ||
			node->left.unit == kDLLayoutPositionUnitPH ||
			node->right.unit == kDLLayoutPositionUnitPH ||
			node->bottom.unit == kDLLayoutPositionUnitPH) {
			return true;
		}
	}

	if (node->parent->measuredContentWidthUpdated || parentChanged) {
		if (node->top.unit == kDLLayoutPositionUnitCW ||
			node->left.unit == kDLLayoutPositionUnitCW ||
			node->right.unit == kDLLayoutPositionUnitCW ||
			node->bottom.unit == kDLLayoutPositionUnitCW) {
			return true;
		}
	}

	if (node->parent->measuredContentHeightUpdated || parentChanged) {
		if (node->top.unit == kDLLayoutPositionUnitCH ||
			node->left.unit == kDLLayoutPositionUnitCH ||
			node->right.unit == kDLLayoutPositionUnitCH ||
			node->bottom.unit == kDLLayoutPositionUnitCH) {
			return true;
		}
	}

	if (node->layout->viewportWidthUpdated) {
		if (node->top.unit == kDLLayoutPositionUnitVW ||
			node->left.unit == kDLLayoutPositionUnitVW ||
			node->right.unit == kDLLayoutPositionUnitVW ||
			node->bottom.unit == kDLLayoutPositionUnitVW) {
			return true;
		}
	}

	if (node->layout->viewportHeightUpdated) {
		if (node->top.unit == kDLLayoutPositionUnitVH ||
			node->left.unit == kDLLayoutPositionUnitVH ||
			node->right.unit == kDLLayoutPositionUnitVH ||
			node->bottom.unit == kDLLayoutPositionUnitVH) {
			return true;
		}
	}

	return false;
}

inline double
DLAbsoluteLayoutNodeMeasureTop(DLLayoutNodeRef node)
{
	const DLLayoutPositionType type = node->top.type;
	const DLLayoutPositionUnit unit = node->top.unit;

	double value = node->top.length;

	if (type == kDLLayoutPositionTypeLength) {

		switch (unit) {

			case kDLLayoutPositionUnitPC: DL_REL(value, node->parent->measuredContentHeight); break;
			case kDLLayoutPositionUnitPW: DL_REL(value, node->parent->measuredInnerWidth); break;
			case kDLLayoutPositionUnitPH: DL_REL(value, node->parent->measuredInnerHeight); break;
			case kDLLayoutPositionUnitCW: DL_REL(value, node->parent->measuredContentWidth); break;
			case kDLLayoutPositionUnitCH: DL_REL(value, node->parent->measuredContentHeight); break;
			case kDLLayoutPositionUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutPositionUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->top.min, node->top.max);

	value += node->parent->measuredContentTop;

	return DL_ROUND(node->layout->scale, value);
}

inline double
DLAbsoluteLayoutNodeMeasureLeft(DLLayoutNodeRef node)
{
	const DLLayoutPositionType type = node->left.type;
	const DLLayoutPositionUnit unit = node->left.unit;

	double value = node->left.length;

	if (type == kDLLayoutPositionTypeLength) {

		switch (unit) {

			case kDLLayoutPositionUnitPC: DL_REL(value, node->parent->measuredContentWidth); break;
			case kDLLayoutPositionUnitPW: DL_REL(value, node->parent->measuredInnerWidth); break;
			case kDLLayoutPositionUnitPH: DL_REL(value, node->parent->measuredInnerHeight); break;
			case kDLLayoutPositionUnitCW: DL_REL(value, node->parent->measuredContentWidth); break;
			case kDLLayoutPositionUnitCH: DL_REL(value, node->parent->measuredContentHeight); break;
			case kDLLayoutPositionUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutPositionUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->left.min, node->left.max);

	value += node->parent->measuredContentLeft;

	return DL_ROUND(node->layout->scale, value);
}

inline double
DLAbsoluteLayoutNodeMeasureRight(DLLayoutNodeRef node)
{
	const DLLayoutPositionType type = node->right.type;
	const DLLayoutPositionUnit unit = node->right.unit;

	double value = node->right.length;

	if (type == kDLLayoutPositionTypeLength) {

		switch (unit) {

			case kDLLayoutPositionUnitPC: DL_REL(value, node->parent->measuredContentWidth); break;
			case kDLLayoutPositionUnitPW: DL_REL(value, node->parent->measuredInnerWidth); break;
			case kDLLayoutPositionUnitPH: DL_REL(value, node->parent->measuredInnerHeight); break;
			case kDLLayoutPositionUnitCW: DL_REL(value, node->parent->measuredContentWidth); break;
			case kDLLayoutPositionUnitCH: DL_REL(value, node->parent->measuredContentHeight); break;
			case kDLLayoutPositionUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutPositionUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->right.min, node->right.max);

	value += node->parent->measuredContentLeft;

	return DL_ROUND(node->layout->scale, value);
}

inline double
DLAbsoluteLayoutNodeMeasureBottom(DLLayoutNodeRef node)
{
	const DLLayoutPositionType type = node->bottom.type;
	const DLLayoutPositionUnit unit = node->bottom.unit;

	double value = node->bottom.length;

	if (type == kDLLayoutPositionTypeLength) {

		switch (unit) {

			case kDLLayoutPositionUnitPC: DL_REL(value, node->parent->measuredContentHeight); break;
			case kDLLayoutPositionUnitPW: DL_REL(value, node->parent->measuredInnerWidth); break;
			case kDLLayoutPositionUnitPH: DL_REL(value, node->parent->measuredInnerHeight); break;
			case kDLLayoutPositionUnitCW: DL_REL(value, node->parent->measuredContentWidth); break;
			case kDLLayoutPositionUnitCH: DL_REL(value, node->parent->measuredContentHeight); break;
			case kDLLayoutPositionUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutPositionUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->bottom.min, node->bottom.max);

	value += node->parent->measuredContentTop;

	return DL_ROUND(node->layout->scale, value);
}

inline double
DLAbsoluteLayoutNodeMeasureWidth(DLLayoutNodeRef node)
{
	const double marginL = node->measuredMarginLeft;
	const double marginR = node->measuredMarginRight;

	const DLLayoutSizeType type = node->width.type;
	const DLLayoutSizeUnit unit = node->width.unit;
	const DLLayoutPositionType l = node->left.type;
	const DLLayoutPositionType r = node->right.type;

	double value = node->width.length;
	double nodeL = 0;
	double nodeR = 0;

	if (l != kDLLayoutPositionTypeAuto) nodeL = DLAbsoluteLayoutNodeMeasureLeft(node);
	if (r != kDLLayoutPositionTypeAuto) nodeR = DLAbsoluteLayoutNodeMeasureRight(node);

	if (l != kDLLayoutPositionTypeAuto && r != kDLLayoutPositionTypeAuto) {
		value = node->parent->measuredContentWidth - (nodeL + marginL) - (nodeR + marginR);
	} else if (type == kDLLayoutSizeTypeFill) {

		 if (l == kDLLayoutPositionTypeAuto && r == kDLLayoutPositionTypeAuto) {
			value = node->parent->measuredContentWidth - marginL - marginR;
		} else if (l != kDLLayoutPositionTypeAuto) {
			value = node->parent->measuredContentWidth - (nodeL + marginL);
		} else if (r != kDLLayoutPositionTypeAuto) {
			value = node->parent->measuredContentWidth - (nodeR + marginR);
		}

	} else if (type == kDLLayoutSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kDLLayoutSizeTypeLength) {

		switch (unit) {
			case kDLLayoutSizeUnitPC: DL_REL(value, node->parent->measuredContentWidth); break;
			case kDLLayoutSizeUnitPW: DL_REL(value, node->parent->measuredInnerWidth); break;
			case kDLLayoutSizeUnitPH: DL_REL(value, node->parent->measuredInnerHeight); break;
			case kDLLayoutSizeUnitCW: DL_REL(value, node->parent->measuredContentWidth); break;
			case kDLLayoutSizeUnitCH: DL_REL(value, node->parent->measuredContentHeight); break;
			case kDLLayoutSizeUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutSizeUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;
		}

	}

	DL_CLAMP(value, node->width.min, node->width.max);

	return DL_ROUND(node->layout->scale, value);
}

inline double
DLAbsoluteLayoutNodeMeasureHeight(DLLayoutNodeRef node)
{
	const double marginT = node->measuredMarginTop;
	const double marginB = node->measuredMarginBottom;

	const DLLayoutSizeType type = node->height.type;
	const DLLayoutSizeUnit unit = node->height.unit;
	const DLLayoutPositionType t = node->top.type;
	const DLLayoutPositionType b = node->bottom.type;

	double value = node->height.length;
	double nodeT = 0;
	double nodeB = 0;

	if (t != kDLLayoutPositionTypeAuto) nodeT = DLAbsoluteLayoutNodeMeasureTop(node);
	if (b != kDLLayoutPositionTypeAuto) nodeB = DLAbsoluteLayoutNodeMeasureBottom(node);

	if (t != kDLLayoutPositionTypeAuto && b != kDLLayoutPositionTypeAuto) {
			value = node->parent->measuredContentHeight - (nodeT + marginT) - (nodeB + marginB);
	} else if (type == kDLLayoutSizeTypeFill) {

		if (t == kDLLayoutPositionTypeAuto && b == kDLLayoutPositionTypeAuto) {
			value = node->parent->measuredContentHeight - marginT - marginB;
		} else if (t != kDLLayoutPositionTypeAuto) {
			value = node->parent->measuredContentHeight - (nodeT + marginT);
		} else if (b != kDLLayoutPositionTypeAuto) {
			value = node->parent->measuredContentHeight - (nodeB + marginB);
		}

	} else if (type == kDLLayoutSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kDLLayoutSizeTypeLength) {

		switch (unit) {
			case kDLLayoutSizeUnitPC: DL_REL(value, node->parent->measuredContentHeight); break;
			case kDLLayoutSizeUnitPW: DL_REL(value, node->parent->measuredInnerWidth); break;
			case kDLLayoutSizeUnitPH: DL_REL(value, node->parent->measuredInnerHeight); break;
			case kDLLayoutSizeUnitCW: DL_REL(value, node->parent->measuredContentWidth); break;
			case kDLLayoutSizeUnitCH: DL_REL(value, node->parent->measuredContentHeight); break;
			case kDLLayoutSizeUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutSizeUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;
		}

	}

	DL_CLAMP(value, node->height.min, node->height.max);

	return DL_ROUND(node->layout->scale, value);
}

void
DLAbsoluteLayoutNodeMeasure(DLLayoutNodeRef node)
{
	const bool wrapW = node->isWrappingWidth;
	const bool wrapH = node->isWrappingHeight;

	double measuredW = node->measuredWidth;
	double measuredH = node->measuredHeight;

	if (DLAbsoluteLayoutNodeInvalidSize(node)) {

		if (wrapW == false) measuredW = DLAbsoluteLayoutNodeMeasureWidth(node);
		if (wrapH == false) measuredH = DLAbsoluteLayoutNodeMeasureHeight(node);

		// TODO IFDEF TEST
		node->resolveSizeCount++;
	}

	if (wrapW || wrapH) {
		DLLayoutNodeMeasureWrappedLayout(node, measuredW, measuredH);
	}

	bool invalid = false;

	if (node->measuredWidth != measuredW) {
		node->measuredWidth = measuredW;
		node->measuredWidthUpdated = true;
		invalid = true;
	}

	if (node->measuredHeight != measuredH) {
		node->measuredHeight = measuredH;
		node->measuredHeightUpdated = true;
		invalid = true;
	}

	if (invalid) {

		node->invalidInnerSize = true;

		DL_LAYOUT_NODE_INVOKE(node, resolveSizeCallback)

		/*
		 * With a node that wraps its width or height the first layout
		 * pass did measure the views but in some cases the layout will
		 * be incorrect. We thus need to perform a second layout pass
		 * to correctly position its children.
		 */

		if (wrapW || wrapH) {
			DLLayoutNodeLayoutWrappedLayout(node);
		}
	}
}

void
DLAbsoluteLayoutResolve(DLLayoutNodeRef node, const std::vector<DLLayoutNodeRef> &nodes)
{
	for (int i = 0; i < nodes.size(); i++) {

		const DLLayoutNodeRef child = nodes[i];

		child->resolving = true;
		child->measuredWidthUpdated = false;
		child->measuredHeightUpdated = false;

		/*
		 * Resolving the node margin must be done before measuring because
		 * it might influence its size, for instance, when using negatives
		 * margins on opposite sides.
		 */

		if (DLLayoutNodeInvalidMargin(child)) {
			DLLayoutNodeResolveMargin(child);
		}

		if (child->relayout == false) {
			DLAbsoluteLayoutNodeMeasure(child);
		}

		if (DLAbsoluteLayoutNodeInvalidPosition(child)) {

			double measuredT = DLAbsoluteLayoutNodeMeasureTop(child);
			double measuredL = DLAbsoluteLayoutNodeMeasureLeft(child);
			double measuredR = DLAbsoluteLayoutNodeMeasureRight(child);
			double measuredB = DLAbsoluteLayoutNodeMeasureBottom(child);

			if (child->left.type  == kDLLayoutPositionTypeAuto &&
				child->right.type == kDLLayoutPositionTypeLength) {
				measuredL = child->parent->measuredContentWidth - measuredR - child->measuredWidth;
			}

			if (child->top.type    == kDLLayoutPositionTypeAuto &&
				child->bottom.type == kDLLayoutPositionTypeLength) {
				measuredT = child->parent->measuredContentHeight - measuredB - child->measuredHeight;
			}

			const double anchorT = DLLayoutNodeMeasureAnchorTop(child);
			const double anchorL = DLLayoutNodeMeasureAnchorLeft(child);

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

				DL_LAYOUT_NODE_INVOKE(child, resolvePositionCallback)
			}

			// TODO IFDEF TEST
			child->resolvePositionCount++;
		}

		child->resolvedSize = true;
		child->resolvedPosition = true;
		child->resolvedParent = node;

		child->resolving = false;
		child->invalidSize = false;
		child->invalidPosition = false;
	}
}
