#include <queue>
#include <vector>
#include <iostream>
#include <algorithm>
#include "DLLayoutNode.h"
#include "DLLayoutNodePrivate.h"
#include "DLLayoutPrivate.h"
#include "DLAbsoluteLayout.h"
#include "DLRelativeLayout.h"

#ifdef ANDROID
#include "jni_init.h"
#endif

using std::max;
using std::cerr;
using std::string;
using std::queue;
using std::vector;

#include <chrono>
using namespace std;
using namespace std::chrono;

DLLayoutNodeRef
DLLayoutNodeCreate()
{
	DLLayoutNodeRef node = new OpaqueDLLayoutNode;
	node->width.type = kDLLayoutSizeTypeFill;
	node->height.type = kDLLayoutSizeTypeFill;
	return node;
}

void
DLLayoutNodeDelete(DLLayoutNodeRef node)
{
	delete node;
}

void
DLLayoutNodeSetLayout(DLLayoutNodeRef node, DLLayoutRef layout)
{
	node->layout = layout;
}

void
DLLayoutNodeSetId(DLLayoutNodeRef node, const char* id)
{
	node->id = string(id);
}

void
DLLayoutNodeSetRoot(DLLayoutNodeRef node, bool root)
{
	node->root = root;
}

void
DLLayoutNodeSetAnchorTop(DLLayoutNodeRef node, DLLayoutAnchorType type, DLLayoutAnchorUnit unit, double length)
{
	DL_FILTER_ANCHOR(type, unit, length);

	node->anchorTop.type = type;
	node->anchorTop.unit = unit;
	node->anchorTop.length = length;

	DLLayoutNodeInvalidatePosition(node);
}

void
DLLayoutNodeSetAnchorLeft(DLLayoutNodeRef node, DLLayoutAnchorType type, DLLayoutAnchorUnit unit, double length)
{
	DL_FILTER_ANCHOR(type, unit, length);

	node->anchorLeft.type = type;
	node->anchorLeft.unit = unit;
	node->anchorLeft.length = length;

	DLLayoutNodeInvalidatePosition(node);
}

void
DLLayoutNodeSetTop(DLLayoutNodeRef node, DLLayoutPositionType type, DLLayoutPositionUnit unit, double length)
{
	DL_FILTER_POSITION(type, unit, length);

	node->top.type = type;
	node->top.unit = unit;
	node->top.length = length;

	DLLayoutNodeInvalidatePosition(node);
}

void
DLLayoutNodeSetMinTop(DLLayoutNodeRef node, double min)
{
	if (node->top.min != min) {
		node->top.min = min;
		DLLayoutNodeInvalidatePosition(node);
	}
}

void
DLLayoutNodeSetMaxTop(DLLayoutNodeRef node, double max)
{
	if (node->top.max != max) {
		node->top.max = max;
		DLLayoutNodeInvalidatePosition(node);
	}
}

void
DLLayoutNodeSetLeft(DLLayoutNodeRef node, DLLayoutPositionType type, DLLayoutPositionUnit unit, double length)
{
	DL_FILTER_POSITION(type, unit, length);

	node->left.type = type;
	node->left.unit = unit;
	node->left.length = length;

	DLLayoutNodeInvalidatePosition(node);
}

void
DLLayoutNodeSetMinLeft(DLLayoutNodeRef node, double min)
{
	if (node->left.min != min) {
		node->left.min = min;
		DLLayoutNodeInvalidatePosition(node);
	}
}

void
DLLayoutNodeSetMaxLeft(DLLayoutNodeRef node, double max)
{
	if (node->left.max != max) {
		node->left.max = max;
		DLLayoutNodeInvalidatePosition(node);
	}
}

void
DLLayoutNodeSetRight(DLLayoutNodeRef node, DLLayoutPositionType type, DLLayoutPositionUnit unit, double length)
{
	DL_FILTER_POSITION(type, unit, length);

	node->right.type = type;
	node->right.unit = unit;
	node->right.length = length;

	DLLayoutNodeInvalidatePosition(node);
}

void
DLLayoutNodeSetMinRight(DLLayoutNodeRef node, double min)
{
	if (node->right.min != min) {
		node->right.min = min;
		DLLayoutNodeInvalidatePosition(node);
	}
}

void
DLLayoutNodeSetMaxRight(DLLayoutNodeRef node, double max)
{
	if (node->right.max != max) {
		node->right.max = max;
		DLLayoutNodeInvalidatePosition(node);
	}
}

void
DLLayoutNodeSetBottom(DLLayoutNodeRef node, DLLayoutPositionType type, DLLayoutPositionUnit unit, double length)
{
	DL_FILTER_POSITION(type, unit, length);

	node->bottom.type = type;
	node->bottom.unit = unit;
	node->bottom.length = length;

	DLLayoutNodeInvalidatePosition(node);
}

