#include "Display.h"
#include "DisplayNode.h"
#include "DisplayNodeFrame.h"
#include "Layout.h"

#include <iostream>
#include <vector>

namespace View {

using std::vector;
using std::cout;
using std::cerr;
using std::min;
using std::max;

DisplayNodeFrame::DisplayNodeFrame(DisplayNode* node) : layout(node)
{
	this->node = node;
}

DisplayNodeFrame::~DisplayNodeFrame()
{

}

void
DisplayNodeFrame::setAnchorTop(DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length)
{
	if (this->anchorTop.equals(type, unit, length)) {
		return;
	}

	this->anchorTop.type = type;
	this->anchorTop.unit = unit;
	this->anchorTop.length = length;

	this->invalidateOrigin();
}

void
DisplayNodeFrame::setAnchorLeft(DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length)
{
	if (this->anchorLeft.equals(type, unit, length)) {
		return;
	}

	this->anchorLeft.type = type;
	this->anchorLeft.unit = unit;
	this->anchorLeft.length = length;

	this->invalidateOrigin();
}

void
DisplayNodeFrame::setTop(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
{
	if (this->top.equals(type, unit, length)) {
		return;
	}

	this->top.type = type;
	this->top.unit = unit;
	this->top.length = length;

	this->invalidateOrigin();
}

void
DisplayNodeFrame::setMinTop(double min)
{
	if (this->top.min != min) {
		this->top.min = min;
		this->invalidateOrigin();
	}
}

void
DisplayNodeFrame::setMaxTop(double max)
{
	if (this->top.max != max) {
		this->top.max = max;
		this->invalidateOrigin();
	}
}

void
DisplayNodeFrame::setLeft(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
{
	if (this->left.equals(type, unit, length)) {
		return;
	}

	this->left.type = type;
	this->left.unit = unit;
	this->left.length = length;

	this->invalidateOrigin();
}

void
DisplayNodeFrame::setMinLeft(double min)
{
	if (this->left.min != min) {
		this->left.min = min;
		this->invalidateOrigin();
	}
}

void
DisplayNodeFrame::setMaxLeft(double max)
{
	if (this->left.max != max) {
		this->left.max = max;
		this->invalidateOrigin();
	}
}

void
DisplayNodeFrame::setRight(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
{
	if (this->right.equals(type, unit, length)) {
		return;
	}

	this->right.type = type;
	this->right.unit = unit;
	this->right.length = length;

	this->invalidateOrigin();
}

void
DisplayNodeFrame::setMinRight(double min)
{
	if (this->right.min != min) {
		this->right.min = min;
		this->invalidateOrigin();
	}
}

void
DisplayNodeFrame::setMaxRight(double max)
{
	if (this->right.max != max) {
		this->right.max = max;
		this->invalidateOrigin();
	}
}

void
DisplayNodeFrame::setBottom(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
{
	if (this->bottom.equals(type, unit, length)) {
		return;
	}

	this->bottom.type = type;
	this->bottom.unit = unit;
	this->bottom.length = length;

	this->invalidateOrigin();
}

void
DisplayNodeFrame::setMinBottom(double min)
{
	if (this->bottom.min != min) {
		this->bottom.min = min;
		this->invalidateOrigin();
	}
}

void
DisplayNodeFrame::setMaxBottom(double max)
{
	if (this->bottom.max != max) {
		this->bottom.max = max;
		this->invalidateOrigin();
	}
}

void
DisplayNodeFrame::setWidth(DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->width.equals(type, unit, length)) {
		return;
	}

	this->width.type = type;
	this->width.unit = unit;
	this->width.length = length;

	this->invalidateSize();
}

void
DisplayNodeFrame::setMinWidth(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->width.min != min) {
		this->width.min = min;
		this->invalidateSize();
	}
}

void
DisplayNodeFrame::setMaxWidth(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->width.max != max) {
		this->width.max = max;
		this->invalidateSize();
	}
}

void
DisplayNodeFrame::setHeight(DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->height.equals(type, unit, length)) {
		return;
	}

	this->height.type = type;
	this->height.unit = unit;
	this->height.length = length;

	this->invalidateSize();
}

void
DisplayNodeFrame::setMinHeight(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->height.min != min) {
		this->height.min = min;
		this->invalidateSize();
	}
}

void
DisplayNodeFrame::setMaxHeight(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->height.max != max) {
		this->height.max = max;
		this->invalidateSize();
	}
}

void
DisplayNodeFrame::setContentDirection(DisplayNodeContentDirection direction)
{
	if (this->contentDirection != direction) {
		this->contentDirection = direction;
		this->invalidateLayout();
	}
}

void
DisplayNodeFrame::setContentAlignment(DisplayNodeContentAlignment alignment)
{
	if (this->contentAlignment != alignment) {
		this->contentAlignment = alignment;
		this->invalidateLayout();
	}
}

void
DisplayNodeFrame::setContentLocation(DisplayNodeContentLocation location)
{
	if (this->contentLocation != location) {
		this->contentLocation = location;
		this->invalidateLayout();
	}
}

void
DisplayNodeFrame::setContentTop(DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length)
{
    length = clamp(length, ABS_DBL_MIN, ABS_DBL_MAX);

	if (this->contentTop.equals(type, unit, length)) {
		return;
	}

	this->contentTop.type = type;
	this->contentTop.unit = unit;
	this->contentTop.length = length;
	this->measuredContentTop = length; // This is temporary until units other than pixels are available.

	this->invalidateLayout();
}

void
DisplayNodeFrame::setContentLeft(DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length)
{
    length = clamp(length, ABS_DBL_MIN, ABS_DBL_MAX);

	if (this->contentLeft.equals(type, unit, length)) {
		return;
	}

	this->contentLeft.type = type;
	this->contentLeft.unit = unit;
	this->contentLeft.length = length;
	this->measuredContentLeft = length; // This is temporary until units other than pixels are available.

	this->invalidateLayout();
}

void
DisplayNodeFrame::setContentWidth(DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->contentWidth.equals(type, unit, length)) {
		return;
	}

	this->contentWidth.type = type;
	this->contentWidth.unit = unit;
	this->contentWidth.length = length;

	this->invalidateContentSize();
}

void
DisplayNodeFrame::setContentHeight(DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->contentHeight.equals(type, unit, length)) {
		return;
	}

	this->contentHeight.type = type;
	this->contentHeight.unit = unit;
	this->contentHeight.length = length;

	this->invalidateContentSize();
}

void
DisplayNodeFrame::setExpandFactor(double factor)
{
	if (this->expandFactor != factor) {
		this->expandFactor = factor;
		this->invalidateSize();
	}
}

