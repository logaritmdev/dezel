#ifndef DLLayoutNode_h
#define DLLayoutNode_h

#include <float.h>
#include "DLLayout.h"

#define ABS_DBL_MIN -DBL_MAX
#define ABS_DBL_MAX +DBL_MAX

/**
 * The node anchor types.
 * @type DLLayoutSizeType
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutAnchorTypeLength = 1
} DLLayoutAnchorType;

/**
 * The node anchor units.
 * @type DLLayoutAnchorUnit
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutAnchorUnitPC = 1
} DLLayoutAnchorUnit;

/**
 * The node size types.
 * @type DLLayoutSizeType
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutSizeTypeFill = 1,
	kDLLayoutSizeTypeWrap = 2,
	kDLLayoutSizeTypeLength = 3
} DLLayoutSizeType;

/**
 * The node size units.
 * @type DLLayoutSizeUnit
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutSizeUnitNone = 1,
	kDLLayoutSizeUnitPX = 2,
	kDLLayoutSizeUnitPC = 3,
	kDLLayoutSizeUnitVW = 4,
	kDLLayoutSizeUnitVH = 5,
	kDLLayoutSizeUnitPW = 6,
	kDLLayoutSizeUnitPH = 7,
	kDLLayoutSizeUnitCW = 8,
	kDLLayoutSizeUnitCH = 9
} DLLayoutSizeUnit;

/**
 * The node position types.
 * @type DLLayoutPositionType
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutPositionTypeAuto = 1,
	kDLLayoutPositionTypeLength = 2
} DLLayoutPositionType;

/**
 * The node position units.
 * @type DLLayoutPositionUnit
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutPositionUnitNone = 1,
	kDLLayoutPositionUnitPX = 2,
	kDLLayoutPositionUnitPC = 3,
	kDLLayoutPositionUnitVW = 4,
	kDLLayoutPositionUnitVH = 5,
	kDLLayoutPositionUnitPW = 6,
	kDLLayoutPositionUnitPH = 7,
	kDLLayoutPositionUnitCW = 8,
	kDLLayoutPositionUnitCH = 9
} DLLayoutPositionUnit;

/**
 * The node content position values.
 * @type DLLayoutContentSize
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutContentPositionTypeLength = 1
} DLLayoutContentPositionType;

/**
 * The node content position units.
 * @type DLLayoutContentPositionUnit
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutContentPositionUnitNone = 1,
	kDLLayoutContentPositionUnitPX = 2
} DLLayoutContentPositionUnit;

/**
 * The node content size values.
 * @type DLLayoutContentSize
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutContentSizeTypeAuto = 1,
	kDLLayoutContentSizeTypeLength = 2,
} DLLayoutContentSizeType;

/**
 * The node content size units.
 * @type DLLayoutContentSizeUnit
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutContentSizeUnitNone = 1,
	kDLLayoutContentSizeUnitPX = 2,
	kDLLayoutContentSizeUnitPC = 3,
	kDLLayoutContentSizeUnitVW = 4,
	kDLLayoutContentSizeUnitVH = 5,
	kDLLayoutContentSizeUnitPW = 6,
	kDLLayoutContentSizeUnitPH = 7,
	kDLLayoutContentSizeUnitCW = 8,
	kDLLayoutContentSizeUnitCH = 9
} DLLayoutContentSizeUnit;

/**
 * The node content direction values.
 * @type DLLayoutContentOrientation
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutContentOrientationVertical = 1,
	kDLLayoutContentOrientationHorizontal = 2
} DLLayoutContentOrientation;

/**
 * The node content gravity values.
 * @type DLLayoutContentArrangement
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutContentLocationStart = 1,
	kDLLayoutContentLocationCenter = 2,
	kDLLayoutContentLocationEnd = 3,
	kDLLayoutContentLocationSpaceAround = 4,
	kDLLayoutContentLocationSpaceBetween = 5,
	kDLLayoutContentLocationSpaceEvenly = 6
} DLLayoutContentLocation;

/**
 * The node content alignment values.
 * @type DLLayoutContentArrangement
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutContentArrangementStart = 1,
	kDLLayoutContentArrangementCenter = 2,
	kDLLayoutContentArrangementEnd = 3,
} DLLayoutContentArrangement;

/**
 * The node margin types.
 * @type DLLayoutMarginType
 * @since 0.1.0
 */
typedef enum {
    kDLLayoutBorderTypeLength = 1
} DLLayoutBorderType;

