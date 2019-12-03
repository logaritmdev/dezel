#include "DisplayNodeRef.h"
#include "Display.h"
#include "DisplayNode.h"

using Dezel::Display;
using Dezel::DisplayNode;

DisplayNodeRef
DisplayNodeCreate()
{
	return reinterpret_cast<DisplayNodeRef>(new DisplayNode());
}

void
DisplayNodeDelete(DisplayNodeRef node)
{
	delete reinterpret_cast<DisplayNode*>(node);
}

void
DisplayNodeSetDisplay(DisplayNodeRef node, DisplayRef display)
{
	reinterpret_cast<DisplayNode*>(node)->setDisplay(reinterpret_cast<Display*>(display));
}

void
DisplayNodeSetOpaque(DisplayNodeRef node)
{
	reinterpret_cast<DisplayNode*>(node)->setOpaque();
}

void
DisplayNodeSetName(DisplayNodeRef node, const char* name)
{
	reinterpret_cast<DisplayNode*>(node)->setName(name);
}

void
DisplayNodeSetType(DisplayNodeRef node, const char* type)
{
	reinterpret_cast<DisplayNode*>(node)->setType(type);
}

void
DisplayNodeAppendStyle(DisplayNodeRef node, const char* style)
{
	reinterpret_cast<DisplayNode*>(node)->appendStyle(std::string(style));
}

void
DisplayNodeRemoveStyle(DisplayNodeRef node, const char* style)
{
	reinterpret_cast<DisplayNode*>(node)->removeStyle(std::string(style));
}

bool
DisplayNodeHasStyle(DisplayNodeRef node, const char* style)
{
	return reinterpret_cast<DisplayNode*>(node)->hasStyle(std::string(style));
}

void
DisplayNodeAppendState(DisplayNodeRef node, const char* state)
{
	reinterpret_cast<DisplayNode*>(node)->appendState(std::string(state));
}

void
DisplayNodeRemoveState(DisplayNodeRef node, const char* state)
{
	reinterpret_cast<DisplayNode*>(node)->removeState(std::string(state));
}

bool
DisplayNodeHasState(DisplayNodeRef node, const char* state)
{
	return reinterpret_cast<DisplayNode*>(node)->hasState(std::string(state));
}

void
DisplayNodeSetAnchorTop(DisplayNodeRef node, AnchorType type, AnchorUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setAnchorTop(type, unit, length);
}

void
DisplayNodeSetAnchorLeft(DisplayNodeRef node, AnchorType type, AnchorUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setAnchorLeft(type, unit, length);
}

void
DisplayNodeSetTop(DisplayNodeRef node, OriginType type, OriginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setTop(type, unit, length);
}

void
DisplayNodeSetMinTop(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinTop(min);
}

void
DisplayNodeSetMaxTop(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxTop(max);
}

void
DisplayNodeSetLeft(DisplayNodeRef node, OriginType type, OriginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setLeft(type, unit, length);
}

void
DisplayNodeSetMinLeft(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinLeft(min);
}

void
DisplayNodeSetMaxLeft(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxLeft(max);
}

void
DisplayNodeSetRight(DisplayNodeRef node, OriginType type, OriginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setRight(type, unit, length);
}

void
DisplayNodeSetMinRight(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinRight(min);
}

void
DisplayNodeSetMaxRight(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxRight(max);
}

void
DisplayNodeSetBottom(DisplayNodeRef node, OriginType type, OriginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setBottom(type, unit, length);
}

void
DisplayNodeSetMinBottom(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinBottom(min);
}

void
DisplayNodeSetMaxBottom(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxBottom(max);
}

void
DisplayNodeSetWidth(DisplayNodeRef node, SizeType type, SizeUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setWidth(type, unit, length);
}

void
DisplayNodeSetMinWidth(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinWidth(min);
}

void
DisplayNodeSetMaxWidth(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxWidth(max);
}

void
DisplayNodeSetHeight(DisplayNodeRef node, SizeType type, SizeUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setHeight(type, unit, length);
}

void
DisplayNodeSetMinHeight(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinHeight(min);
}

void
DisplayNodeSetMaxHeight(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxHeight(max);
}

void
DisplayNodeSetContentDirection(DisplayNodeRef node, ContentDirection direction)
{
	reinterpret_cast<DisplayNode*>(node)->setContentDirection(direction);
}

void
DisplayNodeSetContentAlignment(DisplayNodeRef node, ContentAlignment alignment)
{
	reinterpret_cast<DisplayNode*>(node)->setContentAlignment(alignment);
}

void
DisplayNodeSetContentDisposition(DisplayNodeRef node, ContentDisposition location)
{
	reinterpret_cast<DisplayNode*>(node)->setContentDisposition(location);
}

void
DisplayNodeSetContentTop(DisplayNodeRef node, ContentOriginType type, ContentOriginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setContentTop(type, unit, length);
}