void
DisplayNodeFrame::setShrinkFactor(double factor)
{
	if (this->shrinkFactor != factor) {
		this->shrinkFactor = factor;
		this->invalidateSize();
	}
}

void
DisplayNodeFrame::setBorderTop(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->borderTop.equals(type, unit, length)) {
		return;
	}

	this->borderTop.type = type;
    this->borderTop.unit = unit;
    this->borderTop.length = length;

    this->invalidateBorder();
}

void
DisplayNodeFrame::setBorderLeft(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->borderLeft.equals(type, unit, length)) {
		return;
	}

	this->borderLeft.type = type;
    this->borderLeft.unit = unit;
    this->borderLeft.length = length;

    this->invalidateBorder();
}

void
DisplayNodeFrame::setBorderRight(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->borderRight.equals(type, unit, length)) {
		return;
	}

	this->borderRight.type = type;
	this->borderRight.unit = unit;
	this->borderRight.length = length;

    this->invalidateBorder();
}

void
DisplayNodeFrame::setBorderBottom(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->borderBottom.equals(type, unit, length)) {
		return;
	}

	this->borderBottom.type = type;
    this->borderBottom.unit = unit;
    this->borderBottom.length = length;

    this->invalidateBorder();
}

void
DisplayNodeFrame::setMarginTop(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
{
	if (this->marginTop.equals(type, unit, length)) {
		return;
	}

	this->marginTop.type = type;
	this->marginTop.unit = unit;
	this->marginTop.length = length;

	this->invalidateMargin();
}

void
DisplayNodeFrame::setMarginLeft(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
{
	if (this->marginLeft.equals(type, unit, length)) {
		return;
	}

	this->marginLeft.type = type;
	this->marginLeft.unit = unit;
	this->marginLeft.length = length;

	this->invalidateMargin();
}

void
DisplayNodeFrame::setMarginRight(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
{
	if (this->marginRight.equals(type, unit, length)) {
		return;
	}

	this->marginRight.type = type;
	this->marginRight.unit = unit;
	this->marginRight.length = length;

	this->invalidateMargin();
}

void
DisplayNodeFrame::setMarginBottom(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
{
	if (this->marginBottom.equals(type, unit, length)) {
		return;
	}

	this->marginBottom.type = type;
	this->marginBottom.unit = unit;
	this->marginBottom.length = length;

	this->invalidateMargin();
}

void
DisplayNodeFrame::setMinMarginTop(double min)
{
	if (this->marginTop.min != min) {
		this->marginTop.min = min;
		this->invalidateMargin();
	}
}

void
DisplayNodeFrame::setMaxMarginTop(double max)
{
	if (this->marginTop.max != max) {
		this->marginTop.max = max;
		this->invalidateMargin();
	}
}

void
DisplayNodeFrame::setMinMarginLeft(double min)
{
	if (this->marginLeft.min != min) {
		this->marginLeft.min = min;
		this->invalidateMargin();
	}
}

void
DisplayNodeFrame::setMaxMarginLeft(double max)
{
	if (this->marginLeft.max != max) {
		this->marginLeft.max = max;
		this->invalidateMargin();
	}
}

void
DisplayNodeFrame::setMinMarginRight(double min)
{
	if (this->marginRight.min != min) {
		this->marginRight.min = min;
		this->invalidateMargin();
	}
}

void
DisplayNodeFrame::setMaxMarginRight(double max)
{
	if (this->marginRight.max != max) {
		this->marginRight.max = max;
		this->invalidateMargin();
	}
}

void
DisplayNodeFrame::setMinMarginBottom(double min)
{
	if (this->marginBottom.min != min) {
		this->marginBottom.min = min;
		this->invalidateMargin();
	}
}

void
DisplayNodeFrame::setMaxMarginBottom(double max)
{
	if (this->marginBottom.max != max) {
		this->marginBottom.max = max;
		this->invalidateMargin();
	}
}

void
DisplayNodeFrame::setPaddingTop(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->paddingTop.equals(type, unit, length)) {
		return;
	}

	this->paddingTop.type = type;
	this->paddingTop.unit = unit;
	this->paddingTop.length = length;

	this->invalidatePadding();
}

void
DisplayNodeFrame::setPaddingLeft(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->paddingLeft.equals(type, unit, length)) {
		return;
	}

	this->paddingLeft.type = type;
	this->paddingLeft.unit = unit;
	this->paddingLeft.length = length;

	this->invalidatePadding();
}

void
DisplayNodeFrame::setPaddingRight(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->paddingRight.equals(type, unit, length)) {
		return;
	}

	this->paddingRight.type = type;
	this->paddingRight.unit = unit;
	this->paddingRight.length = length;

	this->invalidatePadding();
}

void
DisplayNodeFrame::setPaddingBottom(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->paddingBottom.equals(type, unit, length)) {
		return;
	}

	this->paddingBottom.type = type;
	this->paddingBottom.unit = unit;
	this->paddingBottom.length = length;

	this->invalidatePadding();
}

void
DisplayNodeFrame::setMinPaddingTop(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->paddingTop.min != min) {
		this->paddingTop.min = min;
		this->invalidatePadding();
	}
}

void
DisplayNodeFrame::setMaxPaddingTop(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->paddingTop.max != max) {
		this->paddingTop.max = max;
		this->invalidatePadding();
	}
}

void
DisplayNodeFrame::setMinPaddingLeft(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->paddingLeft.min != min) {
		this->paddingLeft.min = min;
		this->invalidatePadding();
	}
}

void
DisplayNodeFrame::setMaxPaddingLeft(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->paddingLeft.max != max) {
		this->paddingLeft.max = max;
		this->invalidatePadding();
	}
}

void
DisplayNodeFrame::setMinPaddingRight(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->paddingRight.min != min) {
		this->paddingRight.min = min;
		this->invalidatePadding();
	}
}

void
DisplayNodeFrame::setMaxPaddingRight(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->paddingRight.max != max) {
		this->paddingRight.max = max;
		this->invalidatePadding();
	}
}

void
DisplayNodeFrame::setMinPaddingBottom(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->paddingBottom.min != min) {
		this->paddingBottom.min = min;
		this->invalidatePadding();
	}
}

void
DisplayNodeFrame::setMaxPaddingBottom(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->paddingBottom.max != max) {
		this->paddingBottom.max = max;
		this->invalidatePadding();
	}
}

void
DisplayNodeFrame::setVisible(bool visible)
{
	if (this->visible != visible) {
		this->visible = visible;
		this->invalidateParent();
	}
}

bool
DisplayNodeFrame::hasInvalidSize()
{
	return this->invalidSize;
}