void
DLLayoutNodeSetMinBottom(DLLayoutNodeRef node, double min)
{
	if (node->bottom.min != min) {
		node->bottom.min = min;
		DLLayoutNodeInvalidatePosition(node);
	}
}

void
DLLayoutNodeSetMaxBottom(DLLayoutNodeRef node, double max)
{
	if (node->bottom.max != max) {
		node->bottom.max = max;
		DLLayoutNodeInvalidatePosition(node);
	}
}

void
DLLayoutNodeSetWidth(DLLayoutNodeRef node, DLLayoutSizeType type, DLLayoutSizeUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

    DL_FILTER_SIZE(type, unit, length);

	node->width.type = type;
	node->width.unit = unit;
	node->width.length = length;

	DLLayoutNodeInvalidateSize(node);
}

void
DLLayoutNodeSetMinWidth(DLLayoutNodeRef node, double min)
{
	DL_CLAMP(min, 0, DBL_MAX);

	if (node->width.min != min) {
		node->width.min = min;
		DLLayoutNodeInvalidateSize(node);
	}
}

void
DLLayoutNodeSetMaxWidth(DLLayoutNodeRef node, double max)
{
	DL_CLAMP(max, 0, DBL_MAX);

	if (node->width.max != max) {
		node->width.max = max;
		DLLayoutNodeInvalidateSize(node);
	}
}

void
DLLayoutNodeSetHeight(DLLayoutNodeRef node, DLLayoutSizeType type, DLLayoutSizeUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

	DL_FILTER_SIZE(type, unit, length);

	node->height.type = type;
	node->height.unit = unit;
	node->height.length = length;

	DLLayoutNodeInvalidateSize(node);
}

void
DLLayoutNodeSetMinHeight(DLLayoutNodeRef node, double min)
{
	DL_CLAMP(min, 0, DBL_MAX);

	if (node->height.min != min) {
		node->height.min = min;
		DLLayoutNodeInvalidateSize(node);
	}
}

void
DLLayoutNodeSetMaxHeight(DLLayoutNodeRef node, double max)
{
	DL_CLAMP(max, 0, DBL_MAX);

	if (node->height.max != max) {
		node->height.max = max;
		DLLayoutNodeInvalidateSize(node);
	}
}

void
DLLayoutNodeSetContentDirection(DLLayoutNodeRef node, DLLayoutContentDirection direction)
{
	if (node->contentDirection != direction) {
		node->contentDirection = direction;
		DLLayoutNodeInvalidateLayout(node);
	}
}

void
DLLayoutNodeSetContentLocation(DLLayoutNodeRef node, DLLayoutContentLocation location)
{
	if (node->contentLocation != location) {
		node->contentLocation = location;
		DLLayoutNodeInvalidateLayout(node);
	}
}

void
DLLayoutNodeSetContentAlignment(DLLayoutNodeRef node, DLLayoutContentAlignment alignment)
{
	if (node->contentAlignment != alignment) {
		node->contentAlignment = alignment;
		DLLayoutNodeInvalidateLayout(node);
	}
}

void
DLLayoutNodeSetContentTop(DLLayoutNodeRef node, DLLayoutContentPositionType type, DLLayoutContentPositionUnit unit, double length)
{
    DL_CLAMP(length, DBL_MIN, DBL_MAX);

	node->contentTop.type = type;
	node->contentTop.unit = unit;
	node->contentTop.length = length;

	// This is temporary until units other than pixels are available.
	node->measuredContentTop = length;

	DLLayoutNodeInvalidateLayout(node);
}

void
DLLayoutNodeSetContentLeft(DLLayoutNodeRef node, DLLayoutContentPositionType type, DLLayoutContentPositionUnit unit, double length)
{
    DL_CLAMP(length, DBL_MIN, DBL_MAX);

	node->contentLeft.type = type;
	node->contentLeft.unit = unit;
	node->contentLeft.length = length;

	// This is temporary until units other than pixels are available.
	node->measuredContentLeft = length;

	DLLayoutNodeInvalidateLayout(node);
}

void
DLLayoutNodeSetContentWidth(DLLayoutNodeRef node, DLLayoutContentSizeType type, DLLayoutContentSizeUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

	DL_FILTER_CONTENT_SIZE(type, unit, length);

	node->contentWidth.type = type;
	node->contentWidth.unit = unit;
	node->contentWidth.length = length;

	DLLayoutNodeInvalidateContentSize(node);
}

void
DLLayoutNodeSetContentHeight(DLLayoutNodeRef node, DLLayoutContentSizeType type, DLLayoutContentSizeUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

	DL_FILTER_CONTENT_SIZE(type, unit, length);

	node->contentHeight.type = type;
	node->contentHeight.unit = unit;
	node->contentHeight.length = length;

	DLLayoutNodeInvalidateContentSize(node);
}

void
DLLayoutNodeSetExpand(DLLayoutNodeRef node, double ratio)
{
	if (node->expand == ratio) {
		return;
	}

	node->expand = ratio;

	DLLayoutNodeInvalidateSize(node);
}