void
DisplayNodeSetContentLeft(DisplayNodeRef node, ContentOriginType type, ContentOriginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setContentLeft(type, unit, length);
}

void
DisplayNodeSetContentWidth(DisplayNodeRef node, ContentSizeType type, ContentSizeUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setContentWidth(type, unit, length);
}

void
DisplayNodeSetContentHeight(DisplayNodeRef node, ContentSizeType type, ContentSizeUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setContentHeight(type, unit, length);
}

void
DisplayNodeSetExpandFactor(DisplayNodeRef node, double factor)
{
	reinterpret_cast<DisplayNode*>(node)->setExpandFactor(factor);
}

void
DisplayNodeSetShrinkFactor(DisplayNodeRef node, double factor)
{
	reinterpret_cast<DisplayNode*>(node)->setShrinkFactor(factor);
}

void
DisplayNodeSetBorderTop(DisplayNodeRef node, BorderType type, BorderUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setBorderTop(type, unit, length);
}

void
DisplayNodeSetBorderLeft(DisplayNodeRef node, BorderType type, BorderUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setBorderLeft(type, unit, length);
}

void
DisplayNodeSetBorderRight(DisplayNodeRef node, BorderType type, BorderUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setBorderRight(type, unit, length);
}

void
DisplayNodeSetBorderBottom(DisplayNodeRef node, BorderType type, BorderUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setBorderBottom(type, unit, length);
}

void
DisplayNodeSetMarginTop(DisplayNodeRef node, MarginType type, MarginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setMarginTop(type, unit, length);
}

void
DisplayNodeSetMarginLeft(DisplayNodeRef node, MarginType type, MarginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setMarginLeft(type, unit, length);
}

void
DisplayNodeSetMarginRight(DisplayNodeRef node, MarginType type, MarginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setMarginRight(type, unit, length);
}

void
DisplayNodeSetMarginBottom(DisplayNodeRef node, MarginType type, MarginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setMarginBottom(type, unit, length);
}

void
DisplayNodeSetMinMarginTop(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinMarginTop(min);
}

void
DisplayNodeSetMaxMarginTop(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxMarginTop(max);
}

void
DisplayNodeSetMinMarginLeft(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinMarginLeft(min);
}

void
DisplayNodeSetMaxMarginLeft(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxMarginLeft(max);
}

void
DisplayNodeSetMinMarginRight(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinMarginRight(min);
}

void
DisplayNodeSetMaxMarginRight(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxMarginRight(max);
}

void
DisplayNodeSetMinMarginBottom(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinMarginBottom(min);
}

void
DisplayNodeSetMaxMarginBottom(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxMarginBottom(max);
}

void
DisplayNodeSetPaddingTop(DisplayNodeRef node, PaddingType type, PaddingUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setPaddingTop(type, unit, length);
}

void
DisplayNodeSetPaddingLeft(DisplayNodeRef node, PaddingType type, PaddingUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setPaddingLeft(type, unit, length);
}

void
DisplayNodeSetPaddingRight(DisplayNodeRef node, PaddingType type, PaddingUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setPaddingRight(type, unit, length);
}

void
DisplayNodeSetPaddingBottom(DisplayNodeRef node, PaddingType type, PaddingUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setPaddingBottom(type, unit, length);
}

void
DisplayNodeSetMinPaddingTop(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinPaddingTop(min);
}

void
DisplayNodeSetMaxPaddingTop(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxPaddingTop(max);
}

void
DisplayNodeSetMinPaddingLeft(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinPaddingLeft(min);
}

void
DisplayNodeSetMaxPaddingLeft(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxPaddingLeft(max);
}

void
DisplayNodeSetMinPaddingRight(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinPaddingRight(min);
}

void
DisplayNodeSetMaxPaddingRight(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxPaddingRight(max);
}

void
DisplayNodeSetMinPaddingBottom(DisplayNodeRef node, double min)
{
	reinterpret_cast<DisplayNode*>(node)->setMinPaddingBottom(min);
}

void
DisplayNodeSetMaxPaddingBottom(DisplayNodeRef node, double max)
{
	reinterpret_cast<DisplayNode*>(node)->setMaxPaddingBottom(max);
}

bool
DisplayNodeIsFillingParentWidth(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->isFillingParentWidth();
}

bool
DisplayNodeIsFillingParentHeight(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->isFillingParentHeight();
}

bool
DisplayNodeIsWrappingContentWidth(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->isWrappingContentWidth();
}

bool
DisplayNodeIsWrappingContentHeight(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->isWrappingContentHeight();
}

double
DisplayNodeGetMeasuredTop(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredTop();
}

double
DisplayNodeGetMeasuredLeft(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredLeft();
}

double
DisplayNodeGetMeasuredRight(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredRight();
}

double
DisplayNodeGetMeasuredBottom(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredBottom();
}

double
DisplayNodeGetMeasuredWidth(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredWidth();
}

double
DisplayNodeGetMeasuredHeight(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredHeight();
}