bool
DisplayNodeFrame::hasInvalidOrigin()
{
	return this->invalidOrigin;
}

bool
DisplayNodeFrame::hasInvalidMargin()
{
	if (this->invalidMargin) {
		return true;
	}

	if (this->marginTop.unit == kDisplayNodeMarginUnitPX &&
		this->marginLeft.unit == kDisplayNodeMarginUnitPX &&
		this->marginRight.unit == kDisplayNodeMarginUnitPX &&
		this->marginBottom.unit == kDisplayNodeMarginUnitPX) {
		return false;
	}

	if (this->node->parent) {

		const auto parent = this->node->parent->frame;

		if (parent->measuredInnerWidthChanged) {
			if (this->marginLeft.unit == kDisplayNodeMarginUnitPC ||
				this->marginRight.unit == kDisplayNodeMarginUnitPC) {
				return true;
			}
		}

		if (parent->measuredInnerHeightChanged) {
			if (this->marginTop.unit == kDisplayNodeMarginUnitPC ||
				this->marginBottom.unit == kDisplayNodeMarginUnitPC) {
				return true;
			}
		}

		if (parent->measuredInnerWidthChanged) {
			if (this->marginTop.unit == kDisplayNodeMarginUnitPW ||
				this->marginLeft.unit == kDisplayNodeMarginUnitPW ||
				this->marginRight.unit == kDisplayNodeMarginUnitPW ||
				this->marginBottom.unit == kDisplayNodeMarginUnitPW) {
				return true;
			}
		}

		if (parent->measuredInnerHeightChanged) {
			if (this->marginTop.unit == kDisplayNodeMarginUnitPH ||
				this->marginLeft.unit == kDisplayNodeMarginUnitPH ||
				this->marginRight.unit == kDisplayNodeMarginUnitPH ||
				this->marginBottom.unit == kDisplayNodeMarginUnitPH) {
				return true;
			}
		}

		if (parent->measuredContentWidthChanged) {
			if (this->marginTop.unit == kDisplayNodeMarginUnitCW ||
				this->marginLeft.unit == kDisplayNodeMarginUnitCW ||
				this->marginRight.unit == kDisplayNodeMarginUnitCW ||
				this->marginBottom.unit == kDisplayNodeMarginUnitCW) {
				return true;
			}
		}

		if (parent->measuredContentHeightChanged) {
			if (this->marginTop.unit == kDisplayNodeMarginUnitCH ||
				this->marginLeft.unit == kDisplayNodeMarginUnitCH ||
				this->marginRight.unit == kDisplayNodeMarginUnitCH ||
				this->marginBottom.unit == kDisplayNodeMarginUnitCH) {
				return true;
			}
		}
	}

	if (this->node->display->hasViewportWidthChanged()) {
		if (this->marginTop.unit == kDisplayNodeMarginUnitVW ||
			this->marginLeft.unit == kDisplayNodeMarginUnitVW ||
			this->marginRight.unit == kDisplayNodeMarginUnitVW ||
			this->marginBottom.unit == kDisplayNodeMarginUnitVW) {
			return true;
		}
	}

	if (this->node->display->hasViewportHeightChanged()) {
		if (this->marginTop.unit == kDisplayNodeMarginUnitVH ||
			this->marginLeft.unit == kDisplayNodeMarginUnitVH ||
			this->marginRight.unit == kDisplayNodeMarginUnitVH ||
			this->marginBottom.unit == kDisplayNodeMarginUnitVH) {
			return true;
		}
	}

	return false;
}

bool
DisplayNodeFrame::hasInvalidBorder()
{
	if (this->invalidBorder) {
		return true;
	}

	if (this->borderTop.unit == kDisplayNodeBorderUnitPX &&
		this->borderLeft.unit == kDisplayNodeBorderUnitPX &&
		this->borderRight.unit == kDisplayNodeBorderUnitPX &&
		this->borderBottom.unit == kDisplayNodeBorderUnitPX) {
		return false;
	}

	if (this->measuredWidthChanged) {
		if (this->borderLeft.unit == kDisplayNodeBorderUnitPC ||
			this->borderRight.unit == kDisplayNodeBorderUnitPC) {
			return true;
		}
	}

	if (this->measuredHeightChanged) {
		if (this->borderTop.unit == kDisplayNodeBorderUnitPC ||
			this->borderBottom.unit == kDisplayNodeBorderUnitPC) {
			return true;
		}
	}

	if (this->node->parent) {

		const auto parent = this->node->parent->frame;

		if (parent->measuredInnerWidthChanged) {
			if (this->borderTop.unit == kDisplayNodeBorderUnitPW ||
				this->borderLeft.unit == kDisplayNodeBorderUnitPW ||
				this->borderRight.unit == kDisplayNodeBorderUnitPW ||
				this->borderBottom.unit == kDisplayNodeBorderUnitPW) {
				return true;
			}
		}

		if (parent->measuredInnerHeightChanged) {
			if (this->borderTop.unit == kDisplayNodeBorderUnitPH ||
				this->borderLeft.unit == kDisplayNodeBorderUnitPH ||
				this->borderRight.unit == kDisplayNodeBorderUnitPH ||
				this->borderBottom.unit == kDisplayNodeBorderUnitPH) {
				return true;
			}
		}

		if (parent->measuredContentWidthChanged) {
			if (this->borderTop.unit == kDisplayNodeBorderUnitCW ||
				this->borderLeft.unit == kDisplayNodeBorderUnitCW ||
				this->borderRight.unit == kDisplayNodeBorderUnitCW ||
				this->borderBottom.unit == kDisplayNodeBorderUnitCW) {
				return true;
			}
		}

		if (parent->measuredContentHeightChanged) {
			if (this->borderTop.unit == kDisplayNodeBorderUnitCH ||
				this->borderLeft.unit == kDisplayNodeBorderUnitCH ||
				this->borderRight.unit == kDisplayNodeBorderUnitCH ||
				this->borderBottom.unit == kDisplayNodeBorderUnitCH) {
				return true;
			}
		}
	}

	if (this->node->display->hasViewportWidthChanged()) {
		if (this->borderTop.unit == kDisplayNodeBorderUnitVW ||
			this->borderLeft.unit == kDisplayNodeBorderUnitVW ||
			this->borderRight.unit == kDisplayNodeBorderUnitVW ||
			this->borderBottom.unit == kDisplayNodeBorderUnitVW) {
			return true;
		}
	}

	if (this->node->display->hasViewportHeightChanged()) {
		if (this->borderTop.unit == kDisplayNodeBorderUnitVH ||
			this->borderLeft.unit == kDisplayNodeBorderUnitVW ||
			this->borderRight.unit == kDisplayNodeBorderUnitVW ||
			this->borderBottom.unit == kDisplayNodeBorderUnitVW) {
			return true;
		}
	}

	return false;
}

