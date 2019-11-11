#ifndef DisplayBase_h
#define DisplayBase_h

#include <float.h>

#define ABS_DBL_MIN -DBL_MAX
#define ABS_DBL_MAX +DBL_MAX

/**
 * An opaque display reference.
 * @typedef DisplayRef
 * @since 0.7.0
 */
typedef struct OpaqueDisplay* DisplayRef;

/**
 * An opaque display node reference.
 * @typedef DisplayNode
 * @since 0.7.0
 */
typedef struct OpaqueDisplayNode* DisplayNodeRef;

/**
 * @typedef DisplayNodePropertyRef
 * @since 0.7.0
 * @hidden
 */
typedef struct OpaqueDisplayNodeProperty* DisplayNodePropertyRef;

/**
 * @typedef DisplayNodePropertyRef
 * @since 0.7.0
 * @hidden
 */
typedef struct OpaqueDisplayNodePropertyValue* DisplayNodePropertyValueRef;

/**
 * The node anchor types.
 * @type DisplayNodeSizeType
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeAnchorTypeLength = 1
} DisplayNodeAnchorType;

/**
 * The node anchor units.
 * @type DisplayNodeAnchorUnit
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeAnchorUnitPC = 1
} DisplayNodeAnchorUnit;

/**
 * The node size types.
 * @type DisplayNodeSizeType
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeSizeTypeFill = 1,
	kDisplayNodeSizeTypeWrap = 2,
	kDisplayNodeSizeTypeLength = 3
} DisplayNodeSizeType;

/**
 * The node size units.
 * @type DisplayNodeSizeUnit
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeSizeUnitNone = 1,
	kDisplayNodeSizeUnitPX = 2,
	kDisplayNodeSizeUnitPC = 3,
	kDisplayNodeSizeUnitVW = 4,
	kDisplayNodeSizeUnitVH = 5,
	kDisplayNodeSizeUnitPW = 6,
	kDisplayNodeSizeUnitPH = 7,
	kDisplayNodeSizeUnitCW = 8,
	kDisplayNodeSizeUnitCH = 9
} DisplayNodeSizeUnit;

/**
 * The node position types.
 * @type DisplayNodeOriginType
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeOriginTypeAuto = 1,
	kDisplayNodeOriginTypeLength = 2
} DisplayNodeOriginType;

/**
 * The node position units.
 * @type DisplayNodeOriginUnit
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeOriginUnitNone = 1,
	kDisplayNodeOriginUnitPX = 2,
	kDisplayNodeOriginUnitPC = 3,
	kDisplayNodeOriginUnitVW = 4,
	kDisplayNodeOriginUnitVH = 5,
	kDisplayNodeOriginUnitPW = 6,
	kDisplayNodeOriginUnitPH = 7,
	kDisplayNodeOriginUnitCW = 8,
	kDisplayNodeOriginUnitCH = 9
} DisplayNodeOriginUnit;

/**
 * The node content position values.
 * @type DisplayNodeContentSize
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeContentOriginTypeLength = 1
} DisplayNodeContentOriginType;

/**
 * The node content position units.
 * @type DisplayNodeContentOriginUnit
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeContentOriginUnitNone = 1,
	kDisplayNodeContentOriginUnitPX = 2
} DisplayNodeContentOriginUnit;

/**
 * The node content size values.
 * @type DisplayNodeContentSize
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeContentSizeTypeAuto = 1,
	kDisplayNodeContentSizeTypeLength = 2,
} DisplayNodeContentSizeType;

/**
 * The node content size units.
 * @type DisplayNodeContentSizeUnit
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeContentSizeUnitNone = 1,
	kDisplayNodeContentSizeUnitPX = 2,
	kDisplayNodeContentSizeUnitPC = 3,
	kDisplayNodeContentSizeUnitVW = 4,
	kDisplayNodeContentSizeUnitVH = 5,
	kDisplayNodeContentSizeUnitPW = 6,
	kDisplayNodeContentSizeUnitPH = 7,
	kDisplayNodeContentSizeUnitCW = 8,
	kDisplayNodeContentSizeUnitCH = 9
} DisplayNodeContentSizeUnit;

/**
 * The node content direction values.
 * @type DisplayNodeContentDirection
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeContentDirectionVertical = 1,
	kDisplayNodeContentDirectionHorizontal = 2
} DisplayNodeContentDirection;

/**
 * The node content gravity values.
 * @type DisplayNodeContentAlignment
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeContentDispositionStart = 1,
	kDisplayNodeContentDispositionCenter = 2,
	kDisplayNodeContentDispositionEnd = 3,
	kDisplayNodeContentDispositionSpaceAround = 4,
	kDisplayNodeContentDispositionSpaceBetween = 5,
	kDisplayNodeContentDispositionSpaceEvenly = 6
} DisplayNodeContentDisposition;

/**
 * The node content alignment values.
 * @type DisplayNodeContentAlignment
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeContentAlignmentStart = 1,
	kDisplayNodeContentAlignmentCenter = 2,
	kDisplayNodeContentAlignmentEnd = 3,
} DisplayNodeContentAlignment;

/**
 * The node margin types.
 * @type DisplayNodeMarginType
 * @since 0.7.0
 */