/**
 * The node border units.
 * @type DLLayoutBorderUnit
 * @since 0.1.0
 */
typedef enum {
    kDLLayoutBorderUnitPX = 1,
    kDLLayoutBorderUnitPC = 2,
    kDLLayoutBorderUnitVW = 3,
    kDLLayoutBorderUnitVH = 4,
	kDLLayoutBorderUnitPW = 5,
	kDLLayoutBorderUnitPH = 6,
	kDLLayoutBorderUnitCW = 7,
	kDLLayoutBorderUnitCH = 8
} DLLayoutBorderUnit;

/**
 * The node margin types.
 * @type DLLayoutMarginType
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutMarginTypeLength = 1
} DLLayoutMarginType;

/**
 * The node margin units.
 * @type DLLayoutMarginUnit
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutMarginUnitPX = 1,
	kDLLayoutMarginUnitPC = 2,
	kDLLayoutMarginUnitVW = 3,
	kDLLayoutMarginUnitVH = 4,
	kDLLayoutMarginUnitPW = 5,
	kDLLayoutMarginUnitPH = 6,
	kDLLayoutMarginUnitCW = 7,
	kDLLayoutMarginUnitCH = 8
} DLLayoutMarginUnit;

/**
 * The node padding types.
 * @type DLLayoutPaddingType
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutPaddingTypeLength = 1
} DLLayoutPaddingType;

/**
 * The node padding units.
 * @type DLLayoutPaddingUnit
 * @since 0.1.0
 */
typedef enum {
	kDLLayoutPaddingUnitPX = 1,
	kDLLayoutPaddingUnitPC = 2,
	kDLLayoutPaddingUnitVW = 3,
	kDLLayoutPaddingUnitVH = 4,
	kDLLayoutPaddingUnitPW = 5,
	kDLLayoutPaddingUnitPH = 6,
	kDLLayoutPaddingUnitCW = 7,
	kDLLayoutPaddingUnitCH = 8
} DLLayoutPaddingUnit;

/**
 * The node anchor specification.
 * @typedef DLLayoutAnchor
 * @since 0.1.0
 */
typedef struct OpaqueDLLayoutAnchor DLLayoutAnchor;

/**
 * The node position specification.
 * @typedef DLLayoutPosition
 * @since 0.1.0
 */
typedef struct OpaqueDLLayoutPosition DLLayoutPosition;

/**
 * The node size specification.
 * @typedef DLLayoutSize
 * @since 0.1.0
 */
typedef struct OpaqueDLLayoutSize DLLayoutSize;

/**
 * The node content position specification.
 * @typedef DLLayoutContentPosition
 * @since 0.1.0
 */
typedef struct OpaqueDLLayoutContentPosition DLLayoutContentPosition;

/**
 * The node content size specification.
 * @typedef DLLayoutContentSize
 * @since 0.1.0
 */
typedef struct OpaqueDLLayoutContentSize DLLayoutContentSize;

/**
 * The node margin specification.
 * @typedef DLLayoutBorder
 * @since 0.1.0
 */
typedef struct OpaqueDLLayoutBorder DLLayoutBorder;

/**
 * The node margin specification.
 * @typedef DLLayoutMargin
 * @since 0.1.0
 */
typedef struct OpaqueDLLayoutMargin DLLayoutMargin;

/**
 * The node padding specification.
 * @typedef DLLayoutPadding
 * @since 0.1.0
 */
typedef struct OpaqueDLLayoutPadding DLLayoutPadding;

/**
 * A layout layout object.
 * @typedef DLLayout
 * @since 0.1.0
 */
typedef struct OpaqueDLLayout DLLayout;

/**
 * A reference to a layout layout object.
 * @typedef DLLayoutRef
 * @since 0.1.0
 */
typedef struct OpaqueDLLayout* DLLayoutRef;

/**
 * A node object.
 * @typedef DLLayoutNode
 * @since 0.1.0
 */
typedef struct OpaqueDLLayoutNode DLLayoutNode;

/**
 * A reference to a node object.
 * @typedef DLLayoutNodeRef
 * @since 0.1.0
 */
typedef struct OpaqueDLLayoutNode* DLLayoutNodeRef;

/**
 * A size structure.
 * @typedef DLLayoutNodeMeasure
 * @since 0.1.0
 */
typedef struct DLLayoutNodeMeasure {
	double width;
	double height;
} DLLayoutNodeMeasure;

/**
 * The node callback called when the node needs to be measured.
 * @typedef DLLayoutNodeMeasureCallback
 * @since 0.1.0
 */