bool
DisplayNodeFrame::hasInvalidInnerSize()
{
	return this->invalidInnerSize;
}

bool
DisplayNodeFrame::hasInvalidContentSize()
{
	if (this->invalidContentSize) {
		return true;
	}

	if (this->contentWidth.type == kDisplayNodeContentSizeTypeAuto &&
		this->contentHeight.type == kDisplayNodeContentSizeTypeAuto) {
		return false;
	}

	if (this->contentWidth.unit == kDisplayNodeContentSizeUnitPX &&
		this->contentHeight.unit == kDisplayNodeContentSizeUnitPX) {
		return false;
	}

	if (this->measuredInnerWidthChanged &&
		this->contentWidth.unit == kDisplayNodeContentSizeUnitPC) {
		return true;
	}

	if (this->measuredInnerHeightChanged &&
		this->contentHeight.unit == kDisplayNodeContentSizeUnitPC) {
		return true;
	}

	if (this->node->parent == NULL) {

		const auto parent = this->node->parent->frame;

		if (parent->measuredInnerWidthChanged) {
			if (this->contentWidth.unit == kDisplayNodeContentSizeUnitPW ||
				this->contentHeight.unit == kDisplayNodeContentSizeUnitPW) {
				return true;
			}
		}

		if (parent->measuredInnerHeightChanged) {
			if (this->contentWidth.unit == kDisplayNodeContentSizeUnitPH ||
				this->contentHeight.unit == kDisplayNodeContentSizeUnitPH) {
				return true;
			}
		}

		if (parent->measuredContentWidthChanged) {
			if (this->contentWidth.unit == kDisplayNodeContentSizeUnitCW ||
				this->contentHeight.unit == kDisplayNodeContentSizeUnitCW) {
				return true;
			}
		}

		if (parent->measuredContentHeightChanged) {
			if (this->contentWidth.unit == kDisplayNodeContentSizeUnitCH ||
				this->contentHeight.unit == kDisplayNodeContentSizeUnitCH) {
				return true;
			}
		}
	}

	if (this->node->display->hasViewportWidthChanged()) {
		if (this->contentWidth.unit == kDisplayNodeContentSizeUnitVW ||
			this->contentHeight.unit == kDisplayNodeContentSizeUnitVW) {
			return true;
		}
	}

	if (this->node->display->hasViewportHeightChanged()) {
		if (this->contentWidth.unit == kDisplayNodeContentSizeUnitVH ||
			this->contentHeight.unit == kDisplayNodeContentSizeUnitVH) {
			return true;
		}
	}

	return false;
}

bool
DisplayNodeFrame::hasInvalidPadding()
{
	if (this->invalidPadding) {
		return true;
	}

	if (this->paddingTop.unit == kDisplayNodePaddingUnitPX &&
		this->paddingLeft.unit == kDisplayNodePaddingUnitPX &&
		this->paddingRight.unit == kDisplayNodePaddingUnitPX &&
		this->paddingBottom.unit == kDisplayNodePaddingUnitPX) {
		return false;
	}

	if (this->measuredInnerWidthChanged) {
		if (this->paddingLeft.unit == kDisplayNodePaddingUnitPC ||
			this->paddingRight.unit == kDisplayNodePaddingUnitPC) {
			return true;
		}
	}

	if (this->measuredInnerHeightChanged) {
		if (this->paddingTop.unit == kDisplayNodePaddingUnitPC ||
			this->paddingBottom.unit == kDisplayNodePaddingUnitPC) {
			return true;
		}
	}

	if (this->node->parent) {

		const auto parent = this->node->parent->frame;

		if (parent->measuredInnerWidthChanged) {
			if (this->paddingTop.unit == kDisplayNodePaddingUnitPW ||
				this->paddingLeft.unit == kDisplayNodePaddingUnitPW ||
				this->paddingRight.unit == kDisplayNodePaddingUnitPW ||
				this->paddingBottom.unit == kDisplayNodePaddingUnitPW) {
				return true;
			}
		}

		if (parent->measuredInnerHeightChanged) {
			if (this->paddingTop.unit == kDisplayNodePaddingUnitPH ||
				this->paddingLeft.unit == kDisplayNodePaddingUnitPH ||
				this->paddingRight.unit == kDisplayNodePaddingUnitPH ||
				this->paddingBottom.unit == kDisplayNodePaddingUnitPH) {
				return true;
			}
		}

		if (parent->measuredContentWidthChanged) {
			if (this->paddingTop.unit == kDisplayNodePaddingUnitCW ||
				this->paddingLeft.unit == kDisplayNodePaddingUnitCW ||
				this->paddingRight.unit == kDisplayNodePaddingUnitCW ||
				this->paddingBottom.unit == kDisplayNodePaddingUnitCW) {
				return true;
			}
		}

		if (parent->measuredContentHeightChanged) {
			if (this->paddingTop.unit == kDisplayNodePaddingUnitCH ||
				this->paddingLeft.unit == kDisplayNodePaddingUnitCH ||
				this->paddingRight.unit == kDisplayNodePaddingUnitCH ||
				this->paddingBottom.unit == kDisplayNodePaddingUnitCH) {
				return true;
			}
		}
	}

	if (this->node->display->hasViewportWidthChanged()) {
		if (this->paddingTop.unit == kDisplayNodePaddingUnitVW ||
			this->paddingLeft.unit == kDisplayNodePaddingUnitVW ||
			this->paddingRight.unit == kDisplayNodePaddingUnitVW ||
			this->paddingBottom.unit == kDisplayNodePaddingUnitVW) {
			return true;
		}
	}

	if (this->node->display->hasViewportHeightChanged()) {
		if (this->paddingTop.unit == kDisplayNodePaddingUnitVH ||
			this->paddingLeft.unit == kDisplayNodePaddingUnitVH ||
			this->paddingRight.unit == kDisplayNodePaddingUnitVH ||
			this->paddingBottom.unit == kDisplayNodePaddingUnitVH) {
			return true;
		}
	}

	return false;
}

bool
DisplayNodeFrame::hasInvalidLayout()
{
	return this->invalidLayout;
}