void
DLLayoutNodeSetShrink(DLLayoutNodeRef node, double ratio)
{
	if (node->shrink == ratio) {
		return;
	}

	node->shrink = ratio;

	DLLayoutNodeInvalidateSize(node);
}

void
DLLayoutNodeSetBorderTop(DLLayoutNodeRef node, DLLayoutBorderType type, DLLayoutBorderUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

    node->borderTop.type = type;
    node->borderTop.unit = unit;
    node->borderTop.length = length;

    DLLayoutNodeInvalidateBorder(node);
}

void
DLLayoutNodeSetBorderLeft(DLLayoutNodeRef node, DLLayoutBorderType type, DLLayoutBorderUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

    node->borderLeft.type = type;
    node->borderLeft.unit = unit;
    node->borderLeft.length = length;

    DLLayoutNodeInvalidateBorder(node);
}

void
DLLayoutNodeSetBorderRight(DLLayoutNodeRef node, DLLayoutBorderType type, DLLayoutBorderUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

    node->borderRight.type = type;
    node->borderRight.unit = unit;
    node->borderRight.length = length;

    DLLayoutNodeInvalidateBorder(node);
}

void
DLLayoutNodeSetBorderBottom(DLLayoutNodeRef node, DLLayoutBorderType type, DLLayoutBorderUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

    node->borderBottom.type = type;
    node->borderBottom.unit = unit;
    node->borderBottom.length = length;

    DLLayoutNodeInvalidateBorder(node);
}

void
DLLayoutNodeSetMarginTop(DLLayoutNodeRef node, DLLayoutMarginType type, DLLayoutMarginUnit unit, double length)
{
	node->marginTop.type = type;
	node->marginTop.unit = unit;
	node->marginTop.length = length;

	DLLayoutNodeInvalidateMargin(node);
}

void
DLLayoutNodeSetMarginLeft(DLLayoutNodeRef node, DLLayoutMarginType type, DLLayoutMarginUnit unit, double length)
{
	node->marginLeft.type = type;
	node->marginLeft.unit = unit;
	node->marginLeft.length = length;

	DLLayoutNodeInvalidateMargin(node);
}

void
DLLayoutNodeSetMarginRight(DLLayoutNodeRef node, DLLayoutMarginType type, DLLayoutMarginUnit unit, double length)
{
	node->marginRight.type = type;
	node->marginRight.unit = unit;
	node->marginRight.length = length;

	DLLayoutNodeInvalidateMargin(node);
}

void
DLLayoutNodeSetMarginBottom(DLLayoutNodeRef node, DLLayoutMarginType type, DLLayoutMarginUnit unit, double length)
{
	node->marginBottom.type = type;
	node->marginBottom.unit = unit;
	node->marginBottom.length = length;

	DLLayoutNodeInvalidateMargin(node);
}

void
DLLayoutNodeSetMinMarginTop(DLLayoutNodeRef node, double min)
{
	if (node->marginTop.min != min) {
		node->marginTop.min = min;
		DLLayoutNodeInvalidateMargin(node);
	}
}

void
DLLayoutNodeSetMaxMarginTop(DLLayoutNodeRef node, double max)
{
	if (node->marginTop.max != max) {
		node->marginTop.max = max;
		DLLayoutNodeInvalidateMargin(node);
	}
}

void
DLLayoutNodeSetMinMarginLeft(DLLayoutNodeRef node, double min)
{
	if (node->marginLeft.min != min) {
		node->marginLeft.min = min;
		DLLayoutNodeInvalidateMargin(node);
	}
}

void
DLLayoutNodeSetMaxMarginLeft(DLLayoutNodeRef node, double max)
{
	if (node->marginLeft.max != max) {
		node->marginLeft.max = max;
		DLLayoutNodeInvalidateMargin(node);
	}
}

void
DLLayoutNodeSetMinMarginRight(DLLayoutNodeRef node, double min)
{
	if (node->marginRight.min != min) {
		node->marginRight.min = min;
		DLLayoutNodeInvalidateMargin(node);
	}
}

void
DLLayoutNodeSetMaxMarginRight(DLLayoutNodeRef node, double max)
{
	if (node->marginRight.max != max) {
		node->marginRight.max = max;
		DLLayoutNodeInvalidateMargin(node);
	}
}

void
DLLayoutNodeSetMinMarginBottom(DLLayoutNodeRef node, double min)
{
	if (node->marginBottom.min != min) {
		node->marginBottom.min = min;
		DLLayoutNodeInvalidateMargin(node);
	}
}

void
DLLayoutNodeSetMaxMarginBottom(DLLayoutNodeRef node, double max)
{
	if (node->marginBottom.max != max) {
		node->marginBottom.max = max;
		DLLayoutNodeInvalidateMargin(node);
	}
}

