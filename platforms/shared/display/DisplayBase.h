#ifndef DisplayBase_h
#define DisplayBase_h

#include <float.h>
#include <stddef.h>

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
 * @typedef ValueListRef
 * @since 0.7.0
 * @hidden
 */
typedef struct OpaqueValueList* ValueListRef;

/**
 * @typedef ValueRef
 * @since 0.7.0
 * @hidden
 */
typedef struct OpaqueValue* ValueRef;

/**
 * @typedef VariableValueRef
 * @since 0.7.0
 * @hidden
 */
typedef struct OpaqueVariableValue* VariableValueRef;

/**
 * @typedef FunctionValueRef
 * @since 0.7.0
 * @hidden
 */
typedef struct OpaqueFunctionValue* FunctionValueRef;

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
 * @type SizeType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kAnchorTypeLength = 1
} AnchorType;

/**
 * @type AnchorUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kAnchorUnitPC = 1
} AnchorUnit;

/**
 * @type SizeType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kSizeTypeFill = 1,
	kSizeTypeWrap = 2,
	kSizeTypeLength = 3
} SizeType;

/**
 * @type SizeUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kSizeUnitNone = 1,
	kSizeUnitPX = 2,
	kSizeUnitPC = 3,
	kSizeUnitVW = 4,
	kSizeUnitVH = 5,
	kSizeUnitPW = 6,
	kSizeUnitPH = 7,
	kSizeUnitCW = 8,
	kSizeUnitCH = 9
} SizeUnit;

/**
 * @type OriginType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kOriginTypeAuto = 1,
	kOriginTypeLength = 2
} OriginType;

/**
 * @type OriginUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kOriginUnitNone = 1,
	kOriginUnitPX = 2,
	kOriginUnitPC = 3,
	kOriginUnitVW = 4,
	kOriginUnitVH = 5,
	kOriginUnitPW = 6,
	kOriginUnitPH = 7,
	kOriginUnitCW = 8,
	kOriginUnitCH = 9
} OriginUnit;

/**
 * @type DisplayNodeContentSize
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kContentOriginTypeLength = 1
} ContentOriginType;

/**
 * @type ContentOriginUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kContentOriginUnitNone = 1,
	kContentOriginUnitPX = 2
} ContentOriginUnit;

/**
 * @type DisplayNodeContentSize
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kContentSizeTypeAuto = 1,
	kContentSizeTypeLength = 2,
} ContentSizeType;

/**
 * @type ContentSizeUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kContentSizeUnitNone = 1,
	kContentSizeUnitPX = 2,
	kContentSizeUnitPC = 3,
	kContentSizeUnitVW = 4,
	kContentSizeUnitVH = 5,
	kContentSizeUnitPW = 6,
	kContentSizeUnitPH = 7,
	kContentSizeUnitCW = 8,
	kContentSizeUnitCH = 9
} ContentSizeUnit;

/**
 * @type ContentDirection
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kContentDirectionVertical = 1,
	kContentDirectionHorizontal = 2
} ContentDirection;

/**
 * @type ContentAlignment
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kContentDispositionStart = 1,
	kContentDispositionCenter = 2,
	kContentDispositionEnd = 3,
	kContentDispositionSpaceAround = 4,
	kContentDispositionSpaceBetween = 5,
	kContentDispositionSpaceEvenly = 6
} ContentDisposition;

/**
 * @type ContentAlignment
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kContentAlignmentStart = 1,
	kContentAlignmentCenter = 2,
	kContentAlignmentEnd = 3,
} ContentAlignment;

/**
 * @type MarginType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
    kBorderTypeLength = 1
} BorderType;

/**
 * @type BorderUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum {
    kBorderUnitPX = 1,
    kBorderUnitPC = 2,
    kBorderUnitVW = 3,
    kBorderUnitVH = 4,
	kBorderUnitPW = 5,
	kBorderUnitPH = 6,
	kBorderUnitCW = 7,
	kBorderUnitCH = 8
} BorderUnit;

/**
 * @type MarginType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kMarginTypeLength = 1
} MarginType;

/**
 * @type MarginUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kMarginUnitPX = 1,
	kMarginUnitPC = 2,
	kMarginUnitVW = 3,
	kMarginUnitVH = 4,
	kMarginUnitPW = 5,
	kMarginUnitPH = 6,
	kMarginUnitCW = 7,
	kMarginUnitCH = 8
} MarginUnit;

/**
 * @type PaddingType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kPaddingTypeLength = 1
} PaddingType;

/**
 * @type PaddingUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kPaddingUnitPX = 1,
	kPaddingUnitPC = 2,
	kPaddingUnitVW = 3,
	kPaddingUnitVH = 4,
	kPaddingUnitPW = 5,
	kPaddingUnitPH = 6,
	kPaddingUnitCW = 7,
	kPaddingUnitCH = 8
} PaddingUnit;

/**
 * @typedef MeasuredSize
 * @since 0.7.0
 * @hidden
 */
typedef struct {
	double width;
	double height;
} MeasuredSize;

/**
 * @typedef ValueType
 * @since 0.7.0
 * @hidden
 */
typedef enum {
	kValueTypeNull = 1,
	kValueTypeString = 2,
	kValueTypeNumber = 3,
	kValueTypeBoolean = 4,
	kValueTypeFunction = 5,
	kValueTypeVariable = 6
} ValueType;

/**
 * @typedef ValueUnit
 * @since 0.7.0
 * @hidden
 */
typedef enum  {
	kValueUnitNone = 1,
	kValueUnitPX = 2,
	kValueUnitPC = 3,
	kValueUnitVW = 4 ,
	kValueUnitVH = 5,
	kValueUnitPW = 6,
	kValueUnitPH = 7,
	kValueUnitCW = 8,
	kValueUnitCH = 9,
	kValueUnitDeg = 10,
	kValueUnitRad = 11
} ValueUnit;

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
typedef void (*DisplayNodeMeasureCallback)(DisplayNodeRef node, MeasuredSize* size, double w, double h, double minw, double maxw, double minh, double maxh);

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
typedef void (*DisplayNodeMeasureCallback)(DisplayNodeRef node, MeasuredSize* size, double w, double h, double minw, double maxw, double minh, double maxh);

/**
 * @typedef DisplayNodeUpdateCallback
 * @since 0.7.0
 * @hidden
 */
typedef void (*DisplayNodeUpdateCallback)(DisplayNodeRef node, PropertyRef property, const char* name);

/**
 * @typedef ParseValueCallback
 * @since 0.7.0
 * @hidden
 */
typedef void (*ParseValueCallback)(ValueListRef values, void* self, void* lock);

#endif