bool
DisplayNodeFrame::shouldWrapContentWidth()
{
	if (this->node->type == kDisplayNodeTypeWindow) {
		return false;
	}

	const auto l = this->left.type;
	const auto r = this->right.type;
	const auto w = this->width.type;

	if (l == kDisplayNodeOriginTypeLength &&
		r == kDisplayNodeOriginTypeLength) {
		return false;
	}

	if (w == kDisplayNodeSizeTypeWrap) {
		return true;
	}

	if (w == kDisplayNodeSizeTypeFill) {

		auto node = this->node->parent;

		while (node) {

			if (node->frame->width.type == kDisplayNodeSizeTypeFill) {
				node = node->parent;
				continue;
			}

			if (node->frame->width.type == kDisplayNodeSizeTypeWrap) {
				return true;
			}

			return false;
		}
	}

	return false;
}

bool
DisplayNodeFrame::shouldWrapContentHeight()
{
	if (this->node->type == kDisplayNodeTypeWindow) {
		return false;
	}

	const auto t = this->top.type;
	const auto b = this->bottom.type;
	const auto h = this->height.type;

	if (t == kDisplayNodeOriginTypeLength &&
		b == kDisplayNodeOriginTypeLength) {
		return false;
	}

	if (h == kDisplayNodeSizeTypeWrap) {
		return true;
	}

	if (h == kDisplayNodeSizeTypeFill) {

		auto node = this->node->parent;

		while (node) {

			if (node->frame->height.type == kDisplayNodeSizeTypeFill) {
				node = node->parent;
				continue;
			}

			if (node->frame->height.type == kDisplayNodeSizeTypeWrap) {
				return true;
			}

			return false;
		}
	}

	return false;
}

bool
DisplayNodeFrame::isFillingParentWidth()
{
	return this->width.type == kDisplayNodeSizeTypeFill;
}

bool
DisplayNodeFrame::isFillingParentHeight()
{
	return this->height.type == kDisplayNodeSizeTypeFill;
}

bool
DisplayNodeFrame::isWrappingContentWidth()
{
	return this->width.type == kDisplayNodeSizeTypeWrap;
}

bool
DisplayNodeFrame::isWrappingContentHeight()
{
	return this->height.type == kDisplayNodeSizeTypeWrap;
}

void
DisplayNodeFrame::invalidate()
{
	this->node->invalidateFrame();
}

void
DisplayNodeFrame::invalidateSize()
{
	if (this->invalidSize) {
		return;
	}

	this->invalidSize = true;

	if (this->node->type == kDisplayNodeTypeWindow) {
		this->invalidateLayout();
		return;
	}

	this->invalidateParent();
}

void
DisplayNodeFrame::invalidateOrigin()
{
	if (this->invalidOrigin == false) {
		this->invalidOrigin = true;
		this->invalidateParent();
	}
}

void
DisplayNodeFrame::invalidateInnerSize()
{
	if (this->invalidInnerSize == false) {
		this->invalidInnerSize = true;
		this->invalidate();
	}
}

void
DisplayNodeFrame::invalidateContentSize()
{
	if (this->invalidContentSize == false) {
		this->invalidContentSize = true;
		this->invalidate();
	}
}

void
DisplayNodeFrame::invalidateContentOrigin()
{
	if (this->invalidContentOrigin == false) {
		this->invalidContentOrigin = true;
		this->invalidate();
	}
}

void
DisplayNodeFrame::invalidateMargin()
{
	if (this->invalidMargin == false) {
		this->invalidMargin = true;
		this->invalidate();
	}
}

void
DisplayNodeFrame::invalidateBorder()
{
	if (this->invalidBorder == false) {
		this->invalidBorder = true;
		this->invalidate();
	}
}

void
DisplayNodeFrame::invalidatePadding()
{
	if (this->invalidPadding == false) {
		this->invalidPadding = true;
		this->invalidate();
	}
}

void
DisplayNodeFrame::invalidateLayout()
{
	if (this->invalidLayout == false) {
		this->invalidLayout = true;
		this->invalidate();
	}
}

void
DisplayNodeFrame::invalidateParent()
{
	auto parent = this->node->parent;

	if (parent == NULL ||
		parent->frame->invalidLayout) {
		return;
	}

	parent->frame->invalidateLayout();

	/*
	 * This view might be within a wrapped view which itself can be inside another
	 * wrapper view. We need to find the highest parent of a wrap chain and invalidate
	 * this one.
	 */

	const auto parentW = parent->frame->width;
	const auto parentH = parent->frame->height;

	if (parentW.type == kDisplayNodeSizeTypeWrap ||
		parentH.type == kDisplayNodeSizeTypeWrap) {

		parent->frame->invalidateSize();
		parent->frame->invalidateOrigin();

		vector<DisplayNode*> path;
		DisplayNode* last = NULL;
		DisplayNode* node = parent;

		while (node != NULL) {

			node = node->parent;

			if (node) {

				const auto w = node->frame->width;
				const auto h = node->frame->height;

				if (w.type != kDisplayNodeSizeTypeWrap && h.type != kDisplayNodeSizeTypeWrap &&
					w.type != kDisplayNodeSizeTypeFill && h.type != kDisplayNodeSizeTypeFill) {
					break;
				}

				node->frame->invalidateSize();
				node->frame->invalidateOrigin();
				node->frame->invalidateLayout();

				if (w.type == kDisplayNodeSizeTypeWrap ||
					h.type == kDisplayNodeSizeTypeWrap) {
					last = node;
				}
			}
		}

		if (last &&
			last->parent) {
			last->parent->frame->invalidateLayout();
		}
	}
}

void
DisplayNodeFrame::resolve()
{
	/*
	 * Resolving a node means computing its border, padding inner size,
	 * content size and layout. At the moment this method is called the
	 * node has been given a measured size and an origin by its parent.
	 */

	if (this->resolving) {
		return;
	}

	this->resolving = true;

	this->measuredInnerWidthChanged = false;
	this->measuredInnerHeightChanged = false;
	this->measuredContentWidthChanged = false;
	this->measuredContentHeightChanged = false;

	if (this->node->type == kDisplayNodeTypeWindow) {

		this->measuredWidthChanged = false;
		this->measuredHeightChanged = false;

		/*
		 * This is the root node, simply apply its width and height
		 * and call it a day.
		 */

		if (this->width.type != kDisplayNodeSizeTypeLength ||
			this->width.unit != kDisplayNodeSizeUnitPX) {
			cerr << "The root node size must be specified in pixels.";
			abort();
		}

		if (this->height.type != kDisplayNodeSizeTypeLength ||
			this->height.unit != kDisplayNodeSizeUnitPX) {
			cerr << "The root node size must be specified in pixels.";
			abort();
		}

		if (this->invalidSize) {

			const auto measuredW = this->width.length;
			const auto measuredH = this->height.length;

			if (this->measuredWidth != measuredW) {
				this->measuredWidth = measuredW;
				this->measuredWidthChanged = true;
				this->invalidateInnerSize();
			}

			if (this->measuredHeight != measuredH) {
				this->measuredHeight = measuredH;
				this->measuredHeightChanged = true;
				this->invalidateInnerSize();
			}

			if (this->measuredWidthChanged ||
				this->measuredHeightChanged) {
				this->node->didResolveSize();
			}

			this->invalidSize = false;
		}
	}

	this->resolveBorder();
	this->resolveInnerSize();
	this->resolveContentSize();
	this->resolvePadding();
	this->resolveLayout();

	this->resolving = false;
}