void
DLLayoutNodeSetPaddingTop(DLLayoutNodeRef node, DLLayoutPaddingType type, DLLayoutPaddingUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

	node->paddingTop.type = type;
	node->paddingTop.unit = unit;
	node->paddingTop.length = length;

	DLLayoutNodeInvalidatePadding(node);
}

void
DLLayoutNodeSetPaddingLeft(DLLayoutNodeRef node, DLLayoutPaddingType type, DLLayoutPaddingUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

	node->paddingLeft.type = type;
	node->paddingLeft.unit = unit;
	node->paddingLeft.length = length;

	DLLayoutNodeInvalidatePadding(node);
}

void
DLLayoutNodeSetPaddingRight(DLLayoutNodeRef node, DLLayoutPaddingType type, DLLayoutPaddingUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

	node->paddingRight.type = type;
	node->paddingRight.unit = unit;
	node->paddingRight.length = length;

	DLLayoutNodeInvalidatePadding(node);
}

void
DLLayoutNodeSetPaddingBottom(DLLayoutNodeRef node, DLLayoutPaddingType type, DLLayoutPaddingUnit unit, double length)
{
    DL_CLAMP(length, 0, DBL_MAX);

	node->paddingBottom.type = type;
	node->paddingBottom.unit = unit;
	node->paddingBottom.length = length;

	DLLayoutNodeInvalidatePadding(node);
}

void
DLLayoutNodeSetMinPaddingTop(DLLayoutNodeRef node, double min)
{
	DL_CLAMP(min, 0, DBL_MAX);

	if (node->paddingTop.min != min) {
		node->paddingTop.min = min;
		DLLayoutNodeInvalidatePadding(node);
	}
}

void
DLLayoutNodeSetMaxPaddingTop(DLLayoutNodeRef node, double max)
{
	DL_CLAMP(max, 0, DBL_MAX);

	if (node->paddingTop.max != max) {
		node->paddingTop.max = max;
		DLLayoutNodeInvalidatePadding(node);
	}
}

void
DLLayoutNodeSetMinPaddingLeft(DLLayoutNodeRef node, double min)
{
	DL_CLAMP(min, 0, DBL_MAX);

	if (node->paddingLeft.min != min) {
		node->paddingLeft.min = min;
		DLLayoutNodeInvalidatePadding(node);
	}
}

void
DLLayoutNodeSetMaxPaddingLeft(DLLayoutNodeRef node, double max)
{
	DL_CLAMP(max, 0, DBL_MAX);

	if (node->paddingLeft.max != max) {
		node->paddingLeft.max = max;
		DLLayoutNodeInvalidatePadding(node);
	}
}

void
DLLayoutNodeSetMinPaddingRight(DLLayoutNodeRef node, double min)
{
	DL_CLAMP(min, 0, DBL_MAX);

	if (node->paddingRight.min != min) {
		node->paddingRight.min = min;
		DLLayoutNodeInvalidatePadding(node);
	}
}

void
DLLayoutNodeSetMaxPaddingRight(DLLayoutNodeRef node, double max)
{
	DL_CLAMP(max, 0, DBL_MAX);

	if (node->paddingRight.max != max) {
		node->paddingRight.max = max;
		DLLayoutNodeInvalidatePadding(node);
	}
}

void
DLLayoutNodeSetMinPaddingBottom(DLLayoutNodeRef node, double min)
{
	DL_CLAMP(min, 0, DBL_MAX);

	if (node->paddingBottom.min != min) {
		node->paddingBottom.min = min;
		DLLayoutNodeInvalidatePadding(node);
	}
}

void
DLLayoutNodeSetMaxPaddingBottom(DLLayoutNodeRef node, double max)
{
	DL_CLAMP(max, 0, DBL_MAX);

	if (node->paddingBottom.max != max) {
		node->paddingBottom.max = max;
		DLLayoutNodeInvalidatePadding(node);
	}
}

bool
DLLayoutNodeFillsParentWidth(DLLayoutNodeRef node)
{
	return node->width.type == kDLLayoutSizeTypeFill;
}

bool
DLLayoutNodeFillsParentHeight(DLLayoutNodeRef node)
{
	return node->height.type == kDLLayoutSizeTypeFill;
}

bool
DLLayoutNodeWrapsContentWidth(DLLayoutNodeRef node)
{
	return node->width.type == kDLLayoutSizeTypeWrap;
}

bool
DLLayoutNodeWrapsContentHeight(DLLayoutNodeRef node)
{
	return node->height.type == kDLLayoutSizeTypeWrap;
}

double
DLLayoutNodeGetMeasuredTop(DLLayoutNodeRef node)
{
	return node->measuredTop;
}

double
DLLayoutNodeGetMeasuredLeft(DLLayoutNodeRef node)
{
	return node->measuredLeft;
}

double
DLLayoutNodeGetMeasuredRight(DLLayoutNodeRef node)
{
	return node->measuredRight;
}

double
DLLayoutNodeGetMeasuredBottom(DLLayoutNodeRef node)
{
	return node->measuredBottom;
}