typedef void (*DLLayoutNodeMeasureCallback)(DLLayoutNodeRef node, DLLayoutNodeMeasure *size, double w, double h, double minw, double maxw, double minh, double maxh);

/**
 * The node resolve callback.
 * @typedef DLLayoutNodeResolveCallback
 * @since 0.1.0
 */
typedef void (*DLLayoutNodeResolveCallback)(DLLayoutNodeRef node);

/**
 * The node prepare callback.
 * @typedef DLLayoutNodePrepareCallback
 * @since 0.1.0
 */
typedef void (*DLLayoutNodePrepareCallback)(DLLayoutNodeRef node);

/**
 * The node callback before the layout is computed.
 * @typedef DLLayoutNodeBeganCallback
 * @since 0.1.0
 */
typedef void (*DLLayoutNodeBeganCallback)(DLLayoutNodeRef node);

/**
 * The node resolved completed callback.
 * @typedef DLLayoutNodeEndedCallback
 * @since 0.1.0
 */
typedef void (*DLLayoutNodeEndedCallback)(DLLayoutNodeRef node);

/**
 * The node callback called when the node layout is invalidated.
 * @typedef DLLayoutNodeInvalidateCallback
 * @since 0.1.0
 */
typedef void (*DLLayoutNodeInvalidateCallback)(DLLayoutNodeRef node);

