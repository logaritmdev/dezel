#ifndef DLStylerStyleItem_h
#define DLStylerStyleItem_h

/**
 * The style item unit.
 * @typeOf DLStylerStyleItemType
 * @since 0.3.0
 */
typedef enum {
	kDLStylerStyleItemTypeNull = 0,
	kDLStylerStyleItemTypeString = 1,
	kDLStylerStyleItemTypeNumber = 2,
	kDLStylerStyleItemTypeBoolean = 3,
} DLStylerStyleItemType;

/**
 * The style item unit.
 * @typeOf DLStylerStyleItemUnit
 * @since 0.3.0
 */
typedef enum {
	kDLStylerStyleItemUnitPX = 0,
	kDLStylerStyleItemUnitPC = 1,
	kDLStylerStyleItemUnitVW = 2,
	kDLStylerStyleItemUnitVH = 3,
	kDLStylerStyleItemUnitPW = 4,
	kDLStylerStyleItemUnitPH = 5,
	kDLStylerStyleItemUnitCW = 6,
	kDLStylerStyleItemUnitCH = 7,
	kDLStylerStyleItemUnitDeg = 8,
	kDLStylerStyleItemUnitRad = 9,
	kDLStylerStyleItemUnitNone = 10
} DLStylerStyleItemUnit;


/**
 * @typedef DLStylerStyleItemRef
 * @since 0.3.0
 * @hidden
 */
typedef struct OpaqueDLStylerStyleItem* DLStylerStyleItemRef;

#if __cplusplus
extern "C" {
#endif

/**
 * Returns the item'S item name.
 * @function DLStylerStyleItemGetProperty
 * @since 0.3.0
 */
const char* DLStylerStyleItemGetProperty(DLStylerStyleItemRef item);

/**
 * Assigns the item's value type.
 * @function DLStylerStyleItemSetValueType
 * @since 0.3.0
 */
void DLStylerStyleItemSetValueType(DLStylerStyleItemRef item, DLStylerStyleItemType type);

/**
 * Returns the item's value type.
 * @function DLStylerStyleItemGetValueType
 * @since 0.3.0
 */
DLStylerStyleItemType DLStylerStyleItemGetValueType(DLStylerStyleItemRef item);

/**
 * Assigns the item's value unit.
 * @function DLStylerStyleItemSetValueUnit
 * @since 0.3.0
 */
void DLStylerStyleItemSetValueUnit(DLStylerStyleItemRef item, DLStylerStyleItemUnit unit);

/**
 * Returns the item's value unit.
 * @function DLStylerStyleItemGetValueUnit
 * @since 0.3.0
 */
DLStylerStyleItemUnit DLStylerStyleItemGetValueUnit(DLStylerStyleItemRef item);

/**
 * Assigns the string value of this item.
 * @function DLStylerStyleItemSetValueWithString
 * @since 0.3.0
 */
void DLStylerStyleItemSetValueWithString(DLStylerStyleItemRef item, const char* value);

/**
 * Returns the string value of this item.
 * @function DLStylerStyleItemGetValueAsString
 * @since 0.3.0
 */
const char* DLStylerStyleItemGetValueAsString(DLStylerStyleItemRef item);

/**
 * Assigns the numeric value of this item.
 * @function DLStylerStyleItemSetValueWithNumber
 * @since 0.3.0
 */
void DLStylerStyleItemSetValueWithNumber(DLStylerStyleItemRef item, double value);

/**
 * Returns the numeric value of this item.
 * @function DLStylerStyleItemGetValueAsNumber
 * @since 0.3.0
 */
double DLStylerStyleItemGetValueAsNumber(DLStylerStyleItemRef item);

/**
 * Assigns the boolean value of this item.
 * @function DLStylerStyleItemSetValueWithBoolean
 * @since 0.3.0
 */
void DLStylerStyleItemSetValueWithBoolean(DLStylerStyleItemRef item, bool value);

/**
 * Returns the boolean value of this item.
 * @function DLStylerStyleItemGetValueAsBoolean
 * @since 0.3.0
 */
bool DLStylerStyleItemGetValueAsBoolean(DLStylerStyleItemRef item);

/**
 * Assigns user data to this item.
 * @function DLStylerStyleItemSetData
 * @since 0.3.0
 */
void DLStylerStyleItemSetData(DLStylerStyleItemRef item, void *data);

/**
 * Returns user data from this item.
 * @function DLStylerStyleItemGetData
 * @since 0.3.0
 */
void* DLStylerStyleItemGetData(DLStylerStyleItemRef item);

#if __cplusplus
}
#endif
#endif