double
DLLayoutNodeGetMeasuredWidth(DLLayoutNodeRef node)
{
	return node->measuredWidth;
}

double
DLLayoutNodeGetMeasuredHeight(DLLayoutNodeRef node)
{
	return node->measuredHeight;
}

double
DLLayoutNodeGetMeasuredInnerWidth(DLLayoutNodeRef node)
{
	return node->measuredInnerWidth;
}

double
DLLayoutNodeGetMeasuredInnerHeight(DLLayoutNodeRef node)
{
	return node->measuredInnerHeight;
}

double
DLLayoutNodeGetMeasuredContentWidth(DLLayoutNodeRef node)
{
	return node->measuredContentWidth;
}

double
DLLayoutNodeGetMeasuredContentHeight(DLLayoutNodeRef node)
{
	return node->measuredContentHeight;
}

double
DLLayoutNodeGetMeasuredBorderTop(DLLayoutNodeRef node)
{
    return node->measuredBorderTop;
}

double
DLLayoutNodeGetMeasuredBorderLeft(DLLayoutNodeRef node)
{
    return node->measuredBorderLeft;
}

double
DLLayoutNodeGetMeasuredBorderRight(DLLayoutNodeRef node)
{
	return node->measuredBorderRight;
}

double
DLLayoutNodeGetMeasuredBorderBottom(DLLayoutNodeRef node)
{
    return node->measuredBorderBottom;
}

double
DLLayoutNodeGetMeasuredMarginTop(DLLayoutNodeRef node)
{
	return node->measuredMarginTop;
}

double
DLLayoutNodeGetMeasuredMarginLeft(DLLayoutNodeRef node)
{
	return node->measuredMarginLeft;
}

double
DLLayoutNodeGetMeasuredMarginRight(DLLayoutNodeRef node)
{
	return node->measuredMarginRight;
}

double
DLLayoutNodeGetMeasuredMarginBottom(DLLayoutNodeRef node)
{
	return node->measuredMarginBottom;
}

double
DLLayoutNodeGetMeasuredPaddingTop(DLLayoutNodeRef node)
{
	return node->measuredPaddingTop;
}

double
DLLayoutNodeGetMeasuredPaddingLeft(DLLayoutNodeRef node)
{
	return node->measuredPaddingLeft;
}

double
DLLayoutNodeGetMeasuredPaddingRight(DLLayoutNodeRef node)
{
	return node->measuredPaddingRight;
}

double
DLLayoutNodeGetMeasuredPaddingBottom(DLLayoutNodeRef node)
{
	return node->measuredPaddingBottom;
}

double
DLLayoutNodeGetViewportWidth(DLLayoutNodeRef node)
{
	return node->layout->viewportWidth;
}

double
DLLayoutNodeGetViewportHeight(DLLayoutNodeRef node)
{
	return node->layout->viewportHeight;
}

void
DLLayoutNodeSetVisible(DLLayoutNodeRef node, bool visible)
{
	if (node->visible != visible) {
		node->visible = visible;
		DLLayoutNodeInvalidateParentLayout(node);
	}
}

void
DLLayoutNodeAppendChild(DLLayoutNodeRef node, DLLayoutNodeRef child)
{
	DLLayoutNodeInsertChild(node, child, (int) node->children.size());
}

void
DLLayoutNodeInsertChild(DLLayoutNodeRef node, DLLayoutNodeRef child, int index)
{
	auto it = find(
		node->children.begin(),
		node->children.end(),
		child
	);

	if (it != node->children.end()) {
		return;
	}

	node->children.insert(node->children.begin() + index, child);

	child->parent = node;

	DLLayoutNodeInvalidateLayout(node);

	const DLLayoutSizeType w = node->width.type;
	const DLLayoutSizeType h = node->height.type;

	if (w == kDLLayoutSizeTypeWrap ||
		h == kDLLayoutSizeTypeWrap) {
		node->invalidSize = true;
		node->invalidPosition = true;
		DLLayoutNodeInvalidateParentLayout(node);
	}
}

void
DLLayoutNodeRemoveChild(DLLayoutNodeRef node, DLLayoutNodeRef child)
{
	const vector<DLLayoutNodeRef>::iterator it = find(
		node->children.begin(),
		node->children.end(),
		child
	);

	if (it == node->children.end()) {
		return;
	}

	node->children.erase(it);

	child->parent = NULL;

	DLLayoutNodeInvalidateLayout(node);

	const DLLayoutSizeType w = node->width.type;
	const DLLayoutSizeType h = node->height.type;
	if (w == kDLLayoutSizeTypeWrap ||
		h == kDLLayoutSizeTypeWrap) {
		DLLayoutNodeInvalidateParentLayout(node);
	}
}

//------------------------------------------------------------------------------
// Invalidations
//------------------------------------------------------------------------------