double
DisplayNodeGetMeasuredInnerWidth(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredInnerWidth();
}

double
DisplayNodeGetMeasuredInnerHeight(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredInnerHeight();
}

double
DisplayNodeGetMeasuredContentWidth(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredContentWidth();
}

double
DisplayNodeGetMeasuredContentHeight(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredContentHeight();
}

double
DisplayNodeGetMeasuredBorderTop(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredBorderTop();
}

double
DisplayNodeGetMeasuredBorderLeft(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredBorderLeft();
}

double
DisplayNodeGetMeasuredBorderRight(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredBorderRight();
}

double
DisplayNodeGetMeasuredBorderBottom(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredBorderBottom();
}

double
DisplayNodeGetMeasuredMarginTop(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredMarginTop();
}

double
DisplayNodeGetMeasuredMarginLeft(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredMarginLeft();
}

double
DisplayNodeGetMeasuredMarginRight(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredMarginRight();
}

double
DisplayNodeGetMeasuredMarginBottom(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredMarginBottom();
}

double
DisplayNodeGetMeasuredPaddingTop(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredPaddingTop();
}

double
DisplayNodeGetMeasuredPaddingLeft(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredPaddingLeft();
}

double
DisplayNodeGetMeasuredPaddingRight(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredPaddingRight();
}

double
DisplayNodeGetMeasuredPaddingBottom(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->getMeasuredPaddingBottom();
}

void
DisplayNodeSetVisible(DisplayNodeRef node, bool visible)
{
	reinterpret_cast<DisplayNode*>(node)->setVisible(visible);
}

void
DisplayNodeAppendChild(DisplayNodeRef node, DisplayNodeRef child)
{
	reinterpret_cast<DisplayNode*>(node)->appendChild(reinterpret_cast<DisplayNode*>(child));
}

void
DisplayNodeInsertChild(DisplayNodeRef node, DisplayNodeRef child, int index)
{
	reinterpret_cast<DisplayNode*>(node)->insertChild(reinterpret_cast<DisplayNode*>(child), index);
}

void
DisplayNodeRemoveChild(DisplayNodeRef node, DisplayNodeRef child)
{
	reinterpret_cast<DisplayNode*>(node)->removeChild(reinterpret_cast<DisplayNode*>(child));
}

void
DisplayNodeInvalidateSize(DisplayNodeRef node)
{
	reinterpret_cast<DisplayNode*>(node)->invalidateSize();
}

void
DisplayNodeInvalidateOrigin(DisplayNodeRef node)
{
	reinterpret_cast<DisplayNode*>(node)->invalidateOrigin();
}

void
DisplayNodeInvalidateLayout(DisplayNodeRef node)
{
	reinterpret_cast<DisplayNode*>(node)->invalidateLayout();
}

void
DisplayNodeResolve(DisplayNodeRef node)
{
	reinterpret_cast<DisplayNode*>(node)->resolve();
}

void
DisplayNodeMeasure(DisplayNodeRef node)
{
	reinterpret_cast<DisplayNode*>(node)->measure();
}

void
DisplayNodeSetInvalidateCallback(DisplayNodeRef node, DisplayNodeCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setInvalidateCallback(callback);
}

void
DisplayNodeSetResolveSizeCallback(DisplayNodeRef node, DisplayNodeCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveSizeCallback(callback);
}

void
DisplayNodeSetResolveOriginCallback(DisplayNodeRef node, DisplayNodeCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveOriginCallback(callback);
}

void
DisplayNodeSetResolveInnerSizeCallback(DisplayNodeRef node, DisplayNodeCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveInnerSizeCallback(callback);
}

void
DisplayNodeSetResolveContentSizeCallback(DisplayNodeRef node, DisplayNodeCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveContentSizeCallback(callback);
}

void
DisplayNodeSetResolveMarginCallback(DisplayNodeRef node, DisplayNodeCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveMarginCallback(callback);
}

void
DisplayNodeSetResolveBorderCallback(DisplayNodeRef node, DisplayNodeCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveBorderCallback(callback);
}

void
DisplayNodeSetResolvePaddingCallback(DisplayNodeRef node, DisplayNodeCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolvePaddingCallback(callback);
}

void
DisplayNodeSetPrepareLayoutCallback(DisplayNodeRef node, DisplayNodeCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setPrepareLayoutCallback(callback);
}

void
DisplayNodeSetResolveLayoutCallback(DisplayNodeRef node, DisplayNodeCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveLayoutCallback(callback);
}

void
DisplayNodeSetMeasureCallback(DisplayNodeRef node, DisplayNodeMeasureCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setMeasureCallback(callback);
}

void
DisplayNodeSetUpdateCallback(DisplayNodeRef node, DisplayNodeUpdateCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setUpdateCallback(callback);
}

void
DisplayNodeSetData(DisplayNodeRef node, void *data)
{
	reinterpret_cast<DisplayNode*>(node)->data = data;
}

void*
DisplayNodeGetData(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->data;
}