#if __cplusplus
extern "C" {
#endif

/**
 * Creates a layout node.
 * @function DLLayoutNodeCreate;
 * @since 0.1.0
 */
DLLayoutNodeRef DLLayoutNodeCreate();

/**
 * Releases a layout node.
 * @function DLLayoutNodeDelete
 * @since 0.1.0
 */
void DLLayoutNodeDelete(DLLayoutNodeRef node);

/**
 * Assigns the layout node's layout.
 * @function DLLayoutNodeSetLayout
 * @since 0.4.0
 */
void DLLayoutNodeSetLayout(DLLayoutNodeRef node, DLLayoutRef layout);

/**
 * Assigns the layout node's identifier.
 * @function DLLayoutNodeSetId
 * @since 0.1.0
 */
void DLLayoutNodeSetId(DLLayoutNodeRef node, const char* id);

/**
 * Indicates whether this layout node is the root node.
 * @function DLLayoutNodeSetRoot
 * @since 0.1.0
 */
void DLLayoutNodeSetRoot(DLLayoutNodeRef node, bool root);

/**
 * Assigns the layout node's top anchor position.
 * @function DLLayoutNodeSetAnchorTop
 * @since 0.1.0
 */
void DLLayoutNodeSetAnchorTop(DLLayoutNodeRef node, DLLayoutAnchorType type, DLLayoutAnchorUnit unit, double length);

/**
 * Assigns the layout node's left anchor position.
 * @function DLLayoutNodeSetAnchorLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetAnchorLeft(DLLayoutNodeRef node, DLLayoutAnchorType type, DLLayoutAnchorUnit unit, double length);

/**
 * Assigns the layout node's top position specification.
 * @function DLLayoutNodeSetTop
 * @since 0.1.0
 */
void DLLayoutNodeSetTop(DLLayoutNodeRef node, DLLayoutPositionType type, DLLayoutPositionUnit unit, double length);

/**
 * Assigns the layout node's minimum top position.
 * @function DLLayoutNodeSetMinTop
 * @since 0.1.0
 */
void DLLayoutNodeSetMinTop(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum top position.
 * @function DLLayoutNodeSetMaxTop
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxTop(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's left position specification.
 * @function DLLayoutNodeSetLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetLeft(DLLayoutNodeRef node, DLLayoutPositionType type, DLLayoutPositionUnit unit, double length);

/**
 * Assigns the layout node's minimum left position.
 * @function DLLayoutNodeSetMinLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetMinLeft(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum left position.
 * @function DLLayoutNodeSetMaxLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxLeft(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's right position specification.
 * @function DLLayoutNodeSetRight
 * @since 0.1.0
 */
void DLLayoutNodeSetRight(DLLayoutNodeRef node, DLLayoutPositionType type, DLLayoutPositionUnit unit, double length);

/**
 * Assigns the layout node's minimum right position.
 * @function DLLayoutNodeSetMinRight
 * @since 0.1.0
 */
void DLLayoutNodeSetMinRight(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum right position.
 * @function DLLayoutNodeSetMaxRight
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxRight(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's bottom position specification.
 * @function DLLayoutNodeSetBottom
 * @since 0.1.0
 */
void DLLayoutNodeSetBottom(DLLayoutNodeRef node, DLLayoutPositionType type, DLLayoutPositionUnit unit, double length);

/**
 * Assigns the layout node's minimum bottom position.
 * @function DLLayoutNodeSetMinBottom
 * @since 0.1.0
 */
void DLLayoutNodeSetMinBottom(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum bottom position.
 * @function DLLayoutNodeSetMaxBottom
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxBottom(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's width specification.
 * @function DLLayoutNodeSetWidth
 * @since 0.1.0
 */
void DLLayoutNodeSetWidth(DLLayoutNodeRef node, DLLayoutSizeType type, DLLayoutSizeUnit unit, double length);

/**
 * Assigns the layout node's minimum width.
 * @function DLLayoutNodeSetMinWidth
 * @since 0.1.0
 */
void DLLayoutNodeSetMinWidth(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum width.
 * @function DLLayoutNodeSetMaxWidth
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxWidth(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's height specification.
 * @function DLLayoutNodeSetHeight
 * @since 0.1.0
 */
void DLLayoutNodeSetHeight(DLLayoutNodeRef node, DLLayoutSizeType type, DLLayoutSizeUnit unit, double length);

/**
 * Assigns the layout node's minimum width.
 * @function DLLayoutNodeSetMinHeight
 * @since 0.1.0
 */
void DLLayoutNodeSetMinHeight(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum width.
 * @function DLLayoutNodeSetMaxHeight
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxHeight(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's content direction specification.
 * @function DLLayoutNodeSetContentOrientation
 * @since 0.1.0
 */
void DLLayoutNodeSetContentOrientation(DLLayoutNodeRef node, DLLayoutContentOrientation direction);

/**
 * Assigns the layout node's content gravity specification.
 * @function DLLayoutNodeSetContentLocation
 * @since 0.1.0
 */
void DLLayoutNodeSetContentLocation(DLLayoutNodeRef node, DLLayoutContentLocation placement);

/**
 * Assigns the layout node's content alignment specification.
 * @function DLLayoutNodeSetContentArrangement
 * @since 0.1.0
 */
void DLLayoutNodeSetContentArrangement(DLLayoutNodeRef node, DLLayoutContentArrangement alignment);

/**
 * Assigns the layout node's content top specification.
 * @function DLLayoutNodeSetContentTop
 * @since 0.1.0
 */
void DLLayoutNodeSetContentTop(DLLayoutNodeRef node, DLLayoutContentPositionType type, DLLayoutContentPositionUnit unit, double length);

/**
 * Assigns the layout node's content left specification.
 * @function DLLayoutNodeSetContentLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetContentLeft(DLLayoutNodeRef node, DLLayoutContentPositionType type, DLLayoutContentPositionUnit unit, double length);

/**
 * Assigns the layout node's content width specification.
 * @function DLLayoutNodeSetContentWidth
 * @since 0.1.0
 */
void DLLayoutNodeSetContentWidth(DLLayoutNodeRef node, DLLayoutContentSizeType type, DLLayoutContentSizeUnit unit, double length);

/**
 * Assigns the layout node's content height specification.
 * @function DLLayoutNodeSetContentHeight
 * @since 0.1.0
 */
void DLLayoutNodeSetContentHeight(DLLayoutNodeRef node, DLLayoutContentSizeType type, DLLayoutContentSizeUnit unit, double length);

/**
 * Assigns whether the layout node's can expand to fill remaining space.
 * @function DLLayoutNodeSetExpand
 * @since 0.1.0
 */
void DLLayoutNodeSetExpand(DLLayoutNodeRef node, double ratio);

/**
 * Assigns whether the layout node's can shrint to fit existing space.
 * @function DLLayoutNodeSetShrinkable
 * @since 0.1.0
 */
void DLLayoutNodeSetShrink(DLLayoutNodeRef node, double ratio);

/**
 * Assigns the layout node's border top specification.
 * @function DLLayoutNodeSetBorderTop
 * @since 0.1.0
 */
void DLLayoutNodeSetBorderTop(DLLayoutNodeRef node, DLLayoutBorderType type, DLLayoutBorderUnit unit, double length);

/**
 * Assigns the layout node's border left specification.
 * @function DLLayoutNodeSetBorderLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetBorderLeft(DLLayoutNodeRef node, DLLayoutBorderType type, DLLayoutBorderUnit unit, double length);

/**
 * Assigns the layout node's border right specification.
 * @function DLLayoutNodeSetBorderRight
 * @since 0.1.0
 */
void DLLayoutNodeSetBorderRight(DLLayoutNodeRef node, DLLayoutBorderType type, DLLayoutBorderUnit unit, double length);

/**
 * Assigns the layout node's border bottom specification.
 * @function DLLayoutNodeSetBorderBottom
 * @since 0.1.0
 */
void DLLayoutNodeSetBorderBottom(DLLayoutNodeRef node, DLLayoutBorderType type, DLLayoutBorderUnit unit, double length);

/**
 * Assigns the layout node's margin top specification.
 * @function DLLayoutNodeSetMarginTop
 * @since 0.1.0
 */
void DLLayoutNodeSetMarginTop(DLLayoutNodeRef node, DLLayoutMarginType type, DLLayoutMarginUnit unit, double length);

/**
 * Assigns the layout node's margin left specification.
 * @function DLLayoutNodeSetMarginLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetMarginLeft(DLLayoutNodeRef node, DLLayoutMarginType type, DLLayoutMarginUnit unit, double length);

/**
 * Assigns the layout node's margin right specification.
 * @function DLLayoutNodeSetMarginRight
 * @since 0.1.0
 */
void DLLayoutNodeSetMarginRight(DLLayoutNodeRef node, DLLayoutMarginType type, DLLayoutMarginUnit unit, double length);

/**
 * Assigns the layout node's margin bottom specification.
 * @function DLLayoutNodeSetMarginBottom
 * @since 0.1.0
 */
void DLLayoutNodeSetMarginBottom(DLLayoutNodeRef node, DLLayoutMarginType type, DLLayoutMarginUnit unit, double length);

/**
 * Assigns the layout node's minimum top margin.
 * @function DLLayoutNodeSetMinMarginTop
 * @since 0.1.0
 */
void DLLayoutNodeSetMinMarginTop(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum top margin.
 * @function DLLayoutNodeSetMaxMarginTop
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxMarginTop(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's minimum left margin.
 * @function DLLayoutNodeSetMinMarginLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetMinMarginLeft(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum left margin.
 * @function DLLayoutNodeSetMaxMarginLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxMarginLeft(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's minimum right margin.
 * @function DLLayoutNodeSetMinMarginRight
 * @since 0.1.0
 */
void DLLayoutNodeSetMinMarginRight(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum right margin.
 * @function DLLayoutNodeSetMaxMarginRight
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxMarginRight(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's minimum bottom margin.
 * @function DLLayoutNodeSetMinMarginBottom
 * @since 0.1.0
 */
void DLLayoutNodeSetMinMarginBottom(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum bottom margin.
 * @function DLLayoutNodeSetMaxMarginBottom
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxMarginBottom(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's padding top specification.
 * @function DLLayoutNodeSetPaddingTop
 * @since 0.1.0
 */
void DLLayoutNodeSetPaddingTop(DLLayoutNodeRef node, DLLayoutPaddingType type, DLLayoutPaddingUnit unit, double length);

/**
 * Assigns the layout node's padding left specification.
 * @function DLLayoutNodeSetPaddingLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetPaddingLeft(DLLayoutNodeRef node, DLLayoutPaddingType type, DLLayoutPaddingUnit unit, double length);

/**
 * Assigns the layout node's padding right specification.
 * @function DLLayoutNodeSetPaddingRight
 * @since 0.1.0
 */
void DLLayoutNodeSetPaddingRight(DLLayoutNodeRef node, DLLayoutPaddingType type, DLLayoutPaddingUnit unit, double length);

/**
 * Assigns the layout node's padding bottom specification.
 * @function DLLayoutNodeSetPaddingBottom
 * @since 0.1.0
 */
void DLLayoutNodeSetPaddingBottom(DLLayoutNodeRef node, DLLayoutPaddingType type, DLLayoutPaddingUnit unit, double length);

/**
 * Assigns the layout node's minimum top padding.
 * @function DLLayoutNodeSetMinPaddingTop
 * @since 0.1.0
 */
void DLLayoutNodeSetMinPaddingTop(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum top padding.
 * @function DLLayoutNodeSetMaxPaddingTop
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxPaddingTop(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's minimum left padding.
 * @function DLLayoutNodeSetMinPaddingLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetMinPaddingLeft(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum left padding.
 * @function DLLayoutNodeSetMaxPaddingLeft
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxPaddingLeft(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's minimum right padding.
 * @function DLLayoutNodeSetMinPaddingRight
 * @since 0.1.0
 */
void DLLayoutNodeSetMinPaddingRight(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum right padding.
 * @function DLLayoutNodeSetMaxPaddingRight
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxPaddingRight(DLLayoutNodeRef node, double max);

/**
 * Assigns the layout node's minimum bottom padding.
 * @function DLLayoutNodeSetMinPaddingBottom
 * @since 0.1.0
 */
void DLLayoutNodeSetMinPaddingBottom(DLLayoutNodeRef node, double min);

/**
 * Assigns the layout node's maximum bottom padding.
 * @function DLLayoutNodeSetMaxPaddingBottom
 * @since 0.1.0
 */
void DLLayoutNodeSetMaxPaddingBottom(DLLayoutNodeRef node, double max);

/**
 * Returns whether the node's width has been set to fill its parent.
 * @function DLLayoutNodeFillsParentWidth
 * @since 0.1.0
 */
bool DLLayoutNodeFillsParentWidth(DLLayoutNodeRef node);

/**
 * Returns whether the node's height has been set to fill its parent.
 * @function DLLayoutNodeFillsParentHeight
 * @since 0.1.0
 */
bool DLLayoutNodeFillsParentHeight(DLLayoutNodeRef node);

/**
 * Returns whether the node's width has been set to wraps its content.
 * @function DLLayoutNodeWrapsContentWidth
 * @since 0.1.0
 */
bool DLLayoutNodeWrapsContentWidth(DLLayoutNodeRef node);

/**
 * Returns whether the node's height has been set to wraps its content.
 * @function DLLayoutNodeWrapsContentHeight
 * @since 0.1.0
 */
bool DLLayoutNodeWrapsContentHeight(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured top.
 * @function DLLayoutNodeGetMeasuredTop
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredTop(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured left.
 * @function DLLayoutNodeGetMeasuredLeft
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredLeft(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured right.
 * @function DLLayoutNodeGetMeasuredRight
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredRight(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured bottom.
 * @function DLLayoutNodeGetMeasuredBottom
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredBottom(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured width.
 * @function DLLayoutNodeGetMeasuredWidth
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredWidth(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured height.
 * @function DLLayoutNodeGetMeasuredHeight
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredHeight(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured inner width;
 * @function DLLayoutNodeGetMeasuredInnerWidth
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredInnerWidth(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured inner height;
 * @function DLLayoutNodeGetMeasuredInnerHeight
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredInnerHeight(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured content width.
 * @function DLLayoutNodeGetMeasuredContentWidth
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredContentWidth(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured content height.
 * @function DLLayoutNodeGetMeasuredContentHeight
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredContentHeight(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured margin top.
 * @function DLLayoutNodeGetMeasuredMarginTop
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredMarginTop(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured border top.
 * @function DLLayoutNodeGetMeasuredBorderTop
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredBorderTop(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured border left.
 * @function DLLayoutNodeGetMeasuredBorderLeft
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredBorderLeft(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured border right.
 * @function DLLayoutNodeGetMeasuredBorderRight
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredBorderRight(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured border bottom.
 * @function DLLayoutNodeGetMeasuredBorderBottom
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredBorderBottom(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured margin left.
 * @function DLLayoutNodeGetMeasuredMarginLeft
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredMarginLeft(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured margin right.
 * @function DLLayoutNodeGetMeasuredMarginRight
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredMarginRight(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured margin bottom.
 * @function DLLayoutNodeGetMeasuredMarginBottom
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredMarginBottom(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured padding top.
 * @function DLLayoutNodeGetMeasuredPaddingTop
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredPaddingTop(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured padding left.
 * @function DLLayoutNodeGetMeasuredPaddingLeft
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredPaddingLeft(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured padding right.
 * @function DLLayoutNodeGetMeasuredPaddingRight
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredPaddingRight(DLLayoutNodeRef node);

/**
 * Returns the layout node's measured padding bottom.
 * @function DLLayoutNodeGetMeasuredPaddingBottom
 * @since 0.1.0
 */
double DLLayoutNodeGetMeasuredPaddingBottom(DLLayoutNodeRef node);

/**
 * Returns the layout node's viewport width.
 * @function DLLayoutNodeGetViewportWidth
 * @since 0.1.0
 */
double DLLayoutNodeGetViewportWidth(DLLayoutNodeRef node);

/**
 * Returns the layout node's viewport width.
 * @function DLLayoutNodeGetViewportHeight
 * @since 0.1.0
 */
double DLLayoutNodeGetViewportHeight(DLLayoutNodeRef node);

/**
 * Assigns whether the node is visible.
 * @function DLLayoutNodeSetVisible
 * @since 0.1.0
 */
void DLLayoutNodeSetVisible(DLLayoutNodeRef node, bool visible);

/**
 * Appends a node to the receiver's children list.
 * @function DLLayoutNodeInsertChild
 * @since 0.1.0
 */
void DLLayoutNodeAppendChild(DLLayoutNodeRef node, DLLayoutNodeRef child);

/**
 * Inserts a node to the receiver's children list.
 * @function DLLayoutNodeInsertChild
 * @since 0.1.0
 */
void DLLayoutNodeInsertChild(DLLayoutNodeRef node, DLLayoutNodeRef child, int index);

/**
 * Appends a node to the receiver's children list.
 * @function DLLayoutNodeRemoveChild
 * @since 0.1.0
 */
void DLLayoutNodeRemoveChild(DLLayoutNodeRef node, DLLayoutNodeRef child);

/**
 * Marks the layout node's size as invalid.
 * @function DLLayoutNodeInvalidateSize
 * @since 0.1.0
 */
void DLLayoutNodeInvalidateSize(DLLayoutNodeRef node);

/**
 * Marks the layout node's position as invalid.
 * @function DLLayoutNodeInvalidatePosition
 * @since 0.1.0
 */
void DLLayoutNodeInvalidatePosition(DLLayoutNodeRef node);

/**
 * Marks the layout node's inner size as invalid.
 * @function DLLayoutNodeInvalidateInnerSize
 * @since 0.1.0
 */
void DLLayoutNodeInvalidateInnerSize(DLLayoutNodeRef node);

/**
 * Marks the layout node's content bounds as invalid.
 * @function DLLayoutNodeInvalidateContentSize
 * @since 0.2.0
 */
void DLLayoutNodeInvalidateContentSize(DLLayoutNodeRef node);

/**
 * Marks the layout node's content bounds as invalid.
 * @function DLLayoutNodeInvalidateContentPosition
 * @since 0.2.0
 */
void DLLayoutNodeInvalidateContentPosition(DLLayoutNodeRef node);

/**
 * Marks the layout node's margin as invalid.
 * @function DLLayoutNodeInvalidateMargin
 * @since 0.2.0
 */
void DLLayoutNodeInvalidateMargin(DLLayoutNodeRef node);

/**
 * Marks the layout node's border as invalid.
 * @function DLLayoutNodeInvalidateBorder
 * @since 0.2.0
 */
void DLLayoutNodeInvalidateBorder(DLLayoutNodeRef node);

/**
 * Marks the layout node's padding invalid.
 * @function DLLayoutNodeInvalidatePadding
 * @since 0.2.0
 */
void DLLayoutNodeInvalidatePadding(DLLayoutNodeRef node);

/**
 * Marks the layout node's layout as invalid.
 * @function DLLayoutNodeInvalidateLayout
 * @since 0.1.0
 */
void DLLayoutNodeInvalidateLayout(DLLayoutNodeRef node);

/**
 * Invalidates the layout of the node's parent.
 * @function DLLayoutNodeInvalidateParentLayout
 * @since 0.1.0
 */
void DLLayoutNodeInvalidateParentLayout(DLLayoutNodeRef node);

/**
 * Resolves layouts until the specified node is resolved.
 * @function DLLayoutNodeResolve
 * @since 0.1.0
 */
void DLLayoutNodeResolve(DLLayoutNodeRef node);

/**
 * Resolves layouts recursively from a starting point.
 * @function DLLayoutNodeResolveTree
 * @since 0.1.0
 */
void DLLayoutNodeResolveTree(DLLayoutNodeRef node);

/**
 * Resoles the size of the root node.
 * @function DLLayoutNodeResolveRoot
 * @since 0.1.0
 */
void DLLayoutNodeResolveRoot(DLLayoutNodeRef node);

/**
 * Resolves the layout if its invalid.
 * @function DLLayoutNodeResolveLayout
 * @since 0.1.0
 */
void DLLayoutNodeResolveLayout(DLLayoutNodeRef node);

/**
 * Resolves the layout.
 * @function DLLayoutNodeResolveLayout
 * @since 0.1.0
 */
void DLLayoutNodePerformLayout(DLLayoutNodeRef node);

/**
 * Resolves the layout node in a specified size.
 * @function DLLayoutNodeResolveIn
 * @since 0.1.0
 */
void DLLayoutNodeResolveSelf(DLLayoutNodeRef node);

/**
 * Indicates whether the layout node's layout is marked as invalid.
 * @function DLLayoutNodeHasInvalidLayout
 * @since 0.1.0
 */
bool DLLayoutNodeHasInvalidLayout(DLLayoutNodeRef node);

/**
 * Indicates whether the layout node's size is marked as invalid.
 * @function DLLayoutNodeHasInvalidBounds
 * @since 0.1.0
 */
bool DLLayoutNodeHasInvalidSize(DLLayoutNodeRef node);

/**
 * Indicates whether the layout node's position is marked as invalid.
 * @function DLLayoutNodeHasInvalidOffset
 * @since 0.1.0
 */
bool DLLayoutNodeHasInvalidPosition(DLLayoutNodeRef node);

/**
 * Assigns the callback that is called when the layout is about to begin.
 * @function DLLayoutNodeSetPrepareCallback
 * @since 0.1.0
 */
void DLLayoutNodeSetPrepareCallback(DLLayoutNodeRef node, DLLayoutNodePrepareCallback callback);

/**
 * Assigns the callback that is called when the node needs to retrieve its natural size.s
 * @function DLLayoutNodeSetMeasureCallback
 * @since 0.1.0
 */
void DLLayoutNodeSetMeasureCallback(DLLayoutNodeRef node, DLLayoutNodeMeasureCallback callback);

/**
 * Assigns the callback that is called when the node size changes.
 * @function DLLayoutNodeSetResolveSizeCallback
 * @since 0.2.0
 */
void DLLayoutNodeSetResolveSizeCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node position changes.
 * @function DLLayoutNodeSetResolvePositionCallback
 * @since 0.2.0
 */
void DLLayoutNodeSetResolvePositionCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node inner size changes.
 * @function DLLayoutNodeSetResolveInnerSizeCallback
 * @since 0.2.0
 */
void DLLayoutNodeSetResolveInnerSizeCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node content size changes.
 * @function DLLayoutNodeSetResolveContentSizeCallback
 * @since 0.2.0
 */
void DLLayoutNodeSetResolveContentSizeCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node margin changes.
 * @function DLLayoutNodeSetResolveMarginCallback
 * @since 0.1.0
 */
void DLLayoutNodeSetResolveMarginCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node border changes.
 * @function DLLayoutNodeSetResolveBorderCallback
 * @since 0.1.0
 */
void DLLayoutNodeSetResolveBorderCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback);

/**
 * Assigns the callback that is called when the node padding changes.
 * @function DLLayoutNodeSetResolvePaddingCallback
 * @since 0.1.0
 */
void DLLayoutNodeSetResolvePaddingCallback(DLLayoutNodeRef node, DLLayoutNodeResolveCallback callback);

/**
 * Assigns the callback that is called once a node begins its layout.
 * @function DLLayoutNodeSetLayoutBeganCallback
 * @since 0.1.0
 */
void DLLayoutNodeSetLayoutBeganCallback(DLLayoutNodeRef node, DLLayoutNodeBeganCallback callback);

/**
 * Assigns the callback that is called once a node completes its layout.
 * @function DLLayoutNodeSetLayoutEndedCallback
 * @since 0.1.0
 */
void DLLayoutNodeSetLayoutEndedCallback(DLLayoutNodeRef node, DLLayoutNodeEndedCallback callback);

/**
 * Assigns the callback that is called when a node layout is invalidated.
 * @function DLLayoutNodeInvalidateCallback
 * @since 0.1.0
 */
void DLLayoutNodeSetInvalidateCallback(DLLayoutNodeRef node, DLLayoutNodeInvalidateCallback callback);

/**
 * Assigns the layout node's user data.
 * @function DLLayoutNodeSetData
 * @since 0.1.0
 */
void DLLayoutNodeSetData(DLLayoutNodeRef node, void *data);

/**
 * Returns the layout node's user data.
 * @function DLLayoutNodeSetData
 * @since 0.1.0
 */
void *DLLayoutNodeGetData(DLLayoutNodeRef node);

// TODO TEST
int DLLayoutNodeGetResolveSizeCount(DLLayoutNodeRef node);
int DLLayoutNodeGetResolvePositionCount(DLLayoutNodeRef node);

#if __cplusplus
}
#endif
#endif