void
DisplayNodeFrame::resolveLayout()
{
	if (this->invalidLayout == false) {
		return;
	}

	if (this->node->children.size() > 0) {
		this->node->layoutBegan();
		this->layout.resolve();
		this->node->layoutEnded();
	}

	this->invalidLayout = false;
}

void
DisplayNodeFrame::resolveMargin()
{
	if (this->hasInvalidMargin() == false) {
		return;
	}

	const auto marginT = this->measureMarginTop();
	const auto marginL = this->measureMarginLeft();
	const auto marginR = this->measureMarginRight();
	const auto marginB = this->measureMarginBottom();

	if (marginT != this->measuredMarginTop ||
		marginL != this->measuredMarginLeft ||
		marginR != this->measuredMarginRight ||
		marginB != this->measuredMarginBottom) {

		this->measuredMarginTop = marginT;
		this->measuredMarginLeft = marginL;
		this->measuredMarginRight = marginR;
		this->measuredMarginBottom = marginB;

		this->invalidateOrigin();

		this->node->didResolveMargin();
	}

	this->invalidMargin = false;
}

void
DisplayNodeFrame::resolveBorder()
{
	if (this->hasInvalidBorder() == false) {
		return;
	}

	const auto borderT = this->measureBorderTop();
	const auto borderL = this->measureBorderLeft();
	const auto borderR = this->measureBorderRight();
	const auto borderB = this->measureBorderBottom();

	if (borderT != this->measuredBorderTop ||
		borderL != this->measuredBorderLeft ||
		borderR != this->measuredBorderRight ||
		borderB != this->measuredBorderBottom) {

		this->measuredBorderTop = borderT;
		this->measuredBorderLeft = borderL;
		this->measuredBorderRight = borderR;
		this->measuredBorderBottom = borderB;

		this->invalidateInnerSize();

		this->node->didResolveBorder();
	}

	this->invalidBorder = false;
}

void
DisplayNodeFrame::resolvePadding()
{
	if (this->hasInvalidPadding() == false) {
		return;
	}

	const auto paddingT = this->measurePaddingTop();
	const auto paddingL = this->measurePaddingLeft();
	const auto paddingR = this->measurePaddingRight();
	const auto paddingB = this->measurePaddingBottom();

	if (paddingT != this->measuredPaddingTop ||
		paddingL != this->measuredPaddingLeft ||
		paddingR != this->measuredPaddingRight ||
		paddingB != this->measuredPaddingBottom) {

		this->measuredPaddingTop = paddingT;
		this->measuredPaddingLeft = paddingL;
		this->measuredPaddingRight = paddingR;
		this->measuredPaddingBottom = paddingB;

		this->invalidateLayout();

		this->node->didResolvePadding();
	}

	this->invalidPadding = false;
}

void
DisplayNodeFrame::resolveInnerSize()
{
	if (this->hasInvalidInnerSize() == false) {
		return;
	}

	const auto innerW = this->measureInnerWidth();
	const auto innerH = this->measureInnerHeight();

	if (innerW != this->measuredInnerWidth ||
		innerH != this->measuredInnerHeight) {

		if (this->measuredInnerWidth != innerW) {
			this->measuredInnerWidth = innerW;
			this->measuredInnerWidthChanged = true;
		}

		if (this->measuredInnerHeight != innerH) {
			this->measuredInnerHeight = innerH;
			this->measuredInnerHeightChanged = true;
		}

		this->invalidateContentSize();

		this->node->didResolveInnerSize();
	}

	this->invalidInnerSize = false;
}

void
DisplayNodeFrame::resolveContentSize()
{
	if (this->hasInvalidContentSize() == false) {
		return;
	}

	const auto contentW = this->measureContentWidth();
	const auto contentH = this->measureContentHeight();

	if (contentW != this->measuredContentWidth ||
		contentH != this->measuredContentHeight) {

		if (this->measuredContentWidth != contentW) {
			this->measuredContentWidth = contentW;
			this->measuredContentWidthChanged = true;
		}

		if (this->measuredContentHeight != contentH) {
			this->measuredContentHeight = contentH;
			this->measuredContentHeightChanged = true;
		}

		this->invalidateLayout();

		this->node->didResolveContentSize();
	}

	this->invalidContentSize = false;
}