void
DLLayoutNodeInvalidatePosition(DLLayoutNodeRef node)
{
	if (node->invalidPosition) {
		return;
	}

	node->invalidPosition = true;

	DLLayoutNodeInvalidateParentLayout(node);
}

void
DLLayoutNodeInvalidateSize(DLLayoutNodeRef node)
{
	if (node->invalidSize) {
		return;
	}

	node->invalidSize = true;

	if (node->root) {
		DLLayoutNodeInvalidateLayout(node);
		return;
	}

	DLLayoutNodeInvalidateParentLayout(node);
}

void
DLLayoutNodeInvalidateInnerSize(DLLayoutNodeRef node)
{
	if (node->invalidInnerSize) {
		return;
	}

	node->invalidInnerSize = true;

	DLLayoutNodeInvalidate(node);
}

void
DLLayoutNodeInvalidateContentSize(DLLayoutNodeRef node)
{
	if (node->invalidContentSize) {
		return;
	}

	node->invalidContentSize = true;

	DLLayoutNodeInvalidate(node);
}

void
DLLayoutNodeInvalidateContentPosition(DLLayoutNodeRef node)
{
	if (node->invalidContentPosition) {
		return;
	}

	node->invalidContentPosition = true;

	DLLayoutNodeInvalidate(node);
}

void
DLLayoutNodeInvalidateMargin(DLLayoutNodeRef node)
{
	if (node->invalidMargin) {
		return;
	}

	node->invalidMargin = true;

	DLLayoutNodeInvalidate(node);
}

void
DLLayoutNodeInvalidateBorder(DLLayoutNodeRef node)
{
	if (node->invalidBorder) {
		return;
	}

	node->invalidBorder = true;

	DLLayoutNodeInvalidate(node);
}

void
DLLayoutNodeInvalidatePadding(DLLayoutNodeRef node)
{
	if (node->invalidPadding) {
		return;
	}

	node->invalidPadding = true;

	DLLayoutNodeInvalidate(node);
}

void
DLLayoutNodeInvalidateLayout(DLLayoutNodeRef node)
{
	if (node->invalidLayout) {
		return;
	}

	node->invalidLayout = true;

	DLLayoutNodeInvalidate(node);
}

void
DLLayoutNodeInvalidateParentLayout(DLLayoutNodeRef node)
{
	DLLayoutNodeRef parent = node->parent;

	if (parent == NULL ||
		parent->invalidLayout) {
		return;
	}

	DLLayoutNodeInvalidateLayout(parent);

	/*
	 * This view might be within a wrapped view which itself can be inside another
	 * wrapper view. We need to find the highest parent of a wrap chain and invalidate
	 * this one.
	 */

	const DLLayoutSize parentW = parent->width;
	const DLLayoutSize parentH = parent->height;

	if (parentW.type == kDLLayoutSizeTypeWrap ||
		parentH.type == kDLLayoutSizeTypeWrap) {

		parent->invalidSize = true;
		parent->invalidPosition = true;

		vector<DLLayoutNodeRef> path;
		DLLayoutNodeRef last = NULL;
		DLLayoutNodeRef item = parent;

		while (item != NULL) {

			item = item->parent;

			if (item) {

				const DLLayoutSize w = item->width;
				const DLLayoutSize h = item->height;

				if (w.type != kDLLayoutSizeTypeWrap && h.type != kDLLayoutSizeTypeWrap &&
					w.type != kDLLayoutSizeTypeFill && h.type != kDLLayoutSizeTypeFill) {
					break;
				}

				item->invalidSize = true;
				item->invalidPosition = true;
				DLLayoutNodeInvalidateLayout(item);

				if (w.type == kDLLayoutSizeTypeWrap ||
					h.type == kDLLayoutSizeTypeWrap) {
					last = item;
				}
			}
		}

		if (last && last->parent) {
			DLLayoutNodeInvalidateLayout(last->parent);
		}
	}
}

bool
DLLayoutNodeHasInvalidLayout(DLLayoutNodeRef node)
{
	return node->invalidLayout;
}

bool
DLLayoutNodeHasInvalidSize(DLLayoutNodeRef node)
{
	return node->invalidSize;
}

bool
DLLayoutNodeHasInvalidPosition(DLLayoutNodeRef node)
{
	return node->invalidPosition;
}

void
DLLayoutNodeSetMeasureCallback(DLLayoutNodeRef node, DLLayoutNodeMeasureCallback callback)
{
	node->measureCallback = callback;
}

void
DLLayoutNodeSetResolveSizeCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback)
{
	node->resolveSizeCallback = callback;
}

void
DLLayoutNodeSetResolvePositionCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback)
{
	node->resolvePositionCallback = callback;
}

void
DLLayoutNodeSetResolveInnerSizeCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback)
{
	node->resolveInnerSizeCallback = callback;
}

void
DLLayoutNodeSetResolveContentSizeCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback)
{
	node->resolveContentSizeCallback = callback;
}

void
DLLayoutNodeSetResolveMarginCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback)
{
	node->resolveMarginCallback = callback;
}

