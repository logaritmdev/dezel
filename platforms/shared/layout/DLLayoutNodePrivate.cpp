#include <iostream>
#include <algorithm>
#include "DLLayoutNode.h"
#include "DLLayoutNodePrivate.h"
#include "DLLayoutPrivate.h"

using std::min;
using std::max;

double
DLLayoutNodeMeasureBorderTop(DLLayoutNodeRef node)
{
	const DLLayoutBorderType type = node->borderTop.type;
	const DLLayoutBorderUnit unit = node->borderTop.unit;

	double value = node->borderTop.length;

	if (type == kDLLayoutBorderTypeLength) {

		switch (unit) {

			case kDLLayoutBorderUnitPC: DL_REL(value, node->measuredHeight); break;
			case kDLLayoutBorderUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutBorderUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutBorderUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutBorderUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutBorderUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutBorderUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->borderTop.min, node->borderTop.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasureBorderLeft(DLLayoutNodeRef node)
{
	const DLLayoutBorderType type = node->borderLeft.type;
	const DLLayoutBorderUnit unit = node->borderLeft.unit;

	double value = node->borderLeft.length;

	if (type == kDLLayoutBorderTypeLength) {

		switch (unit) {

			case kDLLayoutBorderUnitPC: DL_REL(value, node->measuredWidth); break;
			case kDLLayoutBorderUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutBorderUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutBorderUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutBorderUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutBorderUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutBorderUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->borderLeft.min, node->borderLeft.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasureBorderRight(DLLayoutNodeRef node)
{
	const DLLayoutBorderType type = node->borderRight.type;
	const DLLayoutBorderUnit unit = node->borderRight.unit;

	double value = node->borderRight.length;

	if (type == kDLLayoutBorderTypeLength) {

		switch (unit) {

			case kDLLayoutBorderUnitPC: DL_REL(value, node->measuredWidth); break;
			case kDLLayoutBorderUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutBorderUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutBorderUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutBorderUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutBorderUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutBorderUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->borderRight.min, node->borderRight.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasureBorderBottom(DLLayoutNodeRef node)
{
	const DLLayoutBorderType type = node->borderBottom.type;
	const DLLayoutBorderUnit unit = node->borderBottom.unit;

	double value = node->borderBottom.length;

	if (type == kDLLayoutBorderTypeLength) {

		switch (unit) {

			case kDLLayoutBorderUnitPC: DL_REL(value, node->measuredHeight); break;
			case kDLLayoutBorderUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutBorderUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutBorderUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutBorderUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutBorderUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutBorderUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->borderBottom.min, node->borderBottom.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasureMarginTop(DLLayoutNodeRef node)
{
	const DLLayoutMarginType type = node->marginTop.type;
	const DLLayoutMarginUnit unit = node->marginTop.unit;

	double value = node->marginTop.length;

	if (type == kDLLayoutMarginTypeLength) {

		switch (unit) {

			case kDLLayoutMarginUnitPC: DL_REL(value, node->parent->measuredContentHeight); break;
			case kDLLayoutMarginUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutMarginUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutMarginUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutMarginUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutMarginUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutMarginUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->marginTop.min, node->marginTop.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasureMarginLeft(DLLayoutNodeRef node)
{
	const DLLayoutMarginType type = node->marginLeft.type;
	const DLLayoutMarginUnit unit = node->marginLeft.unit;

	double value = node->marginLeft.length;

	if (type == kDLLayoutMarginTypeLength) {

		switch (unit) {

			case kDLLayoutMarginUnitPC: DL_REL(value, node->parent->measuredContentWidth); break;
			case kDLLayoutMarginUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutMarginUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutMarginUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutMarginUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutMarginUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutMarginUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->marginLeft.min, node->marginLeft.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasureMarginRight(DLLayoutNodeRef node)
{
	const DLLayoutMarginType type = node->marginRight.type;
	const DLLayoutMarginUnit unit = node->marginRight.unit;

	double value = node->marginRight.length;

	if (type == kDLLayoutMarginTypeLength) {

		switch (unit) {

			case kDLLayoutMarginUnitPC: DL_REL(value, node->parent->measuredContentWidth); break;
			case kDLLayoutMarginUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutMarginUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutMarginUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutMarginUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutMarginUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutMarginUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->marginRight.min, node->marginRight.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasureMarginBottom(DLLayoutNodeRef node)
{
	const DLLayoutMarginType type = node->marginBottom.type;
	const DLLayoutMarginUnit unit = node->marginBottom.unit;

	double value = node->marginBottom.length;

	if (type == kDLLayoutMarginTypeLength) {

		switch (unit) {

			case kDLLayoutMarginUnitPC: DL_REL(value, node->parent->measuredContentHeight); break;
			case kDLLayoutMarginUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutMarginUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutMarginUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutMarginUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutMarginUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutMarginUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->marginBottom.min, node->marginBottom.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasurePaddingTop(DLLayoutNodeRef node)
{
	const DLLayoutPaddingType type = node->paddingTop.type;
	const DLLayoutPaddingUnit unit = node->paddingTop.unit;

	double value = node->paddingTop.length;

	if (type == kDLLayoutPaddingTypeLength) {

		switch (unit) {

			case kDLLayoutPaddingUnitPC: DL_REL(value, node->measuredInnerHeight); break;
			case kDLLayoutPaddingUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutPaddingUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutPaddingUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutPaddingUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutPaddingUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutPaddingUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->paddingTop.min, node->paddingTop.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasurePaddingLeft(DLLayoutNodeRef node)
{
	const DLLayoutPaddingType type = node->paddingLeft.type;
	const DLLayoutPaddingUnit unit = node->paddingLeft.unit;

	double value = node->paddingLeft.length;

	if (type == kDLLayoutPaddingTypeLength) {

		switch (unit) {

			case kDLLayoutPaddingUnitPC: DL_REL(value, node->measuredInnerWidth); break;
			case kDLLayoutPaddingUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutPaddingUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutPaddingUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutPaddingUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutPaddingUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutPaddingUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->paddingLeft.min, node->paddingLeft.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasurePaddingRight(DLLayoutNodeRef node)
{
	const DLLayoutPaddingType type = node->paddingRight.type;
	const DLLayoutPaddingUnit unit = node->paddingRight.unit;

	double value = node->paddingRight.length;

	if (type == kDLLayoutPaddingTypeLength) {

		switch (unit) {

			case kDLLayoutPaddingUnitPC: DL_REL(value, node->measuredInnerWidth); break;
			case kDLLayoutPaddingUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutPaddingUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutPaddingUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutPaddingUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutPaddingUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutPaddingUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->paddingRight.min, node->paddingRight.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasurePaddingBottom(DLLayoutNodeRef node)
{
	const DLLayoutPaddingType type = node->paddingBottom.type;
	const DLLayoutPaddingUnit unit = node->paddingBottom.unit;

	double value = node->paddingBottom.length;

	if (type == kDLLayoutPaddingTypeLength) {

		switch (unit) {

			case kDLLayoutPaddingUnitPC: DL_REL(value, node->measuredInnerHeight); break;
			case kDLLayoutPaddingUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutPaddingUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutPaddingUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutPaddingUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutPaddingUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutPaddingUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}
	}

	DL_CLAMP(value, node->paddingBottom.min, node->paddingBottom.max);

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasureInnerWidth(DLLayoutNodeRef node)
{
	// note: there is no need here to round the values as they are rounded already
	return node->measuredWidth - node->measuredBorderLeft - node->measuredBorderRight;
}

double
DLLayoutNodeMeasureInnerHeight(DLLayoutNodeRef node)
{
	// note: there is no need here to round the values as they are rounded already
	return node->measuredHeight - node->measuredBorderTop - node->measuredBorderBottom;
}

double
DLLayoutNodeMeasureContentWidth(DLLayoutNodeRef node)
{
	const DLLayoutContentSizeType type = node->contentWidth.type;
	const DLLayoutContentSizeUnit unit = node->contentWidth.unit;

	double value = node->contentWidth.length;

	if (type == kDLLayoutContentSizeTypeAuto) {

		value = node->measuredInnerWidth;

	} else {

		switch (unit) {

			case kDLLayoutContentSizeUnitPC: DL_REL(value, node->measuredInnerWidth); break;
			case kDLLayoutContentSizeUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutContentSizeUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutContentSizeUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutContentSizeUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutContentSizeUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutContentSizeUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}

		value = std::max(value, node->measuredInnerWidth);
	}

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasureContentHeight(DLLayoutNodeRef node)
{
	const DLLayoutContentSizeType type = node->contentHeight.type;
	const DLLayoutContentSizeUnit unit = node->contentHeight.unit;

	double value = node->contentHeight.length;

	if (type == kDLLayoutContentSizeTypeAuto) {

		value = node->measuredInnerHeight;

	} else {

		switch (unit) {

			case kDLLayoutContentSizeUnitPC: DL_REL(value, node->measuredInnerHeight); break;
			case kDLLayoutContentSizeUnitPW: DL_REL(value, node->parent ? node->parent->measuredInnerWidth: 0); break;
			case kDLLayoutContentSizeUnitPH: DL_REL(value, node->parent ? node->parent->measuredInnerHeight: 0); break;
			case kDLLayoutContentSizeUnitCW: DL_REL(value, node->parent ? node->parent->measuredContentWidth: 0); break;
			case kDLLayoutContentSizeUnitCH: DL_REL(value, node->parent ? node->parent->measuredContentHeight: 0); break;
			case kDLLayoutContentSizeUnitVW: DL_REL(value, node->layout->viewportWidth); break;
			case kDLLayoutContentSizeUnitVH: DL_REL(value, node->layout->viewportHeight); break;
			default: break;

		}

		value = std::max(value, node->measuredInnerHeight);
	}

	return DL_ROUND(node->layout->scale, value);
}

double
DLLayoutNodeMeasureAnchorTop(DLLayoutNodeRef node)
{
	double offset = 0;

	if (node->anchorTop.type == kDLLayoutAnchorTypeLength) {

		offset = node->anchorTop.length;

		switch (node->anchorTop.unit) {
			case kDLLayoutAnchorUnitPC: DL_REL(offset, node->measuredHeight); break;
			default: break;
		}
	}

	return DL_ROUND(node->layout->scale, offset);
}

double
DLLayoutNodeMeasureAnchorLeft(DLLayoutNodeRef node)
{
	double offset = 0;

	if (node->anchorLeft.type == kDLLayoutAnchorTypeLength) {

		offset = node->anchorLeft.length;

		switch (node->anchorLeft.unit) {
			case kDLLayoutAnchorUnitPC: DL_REL(offset, node->measuredWidth); break;
			default: break;
		}
	}

	return DL_ROUND(node->layout->scale, offset);
}

bool
DLLayoutNodeShouldWrapWidth(DLLayoutNodeRef node)
{
	if (node->root) {
		return false;
	}

	if (node->left.type == kDLLayoutPositionTypeLength &&
		node->right.type == kDLLayoutPositionTypeLength) {
		return false;
	}

	if (node->width.type == kDLLayoutSizeTypeWrap) {
		return true;
	}

	if (node->width.type == kDLLayoutSizeTypeFill) {

		node = node->parent;

		while (node) {

			if (node->width.type == kDLLayoutSizeTypeFill) {
				node = node->parent;
				continue;
			}

			if (node->width.type == kDLLayoutSizeTypeWrap) {
				return true;
			}

			return false;
		}
	}

	return false;
}

bool
DLLayoutNodeShouldWrapHeight(DLLayoutNodeRef node)
{
	if (node->root) {
		return false;
	}

	if (node->top.type == kDLLayoutPositionTypeLength &&
		node->bottom.type == kDLLayoutPositionTypeLength) {
		return false;
	}

	if (node->height.type == kDLLayoutSizeTypeWrap) {
		return true;
	}

	if (node->height.type == kDLLayoutSizeTypeFill) {

		node = node->parent;

		while (node) {

			if (node->height.type == kDLLayoutSizeTypeFill) {
				node = node->parent;
				continue;
			}

			if (node->height.type == kDLLayoutSizeTypeWrap) {
				return true;
			}

			return false;
		}
	}

	return false;
}

void
DLLayoutNodeInvalidate(DLLayoutNodeRef node)
{
	if (node->layout) {

		if (node->layout->invalid == false) {
			node->layout->invalid = true;
			if (node->invalidateCallback) {
				node->invalidateCallback(node);
			}
		}

		if (node->layout->resolving) {
			node->layout->changed = true;
			// TODO
			// Once the layout is completed, this should relayout the
			// whole thing. However, we must ignore times when the layout
			// has been invalidated when a child was added during the
			// beforeLayout callback
		}
	}
}

void
DLLayoutNodeResolveMargin(DLLayoutNodeRef node)
{
	const double marginT = DLLayoutNodeMeasureMarginTop(node);
	const double marginL = DLLayoutNodeMeasureMarginLeft(node);
	const double marginR = DLLayoutNodeMeasureMarginRight(node);
	const double marginB = DLLayoutNodeMeasureMarginBottom(node);

	if (marginT != node->measuredMarginTop ||
		marginL != node->measuredMarginLeft ||
		marginR != node->measuredMarginRight ||
		marginB != node->measuredMarginBottom) {

		node->measuredMarginTop = marginT;
		node->measuredMarginLeft = marginL;
		node->measuredMarginRight = marginR;
		node->measuredMarginBottom = marginB;
		node->invalidPosition = true;

		DL_LAYOUT_NODE_INVOKE(node, resolveMarginCallback)
	}

	node->invalidMargin = false;
}

void
DLLayoutNodeResolveBorder(DLLayoutNodeRef node)
{
	const double borderT = DLLayoutNodeMeasureBorderTop(node);
	const double borderL = DLLayoutNodeMeasureBorderLeft(node);
	const double borderR = DLLayoutNodeMeasureBorderRight(node);
	const double borderB = DLLayoutNodeMeasureBorderBottom(node);

	if (borderT != node->measuredBorderTop ||
		borderL != node->measuredBorderLeft ||
		borderR != node->measuredBorderRight ||
		borderB != node->measuredBorderBottom) {

		node->measuredBorderTop = borderT;
		node->measuredBorderLeft = borderL;
		node->measuredBorderRight = borderR;
		node->measuredBorderBottom = borderB;
		node->invalidInnerSize = true;

		DL_LAYOUT_NODE_INVOKE(node, resolveBorderCallback)
	}

	node->invalidBorder = false;
}

void
DLLayoutNodeResolvePadding(DLLayoutNodeRef node)
{
	const double paddingT = DLLayoutNodeMeasurePaddingTop(node);
	const double paddingL = DLLayoutNodeMeasurePaddingLeft(node);
	const double paddingR = DLLayoutNodeMeasurePaddingRight(node);
	const double paddingB = DLLayoutNodeMeasurePaddingBottom(node);

	if (paddingT != node->measuredPaddingTop ||
		paddingL != node->measuredPaddingLeft ||
		paddingR != node->measuredPaddingRight ||
		paddingB != node->measuredPaddingBottom) {

		node->measuredPaddingTop = paddingT;
		node->measuredPaddingLeft = paddingL;
		node->measuredPaddingRight = paddingR;
		node->measuredPaddingBottom = paddingB;
		node->invalidLayout = true;

		DL_LAYOUT_NODE_INVOKE(node, resolvePaddingCallback)
	}

	node->invalidPadding = false;
}

void
DLLayoutNodeResolveInnerSize(DLLayoutNodeRef node)
{
	const double innerW = DLLayoutNodeMeasureInnerWidth(node);
	const double innerH = DLLayoutNodeMeasureInnerHeight(node);

	if (innerW != node->measuredInnerWidth ||
		innerH != node->measuredInnerHeight) {

		if (node->measuredInnerWidth != innerW) {
			node->measuredInnerWidth = innerW;
			node->measuredInnerWidthUpdated = true;
		}

		if (node->measuredInnerHeight != innerH) {
			node->measuredInnerHeight = innerH;
			node->measuredInnerHeightUpdated = true;
		}

		node->invalidContentSize = true;

		DL_LAYOUT_NODE_INVOKE(node, resolveInnerSizeCallback)
	}

	node->invalidInnerSize = false;
}

void
DLLayoutNodeResolveContentSize(DLLayoutNodeRef node)
{
	const double contentW = DLLayoutNodeMeasureContentWidth(node);
	const double contentH = DLLayoutNodeMeasureContentHeight(node);

	if (contentW != node->measuredContentWidth ||
		contentH != node->measuredContentHeight) {

		if (node->measuredContentWidth != contentW) {
			node->measuredContentWidth = contentW;
			node->measuredContentWidthUpdated = true;
		}

		if (node->measuredContentHeight != contentH) {
			node->measuredContentHeight = contentH;
			node->measuredContentHeightUpdated = true;
		}

		node->invalidLayout = true;
		
		DL_LAYOUT_NODE_INVOKE(node, resolveContentSizeCallback)
	}

	node->invalidContentSize = false;
}

void
DLLayoutNodeMeasureWrappedLayout(DLLayoutNodeRef node, double &measuredW, double &measuredH)
{
	if (node->resolvedSize) {

		/*
		 * Once a node has been measured, unless its size is explicity invalid
		 * or its views has changed, there are no reason to measured it
		 * again.
		 */

		if (node->invalidSize == false &&
			node->invalidLayout == false) {
			return;
		}
	}

	const double scale = node->layout->scale;

	const bool wrapW = node->isWrappingWidth;
	const bool wrapH = node->isWrappingHeight;

	DLLayoutNodeMeasure measure;
	measure.width = -1;
	measure.height = -1;

	if (node->measureCallback) {

		if (DLLayoutNodeInvalidPadding(node)) {
			DLLayoutNodeResolvePadding(node);
		}

		node->measureCallback(
			node,
			&measure,
			wrapW ? 0 : measuredW,
			wrapH ? 0 : measuredH,
			node->width.min,
			node->width.max,
			node->height.min,
			node->height.max
		);
	}

	if (measure.width  > -1 &&
		measure.height > -1) {

		if (wrapW || wrapH) {

			const double mw = node->measuredWidth;
			const double mh = node->measuredHeight;

			if (wrapW) measuredW = measure.width;
			if (wrapH) measuredH = measure.height;

			node->measuredWidth = measuredW;
			node->measuredHeight = measuredH;

			if (DLLayoutNodeInvalidPadding(node)) {
				DLLayoutNodeResolvePadding(node);
			}

			if (wrapW) measuredW += node->measuredPaddingLeft + node->measuredPaddingRight;
			if (wrapH) measuredH += node->measuredPaddingTop + node->measuredPaddingBottom;

			node->measuredWidth = mw;
			node->measuredHeight = mh;
		}

	} else {

		const double mw = node->measuredWidth;
		const double mh = node->measuredHeight;

		node->measuredWidth = measuredW;
		node->measuredHeight = measuredH;
		node->invalidInnerSize = true;

		DLLayoutNodeResolveLayout(node);

		if (wrapW) measuredW = node->extentRight - node->extentLeft;
		if (wrapH) measuredH = node->extentBottom - node->extentTop;

		node->measuredWidth = mw;
		node->measuredHeight = mh;

		node->relayoutNeeded = true;
	}

	if (wrapW || wrapH) {
		if (DLLayoutNodeInvalidBorder(node)) {
			DLLayoutNodeResolveBorder(node);
		}
	}

	if (wrapW) {
		measuredW = DL_ROUND(scale, measuredW + node->measuredBorderLeft + node->measuredBorderRight);
		DL_CLAMP(measuredW, node->width.min, node->width.max);
	}

	if (wrapH) {
		measuredH = DL_ROUND(scale, measuredH + node->measuredBorderTop + node->measuredBorderBottom);
		DL_CLAMP(measuredH, node->height.min, node->height.max);
	}

	// TODO IFDEF TEST
	node->resolveSizeCount++;
}

void
DLLayoutNodeLayoutWrappedLayout(DLLayoutNodeRef node)
{
	if (node->relayoutNeeded == false) {
		return;
	}

	if (node->children.size() == 0) {
		return;
	}

	if (node->contentLocation == kDLLayoutContentLocationStart &&
		node->contentArrangement == kDLLayoutContentArrangementStart) {
		return;
	}

	node->invalidLayout = true;

	node->relayout = true;
	DLLayoutNodeResolveLayout(node);
	node->relayout = false;

	node->relayoutNeeded = false;
}

bool
DLLayoutNodeInvalidInnerSize(DLLayoutNodeRef node)
{
	return node->invalidInnerSize;
}

bool
DLLayoutNodeInvalidContentSize(DLLayoutNodeRef node)
{
	if (node->invalidContentSize) {
		return true;
	}

	if (node->contentWidth.type == kDLLayoutContentSizeTypeAuto &&
		node->contentHeight.type == kDLLayoutContentSizeTypeAuto) {
		return false;
	}

	if (node->contentWidth.unit == kDLLayoutContentSizeUnitPX &&
		node->contentHeight.unit == kDLLayoutContentSizeUnitPX) {
		return false;
	}

	if (node->parent == NULL) {
		return false;
	}

	if (node->measuredInnerWidthUpdated &&
		node->contentWidth.unit == kDLLayoutContentSizeUnitPC) {
		return true;
	}

	if (node->measuredInnerHeightUpdated &&
		node->contentHeight.unit == kDLLayoutContentSizeUnitPC) {
		return true;
	}

	if (node->parent->measuredInnerWidthUpdated) {
		if (node->contentWidth.unit == kDLLayoutContentSizeUnitPW ||
			node->contentHeight.unit == kDLLayoutContentSizeUnitPW) {
			return true;
		}
	}

	if (node->parent->measuredInnerHeightUpdated) {
		if (node->contentWidth.unit == kDLLayoutContentSizeUnitPH ||
			node->contentHeight.unit == kDLLayoutContentSizeUnitPH) {
			return true;
		}
	}

	if (node->parent->measuredContentWidthUpdated) {
		if (node->contentWidth.unit == kDLLayoutContentSizeUnitCW ||
			node->contentHeight.unit == kDLLayoutContentSizeUnitCW) {
			return true;
		}
	}

	if (node->parent->measuredContentHeightUpdated) {
		if (node->contentWidth.unit == kDLLayoutContentSizeUnitCH ||
			node->contentHeight.unit == kDLLayoutContentSizeUnitCH) {
			return true;
		}
	}

	if (node->layout->viewportWidthUpdated) {
		if (node->contentWidth.unit == kDLLayoutContentSizeUnitVW ||
			node->contentHeight.unit == kDLLayoutContentSizeUnitVW) {
			return true;
		}
	}

	if (node->layout->viewportHeightUpdated) {
		if (node->contentWidth.unit == kDLLayoutContentSizeUnitVH ||
			node->contentHeight.unit == kDLLayoutContentSizeUnitVH) {
			return true;
		}
	}

	return false;
}

bool
DLLayoutNodeInvalidMargin(DLLayoutNodeRef node)
{
	if (node->invalidMargin) {
		return true;
	}

	if (node->marginTop.unit == kDLLayoutMarginUnitPX &&
		node->marginLeft.unit == kDLLayoutMarginUnitPX &&
		node->marginRight.unit == kDLLayoutMarginUnitPX &&
		node->marginBottom.unit == kDLLayoutMarginUnitPX) {
		return false;
	}

	if (node->parent == NULL) {
		return false;
	}

	if (node->parent->measuredInnerWidthUpdated) {
		if (node->marginLeft.unit == kDLLayoutMarginUnitPC ||
			node->marginRight.unit == kDLLayoutMarginUnitPC) {
			return true;
		}
	}

	if (node->parent->measuredInnerHeightUpdated) {
		if (node->marginTop.unit == kDLLayoutMarginUnitPC ||
			node->marginBottom.unit == kDLLayoutMarginUnitPC) {
			return true;
		}
	}

	if (node->parent->measuredInnerWidthUpdated) {
		if (node->marginTop.unit == kDLLayoutMarginUnitPW ||
			node->marginLeft.unit == kDLLayoutMarginUnitPW ||
			node->marginRight.unit == kDLLayoutMarginUnitPW ||
			node->marginBottom.unit == kDLLayoutMarginUnitPW) {
			return true;
		}
	}

	if (node->parent->measuredInnerHeightUpdated) {
		if (node->marginTop.unit == kDLLayoutMarginUnitPH ||
			node->marginLeft.unit == kDLLayoutMarginUnitPH ||
			node->marginRight.unit == kDLLayoutMarginUnitPH ||
			node->marginBottom.unit == kDLLayoutMarginUnitPH) {
			return true;
		}
	}

	if (node->parent->measuredContentWidthUpdated) {
		if (node->marginTop.unit == kDLLayoutMarginUnitCW ||
			node->marginLeft.unit == kDLLayoutMarginUnitCW ||
			node->marginRight.unit == kDLLayoutMarginUnitCW ||
			node->marginBottom.unit == kDLLayoutMarginUnitCW) {
			return true;
		}
	}

	if (node->parent->measuredContentHeightUpdated) {
		if (node->marginTop.unit == kDLLayoutMarginUnitCH ||
			node->marginLeft.unit == kDLLayoutMarginUnitCH ||
			node->marginRight.unit == kDLLayoutMarginUnitCH ||
			node->marginBottom.unit == kDLLayoutMarginUnitCH) {
			return true;
		}
	}

	if (node->layout->viewportWidthUpdated) {
		if (node->marginTop.unit == kDLLayoutMarginUnitVW ||
			node->marginLeft.unit == kDLLayoutMarginUnitVW ||
			node->marginRight.unit == kDLLayoutMarginUnitVW ||
			node->marginBottom.unit == kDLLayoutMarginUnitVW) {
			return true;
		}
	}

	if (node->layout->viewportHeightUpdated) {
		if (node->marginTop.unit == kDLLayoutMarginUnitVH ||
			node->marginLeft.unit == kDLLayoutMarginUnitVH ||
			node->marginRight.unit == kDLLayoutMarginUnitVH ||
			node->marginBottom.unit == kDLLayoutMarginUnitVH) {
			return true;
		}
	}

	return false;
}

bool
DLLayoutNodeInvalidBorder(DLLayoutNodeRef node)
{
	if (node->invalidBorder) {
		return true;
	}

	if (node->borderTop.unit == kDLLayoutBorderUnitPX &&
		node->borderLeft.unit == kDLLayoutBorderUnitPX &&
		node->borderRight.unit == kDLLayoutBorderUnitPX &&
		node->borderBottom.unit == kDLLayoutBorderUnitPX) {
		return false;
	}

	if (node->parent == NULL) {
		return false;
	}

	if (node->measuredWidthUpdated) {
		if (node->borderLeft.unit == kDLLayoutBorderUnitPC ||
			node->borderRight.unit == kDLLayoutBorderUnitPC) {
			return true;
		}
	}

	if (node->measuredHeightUpdated) {
		if (node->borderTop.unit == kDLLayoutBorderUnitPC ||
			node->borderBottom.unit == kDLLayoutBorderUnitPC) {
			return true;
		}
	}

	if (node->parent->measuredInnerWidthUpdated) {
		if (node->borderTop.unit == kDLLayoutBorderUnitPW ||
			node->borderLeft.unit == kDLLayoutBorderUnitPW ||
			node->borderRight.unit == kDLLayoutBorderUnitPW ||
			node->borderBottom.unit == kDLLayoutBorderUnitPW) {
			return true;
		}
	}

	if (node->parent->measuredInnerHeightUpdated) {
		if (node->borderTop.unit == kDLLayoutBorderUnitPH ||
			node->borderLeft.unit == kDLLayoutBorderUnitPH ||
			node->borderRight.unit == kDLLayoutBorderUnitPH ||
			node->borderBottom.unit == kDLLayoutBorderUnitPH) {
			return true;
		}
	}

	if (node->parent->measuredContentWidthUpdated) {
		if (node->borderTop.unit == kDLLayoutBorderUnitCW ||
			node->borderLeft.unit == kDLLayoutBorderUnitCW ||
			node->borderRight.unit == kDLLayoutBorderUnitCW ||
			node->borderBottom.unit == kDLLayoutBorderUnitCW) {
			return true;
		}
	}

	if (node->parent->measuredContentHeightUpdated) {
		if (node->borderTop.unit == kDLLayoutBorderUnitCH ||
			node->borderLeft.unit == kDLLayoutBorderUnitCH ||
			node->borderRight.unit == kDLLayoutBorderUnitCH ||
			node->borderBottom.unit == kDLLayoutBorderUnitCH) {
			return true;
		}
	}

	if (node->layout->viewportWidthUpdated) {
		if (node->borderTop.unit == kDLLayoutBorderUnitVW ||
			node->borderLeft.unit == kDLLayoutBorderUnitVW ||
			node->borderRight.unit == kDLLayoutBorderUnitVW ||
			node->borderBottom.unit == kDLLayoutBorderUnitVW) {
			return true;
		}
	}

	if (node->layout->viewportHeightUpdated) {
		if (node->borderTop.unit == kDLLayoutBorderUnitVH ||
			node->borderLeft.unit == kDLLayoutBorderUnitVW ||
			node->borderRight.unit == kDLLayoutBorderUnitVW ||
			node->borderBottom.unit == kDLLayoutBorderUnitVW) {
			return true;
		}
	}

	return false;
}

bool
DLLayoutNodeInvalidPadding(DLLayoutNodeRef node)
{
	if (node->invalidPadding) {
		return true;
	}

	if (node->paddingTop.unit == kDLLayoutPaddingUnitPX &&
		node->paddingLeft.unit == kDLLayoutPaddingUnitPX &&
		node->paddingRight.unit == kDLLayoutPaddingUnitPX &&
		node->paddingBottom.unit == kDLLayoutPaddingUnitPX) {
		return false;
	}

	if (node->parent == NULL) {
		return false;
	}

	if (node->measuredInnerWidthUpdated) {
		if (node->paddingLeft.unit == kDLLayoutPaddingUnitPC ||
			node->paddingRight.unit == kDLLayoutPaddingUnitPC) {
			return true;
		}
	}

	if (node->measuredInnerHeightUpdated) {
		if (node->paddingTop.unit == kDLLayoutPaddingUnitPC ||
			node->paddingBottom.unit == kDLLayoutPaddingUnitPC) {
			return true;
		}
	}

	if (node->parent->measuredInnerWidthUpdated) {
		if (node->paddingTop.unit == kDLLayoutPaddingUnitPW ||
			node->paddingLeft.unit == kDLLayoutPaddingUnitPW ||
			node->paddingRight.unit == kDLLayoutPaddingUnitPW ||
			node->paddingBottom.unit == kDLLayoutPaddingUnitPW) {
			return true;
		}
	}

	if (node->parent->measuredInnerHeightUpdated) {
		if (node->paddingTop.unit == kDLLayoutPaddingUnitPH ||
			node->paddingLeft.unit == kDLLayoutPaddingUnitPH ||
			node->paddingRight.unit == kDLLayoutPaddingUnitPH ||
			node->paddingBottom.unit == kDLLayoutPaddingUnitPH) {
			return true;
		}
	}

	if (node->parent->measuredContentWidthUpdated) {
		if (node->paddingTop.unit == kDLLayoutPaddingUnitCW ||
			node->paddingLeft.unit == kDLLayoutPaddingUnitCW ||
			node->paddingRight.unit == kDLLayoutPaddingUnitCW ||
			node->paddingBottom.unit == kDLLayoutPaddingUnitCW) {
			return true;
		}
	}

	if (node->parent->measuredContentHeightUpdated) {
		if (node->paddingTop.unit == kDLLayoutPaddingUnitCH ||
			node->paddingLeft.unit == kDLLayoutPaddingUnitCH ||
			node->paddingRight.unit == kDLLayoutPaddingUnitCH ||
			node->paddingBottom.unit == kDLLayoutPaddingUnitCH) {
			return true;
		}
	}

	if (node->layout->viewportWidthUpdated) {
		if (node->paddingTop.unit == kDLLayoutPaddingUnitVW ||
			node->paddingLeft.unit == kDLLayoutPaddingUnitVW ||
			node->paddingRight.unit == kDLLayoutPaddingUnitVW ||
			node->paddingBottom.unit == kDLLayoutPaddingUnitVW) {
			return true;
		}
	}

	if (node->layout->viewportHeightUpdated) {
		if (node->paddingTop.unit == kDLLayoutPaddingUnitVH ||
			node->paddingLeft.unit == kDLLayoutPaddingUnitVH ||
			node->paddingRight.unit == kDLLayoutPaddingUnitVH ||
			node->paddingBottom.unit == kDLLayoutPaddingUnitVH) {
			return true;
		}
	}

	return false;
}

// Test functions

int
DLLayoutNodeGetResolveSizeCount(DLLayoutNodeRef node)
{
	return node->resolveSizeCount;
}

int
DLLayoutNodeGetResolvePositionCount(DLLayoutNodeRef node)
{
	return node->resolvePositionCount;
}