void
DisplayNodeFrame::resolveWrapper(double w, double h)
{
	if (this->resolvedSize) {

		/*
		 * Once a node has been measured, unless its size is explicity invalid
		 * or its views has changed, there are no reason to measured it
		 * again.
		 */

		if (this->invalidSize == false &&
			this->invalidLayout == false) {
			return;
		}
	}

	const bool wrapW = this->wrapsContentWidth;
	const bool wrapH = this->wrapsContentHeight;

	auto measuredW = this->measuredWidth;
	auto measuredH = this->measuredHeight;

	if (wrapW) w = 0;
	if (wrapH) h = 0;

	this->measuredWidth = w;
	this->measuredHeight = h;

	/*
	 * When a wrapped node is measured we give the node a chance to returns
	 * its intrinsic size first. This is useful for views such as text that
	 * needs their size to fit the text content.
	 */

	DisplayNodeMeasuredSize size;
	size.width = -1;
	size.height = -1;

	this->node->measure(
		&size, w, h,
		this->width.min,
		this->width.max,
		this->height.min,
		this->height.max
	);

	bool hasIntrinsicW = size.width > -1;
	bool hasIntrinsicH = size.height > -1;

	if (wrapW && hasIntrinsicW) this->measuredWidth = size.width;
	if (wrapH && hasIntrinsicH) this->measuredHeight = size.height;

	if (hasIntrinsicW == false ||
		hasIntrinsicH == false) {

		/*
		 * At this point the node size is determined by its content, padding
		 * and border. We set the padding to 0 because it might have been
		 * incorrectly resolved previously, for instance when using relative
		 * to size units.
		 */

		this->measuredPaddingTop = 0;
		this->measuredPaddingLeft = 0;
		this->measuredPaddingRight = 0;
		this->measuredPaddingBottom = 0;

		const auto contentAlignment = this->contentAlignment;
		const auto contentLocation = this->contentLocation;

		this->contentAlignment = kDisplayNodeContentAlignmentStart;
		this->contentLocation = kDisplayNodeContentLocationStart;

		this->resolveLayout();

		this->contentAlignment = contentAlignment;
		this->contentLocation = contentLocation;

		if (wrapW) w = this->layout.getExtentRight() - this->layout.getExtentLeft();
		if (wrapH) h = this->layout.getExtentBottom() - this->layout.getExtentTop();

		this->measuredWidth = w;
		this->measuredHeight = h;
	}

	/*
	 * The padding and border can be expressed as a relative measure of the
	 * view. In the case of a wrapped node, the padding and border size will be
	 * based on the node size.
	 */

	if (this->measuredWidth != measuredW) {
		this->measuredWidthChanged = true;
		this->invalidateInnerSize();
	}

	if (this->measuredHeight != measuredH) {
		this->measuredHeightChanged = true;
		this->invalidateInnerSize();
	}

	this->resolveInnerSize();
	this->resolveContentSize();
	this->resolveBorder();
	this->resolvePadding();

	const auto borderT = this->measuredBorderTop;
	const auto borderL = this->measuredBorderLeft;
	const auto borderR = this->measuredBorderRight;
	const auto borderB = this->measuredBorderBottom;

	const auto paddingT = this->measuredPaddingTop;
	const auto paddingL = this->measuredPaddingLeft;
	const auto paddingR = this->measuredPaddingRight;
	const auto paddingB = this->measuredPaddingBottom;

	if (paddingT || paddingL ||
		paddingR || paddingB) {

		/*
		 * A second layout pass is needed to apply padding which could not be
		 * calculated earlier, because of relative measures.
		 */

		this->invalidateLayout();
	}

	this->measuredWidth += borderL + borderR + paddingL + paddingR;
	this->measuredHeight += borderT + borderB + paddingT + paddingB;

	const auto scale = this->node->display->getScale();

	measuredW = this->measuredWidth;
	measuredH = this->measuredHeight;

	this->measuredWidth = round(this->measuredWidth, scale);
	this->measuredHeight = round(this->measuredHeight, scale);

	this->measuredWidth = clamp(
		this->measuredWidth,
		this->width.min,
		this->width.max
	);

	this->measuredHeight = clamp(
		this->measuredHeight,
		this->height.min,
		this->height.max
	);

	if (this->measuredWidth != measuredW ||
		this->measuredHeight != measuredH) {

		/*
		 * The node size has been limited to a certain size, this invalidates
		 * the inner and content size as well as the layout.
		 */

		this->invalidateInnerSize();
		this->invalidateLayout();

		this->resolveInnerSize();
		this->resolveContentSize();
	}

	/*
	 * The following members, when set to true might allow the border and
	 * padding to be resolved again. Since these are resolved here, there is
	 * no reason to allow them to be resolved again.
	 */

	this->measuredWidthChanged = false;
	this->measuredHeightChanged = false;
	this->measuredInnerWidthChanged = false;
	this->measuredInnerHeightChanged = false;
	this->measuredContentWidthChanged = false;
	this->measuredContentHeightChanged = false;
}

