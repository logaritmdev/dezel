#ifndef DisplayNodeRef_h
#define DisplayNodeRef_h

#include "DisplayBase.h"

#if __cplusplus
extern "C" {
#endif

/**
 * @function DisplayNodeCreate;
 * @since 0.7.0
 * @hidden
 */
DisplayNodeRef DisplayNodeCreate();

/**
 * @function DisplayNodeDelete
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeDelete(DisplayNodeRef node);

/**
 * @function DisplayNodeSetDisplay
 * @since 0.4.0
 * @hidden
 */
void DisplayNodeSetDisplay(DisplayNodeRef node, DisplayRef display);

/**
 * @function DisplayNodeSetOpaque
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetOpaque(DisplayNodeRef node);

/**
 * @function DisplayNodeSetName
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetName(DisplayNodeRef node, const char* id);

/**
 * @function DisplayNodeSetType
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetType(DisplayNodeRef node, const char* type);

/**
 * @function DisplayNodeAppendStyle
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeAppendStyle(DisplayNodeRef node, const char* style);

/**
 * @function DisplayNodeRemoveStyle
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeRemoveStyle(DisplayNodeRef node, const char* style);

/**
* @function DisplayNodeHasStyle
* @since 0.7.0
* @hidden
*/
bool DisplayNodeHasStyle(DisplayNodeRef node, const char* style);

/**
 * @function DisplayNodeAppendState
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeAppendState(DisplayNodeRef node, const char* state);

/**
 * @function DisplayNodeRemoveState
 * @since 0.7.0
 * @hidden
*/
void DisplayNodeRemoveState(DisplayNodeRef node, const char* state);

/**
* @function DisplayNodeHasState
* @since 0.7.0
* @hidden
*/
bool DisplayNodeHasState(DisplayNodeRef node, const char* state);

/**
 * @function DisplayNodeSetAnchorTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetAnchorTop(DisplayNodeRef node, AnchorType type, AnchorUnit unit, double length);

/**
 * @function DisplayNodeSetAnchorLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetAnchorLeft(DisplayNodeRef node, AnchorType type, AnchorUnit unit, double length);

/**
 * @function DisplayNodeSetTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetTop(DisplayNodeRef node, OriginType type, OriginUnit unit, double length);

/**
 * @function DisplayNodeSetMinTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinTop(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxTop(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetLeft(DisplayNodeRef node, OriginType type, OriginUnit unit, double length);

/**
 * @function DisplayNodeSetMinLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinLeft(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxLeft(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetRight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetRight(DisplayNodeRef node, OriginType type, OriginUnit unit, double length);

/**
 * @function DisplayNodeSetMinRight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinRight(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxRight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxRight(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetBottom
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetBottom(DisplayNodeRef node, OriginType type, OriginUnit unit, double length);

/**
 * @function DisplayNodeSetMinBottom
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinBottom(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxBottom
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxBottom(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetWidth
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetWidth(DisplayNodeRef node, SizeType type, SizeUnit unit, double length);

/**
 * @function DisplayNodeSetMinWidth
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinWidth(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxWidth
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxWidth(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetHeight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetHeight(DisplayNodeRef node, SizeType type, SizeUnit unit, double length);

/**
 * @function DisplayNodeSetMinHeight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinHeight(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxHeight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxHeight(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetContentDirection
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetContentDirection(DisplayNodeRef node, ContentDirection direction);

/**
 * @function DisplayNodeSetContentAlignment
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetContentAlignment(DisplayNodeRef node, ContentAlignment alignment);

/**
 * @function DisplayNodeSetContentDisposition
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetContentDisposition(DisplayNodeRef node, ContentDisposition placement);

/**
 * @function DisplayNodeSetContentTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetContentTop(DisplayNodeRef node, ContentOriginType type, ContentOriginUnit unit, double length);

/**
 * @function DisplayNodeSetContentLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetContentLeft(DisplayNodeRef node, ContentOriginType type, ContentOriginUnit unit, double length);

/**
 * @function DisplayNodeSetContentWidth
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetContentWidth(DisplayNodeRef node, ContentSizeType type, ContentSizeUnit unit, double length);

/**
 * @function DisplayNodeSetContentHeight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetContentHeight(DisplayNodeRef node, ContentSizeType type, ContentSizeUnit unit, double length);

/**
 * @function DisplayNodeSetExpandFactor
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetExpandFactor(DisplayNodeRef node, double factor);

/**
 * @function DisplayNodeSetShrinkFactorable
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetShrinkFactor(DisplayNodeRef node, double factor);

/**
 * @function DisplayNodeSetBorderTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetBorderTop(DisplayNodeRef node, BorderType type, BorderUnit unit, double length);

/**
 * @function DisplayNodeSetBorderLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetBorderLeft(DisplayNodeRef node, BorderType type, BorderUnit unit, double length);

/**
 * @function DisplayNodeSetBorderRight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetBorderRight(DisplayNodeRef node, BorderType type, BorderUnit unit, double length);

/**
 * @function DisplayNodeSetBorderBottom
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetBorderBottom(DisplayNodeRef node, BorderType type, BorderUnit unit, double length);

/**
 * @function DisplayNodeSetMarginTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMarginTop(DisplayNodeRef node, MarginType type, MarginUnit unit, double length);

/**
 * @function DisplayNodeSetMarginLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMarginLeft(DisplayNodeRef node, MarginType type, MarginUnit unit, double length);

/**
 * @function DisplayNodeSetMarginRight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMarginRight(DisplayNodeRef node, MarginType type, MarginUnit unit, double length);

/**
 * @function DisplayNodeSetMarginBottom
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMarginBottom(DisplayNodeRef node, MarginType type, MarginUnit unit, double length);

/**
 * @function DisplayNodeSetMinMarginTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinMarginTop(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxMarginTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxMarginTop(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetMinMarginLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinMarginLeft(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxMarginLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxMarginLeft(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetMinMarginRight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinMarginRight(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxMarginRight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxMarginRight(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetMinMarginBottom
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinMarginBottom(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxMarginBottom
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxMarginBottom(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetPaddingTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetPaddingTop(DisplayNodeRef node, PaddingType type, PaddingUnit unit, double length);

/**
 * @function DisplayNodeSetPaddingLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetPaddingLeft(DisplayNodeRef node, PaddingType type, PaddingUnit unit, double length);

/**
 * @function DisplayNodeSetPaddingRight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetPaddingRight(DisplayNodeRef node, PaddingType type, PaddingUnit unit, double length);

/**
 * @function DisplayNodeSetPaddingBottom
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetPaddingBottom(DisplayNodeRef node, PaddingType type, PaddingUnit unit, double length);

/**
 * @function DisplayNodeSetMinPaddingTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinPaddingTop(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxPaddingTop
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxPaddingTop(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetMinPaddingLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinPaddingLeft(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxPaddingLeft
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxPaddingLeft(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetMinPaddingRight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinPaddingRight(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxPaddingRight
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxPaddingRight(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeSetMinPaddingBottom
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMinPaddingBottom(DisplayNodeRef node, double min);

/**
 * @function DisplayNodeSetMaxPaddingBottom
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMaxPaddingBottom(DisplayNodeRef node, double max);

/**
 * @function DisplayNodeIsFillingParentWidth
 * @since 0.7.0
 * @hidden
 */
bool DisplayNodeIsFillingParentWidth(DisplayNodeRef node);

/**
 * @function DisplayNodeIsFillingParentHeight
 * @since 0.7.0
 * @hidden
 */
bool DisplayNodeIsFillingParentHeight(DisplayNodeRef node);

/**
 * @function DisplayNodeWrapsContentWidth
 * @since 0.7.0
 * @hidden
 */
bool DisplayNodeIsWrappingContentWidth(DisplayNodeRef node);

/**
 * @function DisplayNodeIsWrappingContentHeight
 * @since 0.7.0
 * @hidden
 */
bool DisplayNodeIsWrappingContentHeight(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredTop
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredTop(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredLeft
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredLeft(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredRight
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredRight(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredBottom
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredBottom(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredWidth
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredWidth(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredHeight
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredHeight(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredInnerWidth
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredInnerWidth(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredInnerHeight
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredInnerHeight(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredContentWidth
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredContentWidth(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredContentHeight
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredContentHeight(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredBorderTop
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredBorderTop(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredBorderLeft
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredBorderLeft(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredBorderRight
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredBorderRight(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredBorderBottom
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredBorderBottom(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredMarginTop
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredMarginTop(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredMarginLeft
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredMarginLeft(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredMarginRight
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredMarginRight(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredMarginBottom
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredMarginBottom(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredPaddingTop
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredPaddingTop(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredPaddingLeft
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredPaddingLeft(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredPaddingRight
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredPaddingRight(DisplayNodeRef node);

/**
 * @function DisplayNodeGetMeasuredPaddingBottom
 * @since 0.7.0
 * @hidden
 */
double DisplayNodeGetMeasuredPaddingBottom(DisplayNodeRef node);

/**
 * @function DisplayNodeSetVisible
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetVisible(DisplayNodeRef node, bool visible);

/**
 * @function DisplayNodeInsertChild
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeAppendChild(DisplayNodeRef node, DisplayNodeRef child);

/**
 * @function DisplayNodeInsertChild
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeInsertChild(DisplayNodeRef node, DisplayNodeRef child, int index);

/**
 * @function DisplayNodeRemoveChild
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeRemoveChild(DisplayNodeRef node, DisplayNodeRef child);

/**
 * @function DisplayNodeInvalidateSize
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeInvalidateSize(DisplayNodeRef node);

/**
 * @function DisplayNodeInvalidateOrigin
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeInvalidateOrigin(DisplayNodeRef node);

/**
 * @function DisplayNodeInvalidateLayout
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeInvalidateLayout(DisplayNodeRef node);

/**
 * @function DisplayNodeResolve
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeResolve(DisplayNodeRef node);

/**
 * @function DisplayNodeMeasure
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeMeasure(DisplayNodeRef node);

/**
 * @function DisplayNodeSetInvalidateCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetInvalidateCallback(DisplayNodeRef node, DisplayNodeCallback callback);

/**
 * @function DisplayNodeSetResolveSizeCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetResolveSizeCallback(DisplayNodeRef node, DisplayNodeCallback callback);

/**
 * @function DisplayNodeSetResolveOriginCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetResolveOriginCallback(DisplayNodeRef node, DisplayNodeCallback callback);

/**
 * @function DisplayNodeSetResolveInnerSizeCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetResolveInnerSizeCallback(DisplayNodeRef node, DisplayNodeCallback callback);

/**
 * @function DisplayNodeSetResolveContentSizeCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetResolveContentSizeCallback(DisplayNodeRef node, DisplayNodeCallback callback);

/**
 * @function DisplayNodeSetResolveMarginCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetResolveMarginCallback(DisplayNodeRef node, DisplayNodeCallback callback);

/**
 * @function DisplayNodeSetResolveBorderCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetResolveBorderCallback(DisplayNodeRef node, DisplayNodeCallback callback);

/**
 * @function DisplayNodeSetResolvePaddingCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetResolvePaddingCallback(DisplayNodeRef node, DisplayNodeCallback callback);

/**
 * @function DisplayNodeSetPrepareLayoutCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetPrepareLayoutCallback(DisplayNodeRef node, DisplayNodeCallback callback);

/**
 * @function DisplayNodeSetResolveLayoutCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetResolveLayoutCallback(DisplayNodeRef node, DisplayNodeCallback callback);

/**
 * @function DisplayNodeSetMeasureCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetMeasureCallback(DisplayNodeRef node, DisplayNodeMeasureCallback callback);

/**
 * @function DisplayNodeSetUpdateCallback
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetUpdateCallback(DisplayNodeRef node, DisplayNodeUpdateCallback callback);

/**
 * @function DisplayNodeSetData
 * @since 0.7.0
 * @hidden
 */
void DisplayNodeSetData(DisplayNodeRef node, void *data);

/**
 * @function DisplayNodeSetData
 * @since 0.7.0
 * @hidden
 */
void* DisplayNodeGetData(DisplayNodeRef node);

#if __cplusplus
}
#endif
#endif
