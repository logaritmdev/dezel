#include <vector>
#include <cstdlib>
#include <iostream>
#include "DLLayout.h"
#include "DLLayoutPrivate.h"
#include "DLLayoutNode.h"
#include "DLLayoutNodePrivate.h"
#include "DLLayoutPrivate.h"
#include "DLRelativeLayout.h"

#include <chrono>
using namespace std;
using namespace std::chrono;

using std::min;
using std::max;
using std::cerr;
using std::abort;
using std::vector;

inline bool
DLRelativeLayoutNodeInvalidSize(DLLayoutNodeRef node)
{
	if (node->invalidSize || node->resolvedSize == false) {
		return true;
	}

	if (node->shrink > 0 ||
		node->expand > 0) {
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
			node->width.type == kDLLayoutSizeTypeFill) {
			return true;
		}
	}

	if (node->parent->measuredContentHeightUpdated || parentChanged) {
		if (node->height.unit == kDLLayoutSizeUnitPC ||
			node->height.type == kDLLayoutSizeTypeFill) {
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
DLRelativeLayoutNodeInvalidPosition(DLLayoutNodeRef node)
{
	return true;
}

inline double
DLRelativeLayoutNodeMeasureWidth(DLLayoutNodeRef node, double remaining)
{
	const DLLayoutSizeType type = node->width.type;
	const DLLayoutSizeUnit unit = node->width.unit;

	double value = node->width.length;

	if (type == kDLLayoutSizeTypeFill) {

		value = remaining - node->measuredMarginLeft - node->measuredMarginRight;

	} else if (type == kDLLayoutSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kDLLayoutSizeTypeLength) {

		switch (unit) {
			case kDLLayoutSizeUnitPC: DL_REL(value, node->parent->measuredContentWidth - node->parent->measuredPaddingLeft - node->parent->measuredPaddingRight); break;
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

	return value;
}

inline double
DLRelativeLayoutNodeMeasureHeight(DLLayoutNodeRef node, double remaining)
{
	const DLLayoutSizeType type = node->height.type;
	const DLLayoutSizeUnit unit = node->height.unit;

	double value = node->height.length;

	if (type == kDLLayoutSizeTypeFill) {

		value = remaining - node->measuredMarginTop - node->measuredMarginBottom;

	} else if (type == kDLLayoutSizeTypeWrap) {

		cerr << "The routine that handles measuring for this node does not handle the wrap value properly";
		abort();

	} else if (type == kDLLayoutSizeTypeLength) {

		switch (unit) {
			case kDLLayoutSizeUnitPC: DL_REL(value, node->parent->measuredContentHeight - node->parent->measuredPaddingTop - node->parent->measuredPaddingBottom); break;
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

	return value;
}

inline double
DLRelativeLayoutNodeResolveArrangement(DLLayoutNodeRef node, double remaining)
{
	double size = 0;
	double headOffset = 0;
	double tailOffset = 0;

	switch (node->parent->contentOrientation) {

		case kDLLayoutContentOrientationVertical:
			size = node->measuredWidth;
			headOffset = node->measuredMarginLeft;
			tailOffset = node->measuredMarginRight;
			break;

		case kDLLayoutContentOrientationHorizontal:
			size = node->measuredHeight;
			headOffset = node->measuredMarginTop;
			tailOffset = node->measuredMarginBottom;
			break;
	}

	double offset = 0;

	switch (node->parent->contentArrangement) {

		case kDLLayoutContentArrangementStart:
			offset = headOffset;
			break;

		case kDLLayoutContentArrangementCenter:
			offset = DL_GET_MID_OFFSET(size, remaining) + headOffset - tailOffset;
			break;

		case kDLLayoutContentArrangementEnd:
			offset = DL_GET_END_OFFSET(size, remaining) - tailOffset;
			break;
	}

	return offset;
}

inline void
DLRelativeLayoutNodeRoundAndCarry(double scale, double &value, double &carry)
{
	const double number = value;
	value = value + carry;
	value = DL_ROUND(scale, value);
	carry = (number + carry) - value;
}

inline void
DLRelativeLayoutNodeMeasure(DLLayoutNodeRef node, double &remainingW, double &remainingH, double &remainder)
{
	const double scale = node->layout->scale;

	const bool wrapW = node->isWrappingWidth;
	const bool wrapH = node->isWrappingHeight;

	double measuredW = node->measuredWidth;
	double measuredH = node->measuredHeight;

	if (DLRelativeLayoutNodeInvalidSize(node)) {

		if (wrapW == false) measuredW = DLRelativeLayoutNodeMeasureWidth(node, remainingW);
		if (wrapH == false) measuredH = DLRelativeLayoutNodeMeasureHeight(node, remainingH);

		switch (node->contentOrientation) {

			case kDLLayoutContentOrientationVertical:
				if (wrapW == false) measuredW = DL_ROUND(scale, measuredW);
				if (wrapH == false) DLRelativeLayoutNodeRoundAndCarry(scale, measuredH, remainder);
				break;

			case kDLLayoutContentOrientationHorizontal:
				if (wrapW == false) DLRelativeLayoutNodeRoundAndCarry(scale, measuredW, remainder);
				if (wrapH == false) measuredH = DL_ROUND(scale, measuredH);
				break;
		}

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

		if ((wrapW || wrapH) &&
			node->shrink == 0 &&
			node->expand == 0) {
			DLLayoutNodeLayoutWrappedLayout(node);
		}
	}
}

inline void
DLRelativeLayoutExpandNodesVertically(const vector<DLLayoutNodeRef> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		double measuredH = child->measuredHeight + (child->expand / weights * space);

		DLRelativeLayoutNodeRoundAndCarry(child->layout->scale, measuredH, remainder);

		if (child->measuredHeight != measuredH) {
			child->measuredHeight = measuredH;
			child->measuredHeightUpdated = true;

			DL_LAYOUT_NODE_INVOKE(child, resolveSizeCallback)

			if (child->isWrappingWidth ||
				child->isWrappingHeight) {
				DLLayoutNodeLayoutWrappedLayout(child);
			}
		}
	}
}

inline void
DLRelativeLayoutExpandNodesHorizontally(const vector<DLLayoutNodeRef> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		double measuredW = child->measuredWidth + (child->expand / weights * space);

		DLRelativeLayoutNodeRoundAndCarry(child->layout->scale, measuredW, remainder);

		if (child->measuredWidth != measuredW) {
			child->measuredWidth = measuredW;
			child->measuredWidthUpdated = true;

			DL_LAYOUT_NODE_INVOKE(child, resolveSizeCallback)

			if (child->isWrappingWidth ||
				child->isWrappingHeight) {
				DLLayoutNodeLayoutWrappedLayout(child);
			}
		}
	}
}

inline void
DLRelativeLayoutShrinkNodesVertically(const vector<DLLayoutNodeRef> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		double measuredH = child->measuredHeight + (child->shrink / weights * space);

		DLRelativeLayoutNodeRoundAndCarry(child->layout->scale, measuredH, remainder);

		if (child->measuredHeight != measuredH) {
			child->measuredHeight = measuredH;
			child->measuredHeightUpdated = true;

			DL_LAYOUT_NODE_INVOKE(child, resolveSizeCallback)

			if (child->isWrappingWidth ||
				child->isWrappingHeight) {
				DLLayoutNodeLayoutWrappedLayout(child);
			}
		}
	}
}

inline void
DLRelativeLayoutShrinkNodesHorizontally(const vector<DLLayoutNodeRef> &nodes, double space, double weights)
{
	double remainder = 0;

	for (auto &child : nodes) {

		double measuredW = child->measuredWidth + (child->shrink / weights * space);

		DLRelativeLayoutNodeRoundAndCarry(child->layout->scale, measuredW, remainder);

		if (child->measuredWidth != measuredW) {
			child->measuredWidth = measuredW;
			child->measuredWidthUpdated = true;

			DL_LAYOUT_NODE_INVOKE(child, resolveSizeCallback)

			if (child->isWrappingWidth ||
				child->isWrappingHeight) {
				DLLayoutNodeLayoutWrappedLayout(child);
			}
		}
	}
}

void
DLRelativeLayoutResolve(DLLayoutNodeRef node, const vector<DLLayoutNodeRef> &nodes)
{
	const double scale = node->layout->scale;

	const double paddingT = node->measuredPaddingTop;
	const double paddingL = node->measuredPaddingLeft;
	const double paddingR = node->measuredPaddingRight;
	const double paddingB = node->measuredPaddingBottom;

	const double contentW = max(node->measuredContentWidth - paddingL - paddingR, 0.0);
	const double contentH = max(node->measuredContentHeight - paddingT - paddingB, 0.0);
	const double contentT = node->measuredContentTop + paddingT;
	const double contentL = node->measuredContentLeft + paddingL;

	double remainder = 0;
	double remainingW = contentW;
	double remainingH = contentH;

	double expandablesWeight = 0;
	double shrinkablesWeight = 0;
	vector<DLLayoutNodeRef> shrinkables;
	vector<DLLayoutNodeRef> expandables;

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
			DLRelativeLayoutNodeMeasure(child, remainingW, remainingH, remainder);
		}

		switch (node->contentOrientation) {

			case kDLLayoutContentOrientationVertical:
				remainingH -= child->measuredHeight;
				remainingH -= child->measuredMarginTop;
				remainingH -= child->measuredMarginBottom;
				break;

			case kDLLayoutContentOrientationHorizontal:
				remainingW -= child->measuredWidth;
				remainingW -= child->measuredMarginLeft;
				remainingW -= child->measuredMarginRight;
				break;
		}

		if (child->shrink > 0) {
			shrinkables.push_back(child);
			shrinkablesWeight += child->shrink;
		}

		if (child->expand > 0) {
			expandables.push_back(child);
			expandablesWeight += child->expand;
		}
	}

	const bool wrapW = node->width.type == kDLLayoutSizeTypeWrap;
	const bool wrapH = node->height.type == kDLLayoutSizeTypeWrap;

	if (wrapW) remainingW = max(remainingW, 0.0);
	if (wrapH) remainingH = max(remainingH, 0.0);

	double dispositionSpace = 0;
	double arrangementSpace = 0;

	switch (node->contentOrientation) {

		case kDLLayoutContentOrientationVertical:
			dispositionSpace = remainingH;
			arrangementSpace = remainingW;
			break;

		case kDLLayoutContentOrientationHorizontal:
			dispositionSpace = remainingW;
			arrangementSpace = remainingH;
			break;
	}

	if (dispositionSpace > 0) {

		// TODO
		// Clamp min max

		if (expandables.size()) {

			switch (node->contentOrientation) {

				case kDLLayoutContentOrientationVertical:
					DLRelativeLayoutExpandNodesVertically(expandables, remainingH, expandablesWeight);
					break;

				case kDLLayoutContentOrientationHorizontal:
					DLRelativeLayoutExpandNodesHorizontally(expandables, remainingW, expandablesWeight);
					break;
			}

			dispositionSpace = 0;
		}

	} else if (dispositionSpace < 0) {

		// TODO
		// Clamp min max

		if (shrinkables.size()) {

			switch (node->contentOrientation) {

				case kDLLayoutContentOrientationVertical:
					DLRelativeLayoutShrinkNodesVertically(shrinkables, remainingH, shrinkablesWeight);
					break;

				case kDLLayoutContentOrientationHorizontal:
					DLRelativeLayoutShrinkNodesHorizontally(shrinkables, remainingW, shrinkablesWeight);
					break;
			}

			dispositionSpace = 0;
		}
	}

	double offset = 0;
	double spacer = 0;

	switch (node->contentDisposition) {

		case kDLLayoutContentDispositionStart:
			offset = 0;
			break;

		case kDLLayoutContentDispositionEnd:
			offset = dispositionSpace;
			break;

		case kDLLayoutContentDispositionCenter:
			offset = dispositionSpace / 2;
			break;

		case kDLLayoutContentDispositionSpaceBetween:
			spacer = dispositionSpace / (nodes.size() - 1);
			offset = 0;
			break;

		case kDLLayoutContentDispositionSpaceEvenly:
			spacer = dispositionSpace / (nodes.size() + 1);
			offset = spacer;
			break;

		case kDLLayoutContentDispositionSpaceAround:
			spacer = dispositionSpace / (nodes.size() + 1);
			offset = spacer / 2;
			break;
	}

	for (int i = 0; i < nodes.size(); i++) {

		const DLLayoutNodeRef child = nodes[i];

		const double marginT = child->measuredMarginTop;
		const double marginL = child->measuredMarginLeft;
		const double marginR = child->measuredMarginRight;
		const double marginB = child->measuredMarginBottom;

		const double w = child->measuredWidth;
		const double h = child->measuredHeight;

		double x = contentL;
		double y = contentT;

		switch (node->contentOrientation) {

			case kDLLayoutContentOrientationVertical:

				x = DL_ROUND(scale, x + DLRelativeLayoutNodeResolveArrangement(child, arrangementSpace));
				y = DL_ROUND(scale, y + offset + marginT);

				offset = offset + h + marginT + marginB + spacer;

				break;

			case kDLLayoutContentOrientationHorizontal:

				x = DL_ROUND(scale, x + offset + marginL);
				y = DL_ROUND(scale, y + DLRelativeLayoutNodeResolveArrangement(child, arrangementSpace));

				offset = offset + w + marginL + marginR + spacer;

				break;
		}

		const double anchorTop = DLLayoutNodeMeasureAnchorTop(child);
		const double anchorLeft = DLLayoutNodeMeasureAnchorLeft(child);

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

			DL_LAYOUT_NODE_INVOKE(child, resolvePositionCallback)
		}

		node->extentTop = min(node->extentTop, child->measuredTop + child->measuredMarginTop);
		node->extentLeft = min(node->extentLeft, child->measuredLeft + child->measuredMarginBottom);
		node->extentRight = max(node->extentRight, child->measuredLeft + child->measuredWidth + child->measuredMarginRight);
		node->extentBottom = max(node->extentBottom, child->measuredTop + child->measuredHeight + child->measuredMarginBottom);

		child->resolvedSize = true;
		child->resolvedPosition = true;
		child->resolvedParent = node;

		child->resolving = false;
		child->invalidSize = false;
		child->invalidPosition = false;

		// TODO IFDEF TEST
		child->resolvePositionCount++;
	}

	node->extentRight += paddingR;
	node->extentBottom += paddingB;
}