double
DisplayNodeFrame::measureAnchorTop()
{
	double value = 0;

	if (this->anchorTop.type == kDisplayNodeAnchorTypeLength) {

		value = this->anchorTop.length;

		switch (this->anchorTop.unit) {
			case kDisplayNodeAnchorUnitPC: value = scale(value, this->measuredHeight); break;
			default: break;
		}
	}

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measureAnchorLeft()
{
	double value = 0;

	if (this->anchorLeft.type == kDisplayNodeAnchorTypeLength) {

		value = this->anchorLeft.length;

		switch (this->anchorLeft.unit) {
			case kDisplayNodeAnchorUnitPC: value = scale(value, this->measuredWidth); break;
			default: break;
		}
	}

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measureBorderTop()
{
	const auto type = this->borderTop.type;
	const auto unit = this->borderTop.unit;

	double value = this->borderTop.length;

	if (type == kDisplayNodeBorderTypeLength) {

		switch (unit) {

			case kDisplayNodeBorderUnitPC: value = scale(value, this->measuredHeight); break;
			case kDisplayNodeBorderUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodeBorderUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodeBorderUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodeBorderUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodeBorderUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodeBorderUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->borderTop.min,
		this->borderTop.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measureBorderLeft()
{
	const auto type = this->borderLeft.type;
	const auto unit = this->borderLeft.unit;

	double value = this->borderLeft.length;

	if (type == kDisplayNodeBorderTypeLength) {

		switch (unit) {

			case kDisplayNodeBorderUnitPC: value = scale(value, this->measuredWidth); break;
			case kDisplayNodeBorderUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodeBorderUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodeBorderUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodeBorderUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodeBorderUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodeBorderUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->borderLeft.min,
		this->borderLeft.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measureBorderRight()
{
	const auto type = this->borderRight.type;
	const auto unit = this->borderRight.unit;

	double value = this->borderRight.length;

	if (type == kDisplayNodeBorderTypeLength) {

		switch (unit) {

			case kDisplayNodeBorderUnitPC: value = scale(value, this->measuredWidth); break;
			case kDisplayNodeBorderUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodeBorderUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodeBorderUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodeBorderUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodeBorderUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodeBorderUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->borderRight.min,
		this->borderRight.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measureBorderBottom()
{
	const auto type = this->borderBottom.type;
	const auto unit = this->borderBottom.unit;

	double value = this->borderBottom.length;

	if (type == kDisplayNodeBorderTypeLength) {

		switch (unit) {

			case kDisplayNodeBorderUnitPC: value = scale(value, this->measuredHeight); break;
			case kDisplayNodeBorderUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodeBorderUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodeBorderUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodeBorderUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodeBorderUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodeBorderUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->borderBottom.min,
		this->borderBottom.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measureMarginTop()
{
	const auto type = this->marginTop.type;
	const auto unit = this->marginTop.unit;

	double value = this->marginTop.length;

	if (type == kDisplayNodeMarginTypeLength) {

		switch (unit) {

			case kDisplayNodeMarginUnitPC: value = scale(value, this->node->parent->frame->measuredContentHeight); break;
			case kDisplayNodeMarginUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodeMarginUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodeMarginUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodeMarginUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodeMarginUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodeMarginUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->marginTop.min,
		this->marginTop.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measureMarginLeft()
{
	const auto type = this->marginLeft.type;
	const auto unit = this->marginLeft.unit;

	double value = this->marginLeft.length;

	if (type == kDisplayNodeMarginTypeLength) {

		switch (unit) {

			case kDisplayNodeMarginUnitPC: value = scale(value, this->node->parent->frame->measuredContentWidth); break;
			case kDisplayNodeMarginUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodeMarginUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodeMarginUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodeMarginUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodeMarginUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodeMarginUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->marginLeft.min,
		this->marginLeft.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measureMarginRight()
{
	const auto type = this->marginRight.type;
	const auto unit = this->marginRight.unit;

	double value = this->marginRight.length;

	if (type == kDisplayNodeMarginTypeLength) {

		switch (unit) {

			case kDisplayNodeMarginUnitPC: value = scale(value, this->node->parent->frame->measuredContentWidth); break;
			case kDisplayNodeMarginUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodeMarginUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodeMarginUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodeMarginUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodeMarginUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodeMarginUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->marginRight.min,
		this->marginRight.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measureMarginBottom()
{
	const auto type = this->marginBottom.type;
	const auto unit = this->marginBottom.unit;

	double value = this->marginBottom.length;

	if (type == kDisplayNodeMarginTypeLength) {

		switch (unit) {

			case kDisplayNodeMarginUnitPC: value = scale(value, this->node->parent->frame->measuredContentHeight); break;
			case kDisplayNodeMarginUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodeMarginUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodeMarginUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodeMarginUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodeMarginUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodeMarginUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->marginBottom.min,
		this->marginBottom.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measurePaddingTop()
{
	const auto type = this->paddingTop.type;
	const auto unit = this->paddingTop.unit;

	double value = this->paddingTop.length;

	if (type == kDisplayNodePaddingTypeLength) {

		switch (unit) {

			case kDisplayNodePaddingUnitPC: value = scale(value, this->measuredInnerHeight); break;
			case kDisplayNodePaddingUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodePaddingUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodePaddingUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodePaddingUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodePaddingUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodePaddingUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->paddingTop.min,
		this->paddingTop.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measurePaddingLeft()
{
	const auto type = this->paddingLeft.type;
	const auto unit = this->paddingLeft.unit;

	double value = this->paddingLeft.length;

	if (type == kDisplayNodePaddingTypeLength) {

		switch (unit) {

			case kDisplayNodePaddingUnitPC: value = scale(value, this->measuredInnerWidth); break;
			case kDisplayNodePaddingUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodePaddingUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodePaddingUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodePaddingUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodePaddingUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodePaddingUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->paddingLeft.min,
		this->paddingLeft.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measurePaddingRight()
{
	const auto type = this->paddingRight.type;
	const auto unit = this->paddingRight.unit;

	double value = this->paddingRight.length;

	if (type == kDisplayNodePaddingTypeLength) {

		switch (unit) {

			case kDisplayNodePaddingUnitPC: value = scale(value, this->measuredInnerWidth); break;
			case kDisplayNodePaddingUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodePaddingUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodePaddingUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodePaddingUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodePaddingUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodePaddingUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->paddingRight.min,
		this->paddingRight.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measurePaddingBottom()
{
	const auto type = this->paddingBottom.type;
	const auto unit = this->paddingBottom.unit;

	double value = this->paddingBottom.length;

	if (type == kDisplayNodePaddingTypeLength) {

		switch (unit) {

			case kDisplayNodePaddingUnitPC: value = scale(value, this->measuredInnerHeight); break;
			case kDisplayNodePaddingUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodePaddingUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodePaddingUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodePaddingUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodePaddingUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodePaddingUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->paddingBottom.min,
		this->paddingBottom.max
	);

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measureInnerWidth()
{
	/*
	 * note: there is no need here to round the values as they are
	 * rounded already
	 */

	return this->measuredWidth - this->measuredBorderLeft - this->measuredBorderRight;
}

double
DisplayNodeFrame::measureInnerHeight()
{
	/*
	 * note: there is no need here to round the values as they are
	 * rounded already
	 */

	return this->measuredHeight - this->measuredBorderTop - this->measuredBorderBottom;
}

double
DisplayNodeFrame::measureContentWidth()
{
	const auto type = this->contentWidth.type;
	const auto unit = this->contentWidth.unit;

	double value = this->contentWidth.length;

	if (type == kDisplayNodeContentSizeTypeAuto) {

		value = this->measuredInnerWidth;

	} else {

		switch (unit) {

			case kDisplayNodeContentSizeUnitPC: value = scale(value, this->measuredInnerWidth); break;
			case kDisplayNodeContentSizeUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodeContentSizeUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodeContentSizeUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodeContentSizeUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodeContentSizeUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodeContentSizeUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}

		value = max(value, this->measuredInnerWidth);
	}

	return round(value, this->node->display->getScale());
}

double
DisplayNodeFrame::measureContentHeight()
{
	const auto type = this->contentHeight.type;
	const auto unit = this->contentHeight.unit;

	double value = this->contentHeight.length;

	if (type == kDisplayNodeContentSizeTypeAuto) {

		value = this->measuredInnerHeight;

	} else {

		switch (unit) {

			case kDisplayNodeContentSizeUnitPC: value = scale(value, this->measuredInnerHeight); break;
			case kDisplayNodeContentSizeUnitPW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerWidth : 0); break;
			case kDisplayNodeContentSizeUnitPH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredInnerHeight : 0); break;
			case kDisplayNodeContentSizeUnitCW: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentWidth : 0); break;
			case kDisplayNodeContentSizeUnitCH: value = scale(value, this->node->parent ? this->node->parent->frame->measuredContentHeight : 0); break;
			case kDisplayNodeContentSizeUnitVW: value = scale(value, this->node->display->getViewportWidth()); break;
			case kDisplayNodeContentSizeUnitVH: value = scale(value, this->node->display->getViewportHeight()); break;
			default: break;

		}

		value = max(value, this->measuredInnerHeight);
	}

	return round(value, this->node->display->getScale());
}

bool
DisplayNodeFrame::hasResolvedParentChange()
{
	return this->resolvedParent != this->node->parent;
}

bool
DisplayNodeFrame::isRelative()
{
	return (
		this->top.type == kDisplayNodeOriginTypeAuto &&
		this->left.type == kDisplayNodeOriginTypeAuto &&
		this->right.type == kDisplayNodeOriginTypeAuto &&
		this->bottom.type == kDisplayNodeOriginTypeAuto
	);
}

bool
DisplayNodeFrame::isAbsolute()
{
	return (
		this->top.type == kDisplayNodeOriginTypeLength ||
		this->left.type == kDisplayNodeOriginTypeLength ||
		this->right.type == kDisplayNodeOriginTypeLength ||
		this->bottom.type == kDisplayNodeOriginTypeLength
	);
}

} 
