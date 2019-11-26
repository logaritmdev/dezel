#ifndef DisplayBase_h
#define DisplayBase_h

#include <float.h>

#define ABS_DBL_MIN -DBL_MAX
#define ABS_DBL_MAX +DBL_MAX

/**
 * @typedef DisplayRef
 * @since 0.7.0
 * @hidden
 */
typedef struct OpaqueDisplay* DisplayRef;

/**
 * @typedef DisplayNodeRef
 * @since 0.7.0
 * @hidden
 */
typedef struct OpaqueDisplayNode* DisplayNodeRef;

/**
 * @typedef PropertyRef
 * @since 0.7.0
 * @hidden
 */
typedef struct OpaqueProperty* PropertyRef;

/**
 * @typedef StylesheetRef
 * @since 0.7.0
 * @hidden
 */
typedef struct OpaqueStylesheet* StylesheetRef;

/**
* @typedef ParseError
* @since 0.7.0
* @hidden
*/
typedef struct {
	const char* message;
	const char* url;
	unsigned col;
	unsigned row;
} ParseError;

/**
 * @type DisplayNodeSizeType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kDisplayNodeAnchorTypeLength = 1
} DisplayNodeAnchorType;

/**
 * @type DisplayNodeAnchorUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kDisplayNodeAnchorUnitPC = 1
} DisplayNodeAnchorUnit;

/**
 * @type DisplayNodeSizeType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kDisplayNodeSizeTypeFill = 1,
	kDisplayNodeSizeTypeWrap = 2,
	kDisplayNodeSizeTypeLength = 3
} DisplayNodeSizeType;

/**
 * @type DisplayNodeSizeUnit
 * @since 0.7.0
 * @hidden
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
 * @type DisplayNodeOriginType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kDisplayNodeOriginTypeAuto = 1,
	kDisplayNodeOriginTypeLength = 2
} DisplayNodeOriginType;

/**
 * @type DisplayNodeOriginUnit
 * @since 0.7.0
 * @hidden
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
 * @type DisplayNodeContentSize
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kDisplayNodeContentOriginTypeLength = 1
} DisplayNodeContentOriginType;

/**
 * @type DisplayNodeContentOriginUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kDisplayNodeContentOriginUnitNone = 1,
	kDisplayNodeContentOriginUnitPX = 2
} DisplayNodeContentOriginUnit;

/**
 * @type DisplayNodeContentSize
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kDisplayNodeContentSizeTypeAuto = 1,
	kDisplayNodeContentSizeTypeLength = 2,
} DisplayNodeContentSizeType;

/**
 * @type DisplayNodeContentSizeUnit
 * @since 0.7.0
 * @hidden
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
 * @type DisplayNodeContentDirection
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kDisplayNodeContentDirectionVertical = 1,
	kDisplayNodeContentDirectionHorizontal = 2
} DisplayNodeContentDirection;

/**
 * @type DisplayNodeContentAlignment
 * @since 0.7.0
 * @hidden
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
 * @type DisplayNodeContentAlignment
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kDisplayNodeContentAlignmentStart = 1,
	kDisplayNodeContentAlignmentCenter = 2,
	kDisplayNodeContentAlignmentEnd = 3,
} DisplayNodeContentAlignment;

/**
 * @type DisplayNodeMarginType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
    kDisplayNodeBorderTypeLength = 1
} DisplayNodeBorderType;

/**
 * @type DisplayNodeBorderUnit
 * @since 0.7.0
 * @hidden
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
 * @type DisplayNodeMarginType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kDisplayNodeMarginTypeLength = 1
} DisplayNodeMarginType;

/**
 * @type DisplayNodeMarginUnit
 * @since 0.7.0
 * @hidden
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
 * @type DisplayNodePaddingType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kDisplayNodePaddingTypeLength = 1
} DisplayNodePaddingType;

/**
 * @type DisplayNodePaddingUnit
 * @since 0.7.0
 * @hidden
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
 * @typeOf PropertyValueType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kPropertyValueTypeNull,
	kPropertyValueTypeString,
	kPropertyValueTypeNumber,
	kPropertyValueTypeBoolean,
	kPropertyValueTypeFunction,
	kPropertyValueTypeVariable
} PropertyValueType;

/**
 * @typeOf PropertyValueUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kPropertyValueUnitNone,
	kPropertyValueUnitPX,
	kPropertyValueUnitPC,
	kPropertyValueUnitVW,
	kPropertyValueUnitVH,
	kPropertyValueUnitPW,
	kPropertyValueUnitPH,
	kPropertyValueUnitCW,
	kPropertyValueUnitCH,
	kPropertyValueUnitDeg,
	kPropertyValueUnitRad
} PropertyValueUnit;

/**
 * @typedef DisplayNodeMeasuredSize
 * @since 0.7.0
 * @hidden
 */
typedef struct {
	double width;
	double height;
} DisplayNodeMeasuredSize;

/**
 * @typedef DisplayResolveCallback
 * @since 0.7.0
 * @hidden
 */
typedef void (*DisplayCallback)(DisplayRef display);

/**
 * @typedef DisplayNodeMeasureCallback
 * @since 0.7.0
 * @hidden
 */
typedef void (*DisplayNodeMeasureCallback)(DisplayNodeRef node, DisplayNodeMeasuredSize* size, double w, double h, double minw, double maxw, double minh, double maxh);

/**
 * @typedef DisplayNodeResolveCallback
 * @since 0.7.0
 * @hidden
 */
typedef void (*DisplayNodeCallback)(DisplayNodeRef node);

/**
 * @typedef DisplayNodeMeasureCallback
 * @since 0.7.0
 * @hidden
 */
typedef void (*DisplayNodeMeasureCallback)(DisplayNodeRef node, DisplayNodeMeasuredSize* size, double w, double h, double minw, double maxw, double minh, double maxh);

/**
 * @typedef DisplayNodeUpdateCallback
 * @since 0.7.0
 * @hidden
 */
typedef void (*DisplayNodeUpdateCallback)(DisplayNodeRef node, PropertyRef property, const char* name);

#endif