typedef enum {
    kDisplayNodeBorderTypeLength = 1
} DisplayNodeBorderType;

/**
 * The node border units.
 * @type DisplayNodeBorderUnit
 * @since 0.7.0
 */
typedef enum {
    kDisplayNodeBorderUnitPX = 1,
    kDisplayNodeBorderUnitPC = 2,
    kDisplayNodeBorderUnitVW = 3,
    kDisplayNodeBorderUnitVH = 4,
	kDisplayNodeBorderUnitPW = 5,
	kDisplayNodeBorderUnitPH = 6,
	kDisplayNodeBorderUnitCW = 7,
	kDisplayNodeBorderUnitCH = 8
} DisplayNodeBorderUnit;

/**
 * The node margin types.
 * @type DisplayNodeMarginType
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeMarginTypeLength = 1
} DisplayNodeMarginType;

/**
 * The node margin units.
 * @type DisplayNodeMarginUnit
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodeMarginUnitPX = 1,
	kDisplayNodeMarginUnitPC = 2,
	kDisplayNodeMarginUnitVW = 3,
	kDisplayNodeMarginUnitVH = 4,
	kDisplayNodeMarginUnitPW = 5,
	kDisplayNodeMarginUnitPH = 6,
	kDisplayNodeMarginUnitCW = 7,
	kDisplayNodeMarginUnitCH = 8
} DisplayNodeMarginUnit;

/**
 * The node padding types.
 * @type DisplayNodePaddingType
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodePaddingTypeLength = 1
} DisplayNodePaddingType;

/**
 * The node padding units.
 * @type DisplayNodePaddingUnit
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodePaddingUnitPX = 1,
	kDisplayNodePaddingUnitPC = 2,
	kDisplayNodePaddingUnitVW = 3,
	kDisplayNodePaddingUnitVH = 4,
	kDisplayNodePaddingUnitPW = 5,
	kDisplayNodePaddingUnitPH = 6,
	kDisplayNodePaddingUnitCW = 7,
	kDisplayNodePaddingUnitCH = 8
} DisplayNodePaddingUnit;

/**
 * The display node property value type.
 * @typeOf DisplayNodePropertyValueType
 * @since 0.7.0
 */
typedef enum DisplayNodePropertyValueType {
	kDisplayNodePropertyValueTypeNull,
	kDisplayNodePropertyValueTypeString,
	kDisplayNodePropertyValueTypeNumber,
	kDisplayNodePropertyValueTypeBoolean,
	kDisplayNodePropertyValueTypeFunction,
	kDisplayNodePropertyValueTypeVariable
} DisplayNodePropertyValueType;

/**
 * The display node property value unit.
 * @typeOf DisplayNodePropertyValueUnit
 * @since 0.7.0
 */
typedef enum {
	kDisplayNodePropertyValueUnitNone,
	kDisplayNodePropertyValueUnitPX,
	kDisplayNodePropertyValueUnitPC,
	kDisplayNodePropertyValueUnitVW,
	kDisplayNodePropertyValueUnitVH,
	kDisplayNodePropertyValueUnitPW,
	kDisplayNodePropertyValueUnitPH,
	kDisplayNodePropertyValueUnitCW,
	kDisplayNodePropertyValueUnitCH,
	kDisplayNodePropertyValueUnitDeg,
	kDisplayNodePropertyValueUnitRad
} DisplayNodePropertyValueUnit;

/**
 * A measured size structure.
 * @typedef DisplayNodeMeasuredSize
 * @since 0.7.0
 */
typedef struct DisplayNodeMeasuredSize {
	double width;
	double height;
} DisplayNodeMeasuredSize;

/**
 * The callback when the display is resolved.
 * @typedef DisplayResolveCallback
 * @since 0.7.0
 */
typedef void (*DisplayCallback)(DisplayRef display);

/**
 * The node callback called when the node needs to be measured.
 * @typedef DisplayNodeMeasureCallback
 * @since 0.7.0
 */
typedef void (*DisplayNodeMeasureCallback)(DisplayNodeRef node, DisplayNodeMeasuredSize* size, double w, double h, double minw, double maxw, double minh, double maxh);

/**
 * The node resolve callback.
 * @typedef DisplayNodeResolveCallback
 * @since 0.7.0
 */
typedef void (*DisplayNodeCallback)(DisplayNodeRef node);

/**
 * The node callback called when the node needs to be measured.
 * @typedef DisplayNodeMeasureCallback
 * @since 0.7.0
 */
typedef void (*DisplayNodeMeasureCallback)(DisplayNodeRef node, DisplayNodeMeasuredSize* size, double w, double h, double minw, double maxw, double minh, double maxh);

/**
 * The node callback called when the node needs to update a property.
 * @typedef DisplayNodeUpdateCallback
 * @since 0.7.0
 */
typedef void (*DisplayNodeUpdateCallback)(DisplayNodeRef node, DisplayNodePropertyRef property, const char* name);

#endif