void
DLLayoutNodeSetResolveBorderCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback)
{
	node->resolveBorderCallback = callback;
}

void
DLLayoutNodeSetResolvePaddingCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback)
{
	node->resolvePaddingCallback = callback;
}

void
DLLayoutNodeSetPrepareCallback(DLLayoutNodeRef node, DLLayoutNodePrepareCallback callback)
{
	node->prepareCallback = callback;
}

void
DLLayoutNodeSetLayoutBeganCallback(DLLayoutNodeRef node, DLLayoutNodeBeganCallback callback)
{
	node->layoutBeganCallback = callback;
}

void
DLLayoutNodeSetLayoutEndedCallback(DLLayoutNodeRef node, DLLayoutNodeEndedCallback callback)
{
	node->layoutEndedCallback = callback;
}

void
DLLayoutNodeSetInvalidateCallback(DLLayoutNodeRef node, DLLayoutNodeInvalidateCallback callback)
{
	node->invalidateCallback = callback;
}

void
DLLayoutNodeSetData(DLLayoutNodeRef node, void* data)
{
	node->data = data;
}

void*
DLLayoutNodeGetData(DLLayoutNodeRef node)
{
	return node->data;
}

//------------------------------------------------------------------------------
// Resolving
//------------------------------------------------------------------------------

void
DLLayoutNodeResolve(DLLayoutNodeRef node)
{
	if (node->layout == NULL ||
		node->layout->invalid == false ||
		node->layout->resolving == true) {
		return;
	}

	if (node->processing ||
		node->resolving ||
		node->layouting) {
		return;
	}

	if (node->root == false && node->parent == NULL) {
		return;
	}

	node->layout->resolving = true;

	DL_LAYOUT_CONTEXT_INVOKE(node->layout, layoutBeganCallback);

	DL_LAYOUT_TIMER_START(LAYOUT_TIME);

	if (node->layout->root &&
		node->layout->root->visible) {
		DLLayoutNodeResolveTree(node->layout->root);
	}

	DL_LAYOUT_TIMER_STOP(LAYOUT_TIME, RESULT);

	#ifdef ANDROID
		LOGD("Layout resolution: %llu microseconds", RESULT);
	#else
		std::cout << "Layout resolution: " << RESULT << " microseconds \n";
	#endif

	node->layout->invalid = false;

	if (node->layout->changed) {
		node->layout->changed = false;
		// std::cout << "The layout has changed while processing \n";
	}

	node->layout->viewportWidthUpdated = false;
	node->layout->viewportHeightUpdated = false;

	DL_LAYOUT_CONTEXT_INVOKE(node->layout, layoutEndedCallback);

	node->layout->resolving = false;
}

void
DLLayoutNodeResolveTree(DLLayoutNodeRef node)
{
	if (node->root) {
		DLLayoutNodeResolveRoot(node);
	}

	queue<DLLayoutNodeRef> queue;
	queue.push(node);

	while (queue.size() > 0) {

		DLLayoutNodeRef item = queue.front();
		DLLayoutNodeResolveLayout(item);
		queue.pop();

		for (auto &child : item->children) {
			if (child->visible) {
				queue.push(child);
			}
		}
	}
}

void
DLLayoutNodeResolveRoot(DLLayoutNodeRef node)
{
	/*
	 * This is the root node, simply apply its width and height
	 * and call it a day.
	 */

	if (node->width.type != kDLLayoutSizeTypeLength ||
		node->width.unit != kDLLayoutSizeUnitPX) {
		cerr << "The root node size must be specified in pixels.";
		abort();
	}

	if (node->height.type != kDLLayoutSizeTypeLength ||
		node->height.unit != kDLLayoutSizeUnitPX) {
		cerr << "The root node size must be specified in pixels.";
		abort();
	}

	node->measuredWidthUpdated = false;
	node->measuredHeightUpdated = false;

	if (node->invalidSize) {

		const double measuredW = node->width.length;
		const double measuredH = node->height.length;

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
		}

		node->invalidSize = false;
	}
}

