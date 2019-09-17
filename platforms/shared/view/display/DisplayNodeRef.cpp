#include "DisplayNodeRef.h"
#include "Display.h"
#include "DisplayNode.h"

using View::Display;
using View::DisplayNode;

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
DisplayNodeSetId(DisplayNodeRef node, const char* id)
{
	reinterpret_cast<DisplayNode*>(node)->setId(id);
}

void
DisplayNodeSetType(DisplayNodeRef node, DisplayNodeType type)
{
	reinterpret_cast<DisplayNode*>(node)->setType(type);
}

void
DisplayNodeSetAnchorTop(DisplayNodeRef node, DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setAnchorTop(type, unit, length);
}

void
DisplayNodeSetAnchorLeft(DisplayNodeRef node, DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setAnchorLeft(type, unit, length);
}

void
DisplayNodeSetTop(DisplayNodeRef node, DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
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
DisplayNodeSetLeft(DisplayNodeRef node, DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
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
DisplayNodeSetRight(DisplayNodeRef node, DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
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
DisplayNodeSetBottom(DisplayNodeRef node, DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
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
DisplayNodeSetWidth(DisplayNodeRef node, DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length)
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
DisplayNodeSetHeight(DisplayNodeRef node, DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length)
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
DisplayNodeSetContentDirection(DisplayNodeRef node, DisplayNodeContentDirection direction)
{
	reinterpret_cast<DisplayNode*>(node)->setContentDirection(direction);
}

void
DisplayNodeSetContentAlignment(DisplayNodeRef node, DisplayNodeContentAlignment alignment)
{
	reinterpret_cast<DisplayNode*>(node)->setContentAlignment(alignment);
}

void
DisplayNodeSetContentLocation(DisplayNodeRef node, DisplayNodeContentLocation location)
{
	reinterpret_cast<DisplayNode*>(node)->setContentLocation(location);
}

void
DisplayNodeSetContentTop(DisplayNodeRef node, DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setContentTop(type, unit, length);
}

void
DisplayNodeSetContentLeft(DisplayNodeRef node, DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setContentLeft(type, unit, length);
}

void
DisplayNodeSetContentWidth(DisplayNodeRef node, DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setContentWidth(type, unit, length);
}

void
DisplayNodeSetContentHeight(DisplayNodeRef node, DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length)
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
DisplayNodeSetBorderTop(DisplayNodeRef node, DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setBorderTop(type, unit, length);
}

void
DisplayNodeSetBorderLeft(DisplayNodeRef node, DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setBorderLeft(type, unit, length);
}

void
DisplayNodeSetBorderRight(DisplayNodeRef node, DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setBorderRight(type, unit, length);
}

void
DisplayNodeSetBorderBottom(DisplayNodeRef node, DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setBorderBottom(type, unit, length);
}

void
DisplayNodeSetMarginTop(DisplayNodeRef node, DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setMarginTop(type, unit, length);
}

void
DisplayNodeSetMarginLeft(DisplayNodeRef node, DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setMarginLeft(type, unit, length);
}

void
DisplayNodeSetMarginRight(DisplayNodeRef node, DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setMarginRight(type, unit, length);
}

void
DisplayNodeSetMarginBottom(DisplayNodeRef node, DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
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
DisplayNodeSetPaddingTop(DisplayNodeRef node, DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setPaddingTop(type, unit, length);
}

void
DisplayNodeSetPaddingLeft(DisplayNodeRef node, DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setPaddingLeft(type, unit, length);
}

void
DisplayNodeSetPaddingRight(DisplayNodeRef node, DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
{
	reinterpret_cast<DisplayNode*>(node)->setPaddingRight(type, unit, length);
}

void
DisplayNodeSetPaddingBottom(DisplayNodeRef node, DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
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
	return reinterpret_cast<DisplayNode*>(node)->fillsParentWidth();
}

bool
DisplayNodeIsFillingParentHeight(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->fillsParentHeight();
}

bool
DisplayNodeIsWrappingContentWidth(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->wrapsContentWidth();
}

bool
DisplayNodeIsWrappingContentHeight(DisplayNodeRef node)
{
	return reinterpret_cast<DisplayNode*>(node)->wrapsContentHeight();
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
DisplayNodeSetMeasureSizeCallback(DisplayNodeRef node, DisplayNodeMeasureCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setMeasureSizeCallback(callback);
}

void
DisplayNodeSetResolveSizeCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveSizeCallback(callback);
}

void
DisplayNodeSetResolveOriginCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveOriginCallback(callback);
}

void
DisplayNodeSetResolveInnerSizeCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveInnerSizeCallback(callback);
}

void
DisplayNodeSetResolveContentSizeCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveContentSizeCallback(callback);
}

void
DisplayNodeSetResolveMarginCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveMarginCallback(callback);
}

void
DisplayNodeSetResolveBorderCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolveBorderCallback(callback);
}

void
DisplayNodeSetResolvePaddingCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setResolvePaddingCallback(callback);
}

void
DisplayNodeSetLayoutBeganCallback(DisplayNodeRef node, DisplayNodeLayoutCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setLayoutBeganCallback(callback);
}

void
DisplayNodeSetLayoutEndedCallback(DisplayNodeRef node, DisplayNodeLayoutCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setLayoutEndedCallback(callback);
}

void
DisplayNodeSetInvalidateCallback(DisplayNodeRef node, DisplayNodeInvalidateCallback callback)
{
	reinterpret_cast<DisplayNode*>(node)->setInvalidateCallback(callback);
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
