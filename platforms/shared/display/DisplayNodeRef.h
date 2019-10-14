#ifndef DisplayNodeRef_h
#define DisplayNodeRef_h

#include "DisplayBase.h"

#if __cplusplus
extern "C" {
#endif

/**
 * Creates a display node.
 * @function DisplayNodeCreate;
 * @since 0.7.0
 */
DisplayNodeRef DisplayNodeCreate();

/**
 * Releases a display node.
 * @function DisplayNodeDelete
 * @since 0.7.0
 */
void DisplayNodeDelete(DisplayNodeRef node);

/**
 * Assigns the display node's display.
 * @function DisplayNodeSetDisplay
 * @since 0.4.0
 */
void DisplayNodeSetDisplay(DisplayNodeRef node, DisplayRef display);

/**
 * Assigns the display node's identifier.
 * @function DisplayNodeSetId
 * @since 0.7.0
 */
void DisplayNodeSetId(DisplayNodeRef node, const char* id);

/**
 * Assigns the display node's type.
 * @function DisplayNodeSetType
 * @since 0.7.0
 */
void DisplayNodeSetType(DisplayNodeRef node, DisplayNodeType type);

/**
 * Assigns the display node's top anchor position.
 * @function DisplayNodeSetAnchorTop
 * @since 0.7.0
 */
void DisplayNodeSetAnchorTop(DisplayNodeRef node, DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length);

/**
 * Assigns the display node's left anchor position.
 * @function DisplayNodeSetAnchorLeft
 * @since 0.7.0
 */
void DisplayNodeSetAnchorLeft(DisplayNodeRef node, DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length);

/**
 * Assigns the display node's top position specification.
 * @function DisplayNodeSetTop
 * @since 0.7.0
 */
void DisplayNodeSetTop(DisplayNodeRef node, DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length);

/**
 * Assigns the display node's minimum top position.
 * @function DisplayNodeSetMinTop
 * @since 0.7.0
 */
void DisplayNodeSetMinTop(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum top position.
 * @function DisplayNodeSetMaxTop
 * @since 0.7.0
 */
void DisplayNodeSetMaxTop(DisplayNodeRef node, double max);

/**
 * Assigns the display node's left position specification.
 * @function DisplayNodeSetLeft
 * @since 0.7.0
 */
void DisplayNodeSetLeft(DisplayNodeRef node, DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length);

/**
 * Assigns the display node's minimum left position.
 * @function DisplayNodeSetMinLeft
 * @since 0.7.0
 */
void DisplayNodeSetMinLeft(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum left position.
 * @function DisplayNodeSetMaxLeft
 * @since 0.7.0
 */
void DisplayNodeSetMaxLeft(DisplayNodeRef node, double max);

/**
 * Assigns the display node's right position specification.
 * @function DisplayNodeSetRight
 * @since 0.7.0
 */
void DisplayNodeSetRight(DisplayNodeRef node, DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length);

/**
 * Assigns the display node's minimum right position.
 * @function DisplayNodeSetMinRight
 * @since 0.7.0
 */
void DisplayNodeSetMinRight(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum right position.
 * @function DisplayNodeSetMaxRight
 * @since 0.7.0
 */
void DisplayNodeSetMaxRight(DisplayNodeRef node, double max);

/**
 * Assigns the display node's bottom position specification.
 * @function DisplayNodeSetBottom
 * @since 0.7.0
 */
void DisplayNodeSetBottom(DisplayNodeRef node, DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length);

/**
 * Assigns the display node's minimum bottom position.
 * @function DisplayNodeSetMinBottom
 * @since 0.7.0
 */
void DisplayNodeSetMinBottom(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum bottom position.
 * @function DisplayNodeSetMaxBottom
 * @since 0.7.0
 */
void DisplayNodeSetMaxBottom(DisplayNodeRef node, double max);

/**
 * Assigns the display node's width specification.
 * @function DisplayNodeSetWidth
 * @since 0.7.0
 */
void DisplayNodeSetWidth(DisplayNodeRef node, DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length);

/**
 * Assigns the display node's minimum width.
 * @function DisplayNodeSetMinWidth
 * @since 0.7.0
 */
void DisplayNodeSetMinWidth(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum width.
 * @function DisplayNodeSetMaxWidth
 * @since 0.7.0
 */
void DisplayNodeSetMaxWidth(DisplayNodeRef node, double max);

/**
 * Assigns the display node's height specification.
 * @function DisplayNodeSetHeight
 * @since 0.7.0
 */
void DisplayNodeSetHeight(DisplayNodeRef node, DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length);

/**
 * Assigns the display node's minimum width.
 * @function DisplayNodeSetMinHeight
 * @since 0.7.0
 */
void DisplayNodeSetMinHeight(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum width.
 * @function DisplayNodeSetMaxHeight
 * @since 0.7.0
 */
void DisplayNodeSetMaxHeight(DisplayNodeRef node, double max);

/**
 * Assigns the display node's content direction specification.
 * @function DisplayNodeSetContentDirection
 * @since 0.7.0
 */
void DisplayNodeSetContentDirection(DisplayNodeRef node, DisplayNodeContentDirection direction);

/**
 * Assigns the display node's content gravity specification.
 * @function DisplayNodeSetContentLocation
 * @since 0.7.0
 */
void DisplayNodeSetContentLocation(DisplayNodeRef node, DisplayNodeContentLocation placement);

/**
 * Assigns the display node's content alignment specification.
 * @function DisplayNodeSetContentAlignment
 * @since 0.7.0
 */
void DisplayNodeSetContentAlignment(DisplayNodeRef node, DisplayNodeContentAlignment alignment);

/**
 * Assigns the display node's content top specification.
 * @function DisplayNodeSetContentTop
 * @since 0.7.0
 */
void DisplayNodeSetContentTop(DisplayNodeRef node, DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length);

/**
 * Assigns the display node's content left specification.
 * @function DisplayNodeSetContentLeft
 * @since 0.7.0
 */
void DisplayNodeSetContentLeft(DisplayNodeRef node, DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length);

/**
 * Assigns the display node's content width specification.
 * @function DisplayNodeSetContentWidth
 * @since 0.7.0
 */
void DisplayNodeSetContentWidth(DisplayNodeRef node, DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length);

/**
 * Assigns the display node's content height specification.
 * @function DisplayNodeSetContentHeight
 * @since 0.7.0
 */
void DisplayNodeSetContentHeight(DisplayNodeRef node, DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length);

/**
 * Assigns whether the display node's can expand to fill remaining space.
 * @function DisplayNodeSetExpandFactor
 * @since 0.7.0
 */
void DisplayNodeSetExpandFactor(DisplayNodeRef node, double factor);

/**
 * Assigns whether the display node's can shrint to fit existing space.
 * @function DisplayNodeSetShrinkFactorable
 * @since 0.7.0
 */
void DisplayNodeSetShrinkFactor(DisplayNodeRef node, double factor);

/**
 * Assigns the display node's border top specification.
 * @function DisplayNodeSetBorderTop
 * @since 0.7.0
 */
void DisplayNodeSetBorderTop(DisplayNodeRef node, DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length);

/**
 * Assigns the display node's border left specification.
 * @function DisplayNodeSetBorderLeft
 * @since 0.7.0
 */
void DisplayNodeSetBorderLeft(DisplayNodeRef node, DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length);

/**
 * Assigns the display node's border right specification.
 * @function DisplayNodeSetBorderRight
 * @since 0.7.0
 */
void DisplayNodeSetBorderRight(DisplayNodeRef node, DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length);

/**
 * Assigns the display node's border bottom specification.
 * @function DisplayNodeSetBorderBottom
 * @since 0.7.0
 */
void DisplayNodeSetBorderBottom(DisplayNodeRef node, DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length);

/**
 * Assigns the display node's margin top specification.
 * @function DisplayNodeSetMarginTop
 * @since 0.7.0
 */
void DisplayNodeSetMarginTop(DisplayNodeRef node, DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length);

/**
 * Assigns the display node's margin left specification.
 * @function DisplayNodeSetMarginLeft
 * @since 0.7.0
 */
void DisplayNodeSetMarginLeft(DisplayNodeRef node, DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length);

/**
 * Assigns the display node's margin right specification.
 * @function DisplayNodeSetMarginRight
 * @since 0.7.0
 */
void DisplayNodeSetMarginRight(DisplayNodeRef node, DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length);

/**
 * Assigns the display node's margin bottom specification.
 * @function DisplayNodeSetMarginBottom
 * @since 0.7.0
 */
void DisplayNodeSetMarginBottom(DisplayNodeRef node, DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length);

/**
 * Assigns the display node's minimum top margin.
 * @function DisplayNodeSetMinMarginTop
 * @since 0.7.0
 */
void DisplayNodeSetMinMarginTop(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum top margin.
 * @function DisplayNodeSetMaxMarginTop
 * @since 0.7.0
 */
void DisplayNodeSetMaxMarginTop(DisplayNodeRef node, double max);

/**
 * Assigns the display node's minimum left margin.
 * @function DisplayNodeSetMinMarginLeft
 * @since 0.7.0
 */
void DisplayNodeSetMinMarginLeft(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum left margin.
 * @function DisplayNodeSetMaxMarginLeft
 * @since 0.7.0
 */
void DisplayNodeSetMaxMarginLeft(DisplayNodeRef node, double max);

/**
 * Assigns the display node's minimum right margin.
 * @function DisplayNodeSetMinMarginRight
 * @since 0.7.0
 */
void DisplayNodeSetMinMarginRight(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum right margin.
 * @function DisplayNodeSetMaxMarginRight
 * @since 0.7.0
 */
void DisplayNodeSetMaxMarginRight(DisplayNodeRef node, double max);

/**
 * Assigns the display node's minimum bottom margin.
 * @function DisplayNodeSetMinMarginBottom
 * @since 0.7.0
 */
void DisplayNodeSetMinMarginBottom(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum bottom margin.
 * @function DisplayNodeSetMaxMarginBottom
 * @since 0.7.0
 */
void DisplayNodeSetMaxMarginBottom(DisplayNodeRef node, double max);

/**
 * Assigns the display node's padding top specification.
 * @function DisplayNodeSetPaddingTop
 * @since 0.7.0
 */
void DisplayNodeSetPaddingTop(DisplayNodeRef node, DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length);

/**
 * Assigns the display node's padding left specification.
 * @function DisplayNodeSetPaddingLeft
 * @since 0.7.0
 */
void DisplayNodeSetPaddingLeft(DisplayNodeRef node, DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length);

/**
 * Assigns the display node's padding right specification.
 * @function DisplayNodeSetPaddingRight
 * @since 0.7.0
 */
void DisplayNodeSetPaddingRight(DisplayNodeRef node, DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length);

/**
 * Assigns the display node's padding bottom specification.
 * @function DisplayNodeSetPaddingBottom
 * @since 0.7.0
 */
void DisplayNodeSetPaddingBottom(DisplayNodeRef node, DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length);

/**
 * Assigns the display node's minimum top padding.
 * @function DisplayNodeSetMinPaddingTop
 * @since 0.7.0
 */
void DisplayNodeSetMinPaddingTop(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum top padding.
 * @function DisplayNodeSetMaxPaddingTop
 * @since 0.7.0
 */
void DisplayNodeSetMaxPaddingTop(DisplayNodeRef node, double max);

/**
 * Assigns the display node's minimum left padding.
 * @function DisplayNodeSetMinPaddingLeft
 * @since 0.7.0
 */
void DisplayNodeSetMinPaddingLeft(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum left padding.
 * @function DisplayNodeSetMaxPaddingLeft
 * @since 0.7.0
 */
void DisplayNodeSetMaxPaddingLeft(DisplayNodeRef node, double max);

/**
 * Assigns the display node's minimum right padding.
 * @function DisplayNodeSetMinPaddingRight
 * @since 0.7.0
 */
void DisplayNodeSetMinPaddingRight(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum right padding.
 * @function DisplayNodeSetMaxPaddingRight
 * @since 0.7.0
 */
void DisplayNodeSetMaxPaddingRight(DisplayNodeRef node, double max);

/**
 * Assigns the display node's minimum bottom padding.
 * @function DisplayNodeSetMinPaddingBottom
 * @since 0.7.0
 */
void DisplayNodeSetMinPaddingBottom(DisplayNodeRef node, double min);

/**
 * Assigns the display node's maximum bottom padding.
 * @function DisplayNodeSetMaxPaddingBottom
 * @since 0.7.0
 */
void DisplayNodeSetMaxPaddingBottom(DisplayNodeRef node, double max);

/**
 * Returns whether the node's width has been set to fill its parent.
 * @function DisplayNodeIsFillingParentWidth
 * @since 0.7.0
 */
bool DisplayNodeIsFillingParentWidth(DisplayNodeRef node);

/**
 * Returns whether the node's height has been set to fill its parent.
 * @function DisplayNodeIsFillingParentHeight
 * @since 0.7.0
 */
bool DisplayNodeIsFillingParentHeight(DisplayNodeRef node);

/**
 * Returns whether the node's width has been set to wraps its content.
 * @function DisplayNodeWrapsContentWidth
 * @since 0.7.0
 */
bool DisplayNodeIsWrappingContentWidth(DisplayNodeRef node);

/**
 * Returns whether the node's height has been set to wraps its content.
 * @function DisplayNodeIsWrappingContentHeight
 * @since 0.7.0
 */
bool DisplayNodeIsWrappingContentHeight(DisplayNodeRef node);

/**
 * Returns the display node's measured top.
 * @function DisplayNodeGetMeasuredTop
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredTop(DisplayNodeRef node);

/**
 * Returns the display node's measured left.
 * @function DisplayNodeGetMeasuredLeft
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredLeft(DisplayNodeRef node);

/**
 * Returns the display node's measured right.
 * @function DisplayNodeGetMeasuredRight
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredRight(DisplayNodeRef node);

/**
 * Returns the display node's measured bottom.
 * @function DisplayNodeGetMeasuredBottom
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredBottom(DisplayNodeRef node);

/**
 * Returns the display node's measured width.
 * @function DisplayNodeGetMeasuredWidth
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredWidth(DisplayNodeRef node);

/**
 * Returns the display node's measured height.
 * @function DisplayNodeGetMeasuredHeight
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredHeight(DisplayNodeRef node);

/**
 * Returns the display node's measured inner width;
 * @function DisplayNodeGetMeasuredInnerWidth
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredInnerWidth(DisplayNodeRef node);

/**
 * Returns the display node's measured inner height;
 * @function DisplayNodeGetMeasuredInnerHeight
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredInnerHeight(DisplayNodeRef node);

/**
 * Returns the display node's measured content width.
 * @function DisplayNodeGetMeasuredContentWidth
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredContentWidth(DisplayNodeRef node);

/**
 * Returns the display node's measured content height.
 * @function DisplayNodeGetMeasuredContentHeight
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredContentHeight(DisplayNodeRef node);

/**
 * Returns the display node's measured border top.
 * @function DisplayNodeGetMeasuredBorderTop
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredBorderTop(DisplayNodeRef node);

/**
 * Returns the display node's measured border left.
 * @function DisplayNodeGetMeasuredBorderLeft
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredBorderLeft(DisplayNodeRef node);

/**
 * Returns the display node's measured border right.
 * @function DisplayNodeGetMeasuredBorderRight
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredBorderRight(DisplayNodeRef node);

/**
 * Returns the display node's measured border bottom.
 * @function DisplayNodeGetMeasuredBorderBottom
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredBorderBottom(DisplayNodeRef node);

/**
 * Returns the display node's measured margin top.
 * @function DisplayNodeGetMeasuredMarginTop
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredMarginTop(DisplayNodeRef node);

/**
 * Returns the display node's measured margin left.
 * @function DisplayNodeGetMeasuredMarginLeft
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredMarginLeft(DisplayNodeRef node);

/**
 * Returns the display node's measured margin right.
 * @function DisplayNodeGetMeasuredMarginRight
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredMarginRight(DisplayNodeRef node);

/**
 * Returns the display node's measured margin bottom.
 * @function DisplayNodeGetMeasuredMarginBottom
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredMarginBottom(DisplayNodeRef node);

/**
 * Returns the display node's measured padding top.
 * @function DisplayNodeGetMeasuredPaddingTop
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredPaddingTop(DisplayNodeRef node);

/**
 * Returns the display node's measured padding left.
 * @function DisplayNodeGetMeasuredPaddingLeft
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredPaddingLeft(DisplayNodeRef node);

/**
 * Returns the display node's measured padding right.
 * @function DisplayNodeGetMeasuredPaddingRight
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredPaddingRight(DisplayNodeRef node);

/**
 * Returns the display node's measured padding bottom.
 * @function DisplayNodeGetMeasuredPaddingBottom
 * @since 0.7.0
 */
double DisplayNodeGetMeasuredPaddingBottom(DisplayNodeRef node);

/**
 * Assigns whether the node is visible.
 * @function DisplayNodeSetVisible
 * @since 0.7.0
 */
void DisplayNodeSetVisible(DisplayNodeRef node, bool visible);

/**
 * Appends a node to the receiver's children list.
 * @function DisplayNodeInsertChild
 * @since 0.7.0
 */
void DisplayNodeAppendChild(DisplayNodeRef node, DisplayNodeRef child);

/**
 * Inserts a node to the receiver's children list.
 * @function DisplayNodeInsertChild
 * @since 0.7.0
 */
void DisplayNodeInsertChild(DisplayNodeRef node, DisplayNodeRef child, int index);

/**
 * Appends a node to the receiver's children list.
 * @function DisplayNodeRemoveChild
 * @since 0.7.0
 */
void DisplayNodeRemoveChild(DisplayNodeRef node, DisplayNodeRef child);

/**
 * Invalidates the node's size.
 * @function DisplayNodeInvalidateSize
 * @since 0.7.0
 */
void DisplayNodeInvalidateSize(DisplayNodeRef node);

/**
 * Invalidates the node's origin.
 * @function DisplayNodeInvalidateOrigin
 * @since 0.7.0
 */
void DisplayNodeInvalidateOrigin(DisplayNodeRef node);

/**
 * Invalidates the node's layout.
 * @function DisplayNodeInvalidateLayout
 * @since 0.7.0
 */
void DisplayNodeInvalidateLayout(DisplayNodeRef node);

/**
 * Resolves layouts until the specified node is resolved.
 * @function DisplayNodeResolve
 * @since 0.7.0
 */
void DisplayNodeResolve(DisplayNodeRef node);

/**
 * Measures the display node in a specified size.
 * @function DisplayNodeMeasure
 * @since 0.7.0
 */
void DisplayNodeMeasure(DisplayNodeRef node);

/**
 * Assigns the callback that is called when the node needs to retrieve its natural size.s
 * @function DisplayNodeSetMeasureSizeCallback
 * @since 0.7.0
 */
void DisplayNodeSetMeasureSizeCallback(DisplayNodeRef node, DisplayNodeMeasureCallback callback);

/**
 * Assigns the callback that is called when the node size changes.
 * @function DisplayNodeSetResolveSizeCallback
 * @since 0.7.0
 */
void DisplayNodeSetResolveSizeCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node position changes.
 * @function DisplayNodeSetResolveOriginCallback
 * @since 0.7.0
 */
void DisplayNodeSetResolveOriginCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node inner size changes.
 * @function DisplayNodeSetResolveInnerSizeCallback
 * @since 0.7.0
 */
void DisplayNodeSetResolveInnerSizeCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node content size changes.
 * @function DisplayNodeSetResolveContentSizeCallback
 * @since 0.7.0
 */
void DisplayNodeSetResolveContentSizeCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node margin changes.
 * @function DisplayNodeSetResolveMarginCallback
 * @since 0.7.0
 */
void DisplayNodeSetResolveMarginCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node border changes.
 * @function DisplayNodeSetResolveBorderCallback
 * @since 0.7.0
 */
void DisplayNodeSetResolveBorderCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node padding changes.
 * @function DisplayNodeSetResolvePaddingCallback
 * @since 0.7.0
 */
void DisplayNodeSetResolvePaddingCallback(DisplayNodeRef node, DisplayNodeResolveCallback callback);

/**
 * Assigns the callback that is called once a node begins its layout.
 * @function DisplayNodeSetLayoutBeganCallback
 * @since 0.7.0
 */
void DisplayNodeSetLayoutBeganCallback(DisplayNodeRef node, DisplayNodeLayoutCallback callback);

/**
 * Assigns the callback that is called once a node completes its layout.
 * @function DisplayNodeSetLayoutEndedCallback
 * @since 0.7.0
 */
void DisplayNodeSetLayoutEndedCallback(DisplayNodeRef node, DisplayNodeLayoutCallback callback);

/**
 * Assigns the callback that is called when a node layout is invalidated.
 * @function DisplayNodeInvalidateCallback
 * @since 0.7.0
 */
void DisplayNodeSetInvalidateCallback(DisplayNodeRef node, DisplayNodeInvalidateCallback callback);

/**
 * Assigns the display node's user data.
 * @function DisplayNodeSetData
 * @since 0.7.0
 */
void DisplayNodeSetData(DisplayNodeRef node, void *data);

/**
 * Returns the display node's user data.
 * @function DisplayNodeSetData
 * @since 0.7.0
 */
void* DisplayNodeGetData(DisplayNodeRef node);

#if __cplusplus
}
#endif
#endif