void
DLLayoutNodeResolveLayout(DLLayoutNodeRef node)
{
	if (node->layout == NULL) {
		cerr << "Attempting to resolve the layout of a node that is detached from a root layout.";
		return;
	}

	/*
	 * Prevents a node that is currently being layed out to be
	 * layed out again. however, it must be allowed when the node viewport
	 * is measuring by wrapping its views.
	 */

	if (node->processing) {
		return;
	}

	/*
	 * Preparing is usually done to resolve the styles that might be applied
	 * to this node. Make sure nothing heavy is done in this callback because
	 * its basically called for every nodes.
	 */

	DL_LAYOUT_NODE_INVOKE(node, prepareCallback)

	node->measuredInnerWidthUpdated = false;
	node->measuredInnerHeightUpdated = false;
	node->measuredContentWidthUpdated = false;
	node->measuredContentHeightUpdated = false;

	if (DLLayoutNodeInvalidBorder(node)) {
		DLLayoutNodeResolveBorder(node);
	}

	if (DLLayoutNodeInvalidInnerSize(node)) {
		DLLayoutNodeResolveInnerSize(node);
	}

	if (DLLayoutNodeInvalidContentSize(node)) {
		DLLayoutNodeResolveContentSize(node);
	}

	if (DLLayoutNodeInvalidPadding(node)) {
		DLLayoutNodeResolvePadding(node);
	}

	if (node->invalidLayout) {

		node->processing = true;

		DL_LAYOUT_NODE_INVOKE(node, layoutBeganCallback)

		if (DLLayoutNodeInvalidBorder(node)) {
			DLLayoutNodeResolveBorder(node);
		}

		if (DLLayoutNodeInvalidInnerSize(node)) {
			DLLayoutNodeResolveInnerSize(node);
		}

		if (DLLayoutNodeInvalidContentSize(node)) {
			DLLayoutNodeResolveContentSize(node);
		}

		if (DLLayoutNodeInvalidPadding(node)) {
			DLLayoutNodeResolvePadding(node);
		}

		/*
		 * Its possible the layout began callback forced this node to be
		 * resolved so there are no needs to resolve it again.
		 */

		if (node->invalidLayout) {
			node->invalidLayout = false;
			DLLayoutNodePerformLayout(node);
			DL_LAYOUT_NODE_INVOKE(node, layoutEndedCallback)
		}

		node->processing = false;
	}
}

void
DLLayoutNodePerformLayout(DLLayoutNodeRef node)
{
	vector<DLLayoutNodeRef> relatives;
	vector<DLLayoutNodeRef> absolutes;

	node->layouting = true;

	node->extentTop = 0;
	node->extentLeft = 0;
	node->extentRight = 0;
	node->extentBottom = 0;

	for (auto &child : node->children) {

		if (child->visible == false) {
			continue;
		}

		if (child->layouting ||
			child->resolving) {
			continue;
		}

		child->isWrappingWidth = DLLayoutNodeShouldWrapWidth(child);
		child->isWrappingHeight = DLLayoutNodeShouldWrapHeight(child);

		if (DL_IS_ABSOLUTE(child, top)   ||
			DL_IS_ABSOLUTE(child, left)  ||
			DL_IS_ABSOLUTE(child, right) ||
			DL_IS_ABSOLUTE(child, bottom)) {
			absolutes.push_back(child);
		} else {
			relatives.push_back(child);
		}
	}

	if (relatives.size()) {
		DLRelativeLayoutResolve(node, relatives);
	}

	const bool autoContentW = node->contentWidth.type == kDLLayoutContentSizeTypeAuto;
	const bool autoContentH = node->contentHeight.type == kDLLayoutContentSizeTypeAuto;

	if (autoContentW || autoContentH) {

		const double lastContentW = node->measuredContentWidth;
		const double lastContentH = node->measuredContentHeight;

		if (autoContentW) node->measuredContentWidth = max(node->measuredContentWidth, node->extentRight);
		if (autoContentH) node->measuredContentHeight = max(node->measuredContentHeight, node->extentBottom);

		if (lastContentW != node->measuredContentWidth ||
			lastContentH != node->measuredContentHeight) {
			DL_LAYOUT_NODE_INVOKE(node, resolveContentSizeCallback)
		}
	}

	if (absolutes.size()) {
		DLAbsoluteLayoutResolve(node, absolutes);
	}

	node->layouting = false;
}

void
DLLayoutNodeResolveSelf(DLLayoutNodeRef node)
{
	if (node->layout == NULL ||
		node->layout->invalid == false) {
		return;
	}

	if (node->processing ||
		node->resolving ||
		node->layouting) {
		return;
	}

	if (node->root) {
		return;
	}

	if (node->parent == NULL) {
		return;
	}

	node->isWrappingWidth = DLLayoutNodeShouldWrapWidth(node);
	node->isWrappingHeight = DLLayoutNodeShouldWrapHeight(node);

	if (DL_IS_ABSOLUTE(node, top)   ||
		DL_IS_ABSOLUTE(node, left)  ||
		DL_IS_ABSOLUTE(node, right) ||
		DL_IS_ABSOLUTE(node, bottom)) {

		DLAbsoluteLayoutNodeMeasure(node);

	} else {

		const double paddingT = node->parent->measuredPaddingTop;
		const double paddingL = node->parent->measuredPaddingLeft;
		const double paddingR = node->parent->measuredPaddingRight;
		const double paddingB = node->parent->measuredPaddingBottom;

		double remainder = 0;
		double remainingW = max(node->parent->measuredContentWidth - paddingL - paddingR, 0.0);
		double remainingH = max(node->parent->measuredContentHeight - paddingT - paddingB, 0.0);

		DLRelativeLayoutNodeMeasure(node, remainingW, remainingH, remainder);
	}

	node->invalidSize = false;
}
