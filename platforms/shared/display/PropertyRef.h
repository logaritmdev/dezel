#ifndef PropertyRef_h
#define PropertyRef_h

#include "DisplayBase.h"

#if __cplusplus
extern "C" {
#endif

/**
 * Returns the display node's property name.
 * @function DisplayNodePropertyGetName
 * @since 0.7.0
 */
const char* DisplayNodePropertyGetName(DisplayNodePropertyRef property);

/**
 * Returns the display node's property value count.
 * @function DisplayNodePropertyGetValueCount
 * @since 0.7.0
 */
unsigned DisplayNodePropertyGetValueCount(DisplayNodePropertyRef property);

/**
 * Returns the display node's property value type.
 * @function DisplayNodePropertyGetValueType
 * @since 0.7.0
 */
DisplayNodePropertyValueType DisplayNodePropertyGetValueType(DisplayNodePropertyRef property, unsigned index);

/**
 * Returns the display node's property value unit.
 * @function DisplayNodePropertyGetValueUnit
 * @since 0.7.0
 */
DisplayNodePropertyValueUnit DisplayNodePropertyGetValueUnit(DisplayNodePropertyRef property, unsigned index);

/**
 * Returns the display node's property value as a string.
 * @function DisplayNodePropertyGetValueAsString
 * @since 0.7.0
 */
const char* DisplayNodePropertyGetValueAsString(DisplayNodePropertyRef property, unsigned index);

/**
 * Returns the display node's property value as a number.
 * @function DisplayNodePropertyGetValueAsNumber
 * @since 0.7.0
 */
double DisplayNodePropertyGetValueAsNumber(DisplayNodePropertyRef property, unsigned index);

/**
 * Returns the display node's property value as a boolean.
 * @function DisplayNodePropertyGetValueAsBoolean
 * @since 0.7.0
 */
bool DisplayNodePropertyGetValueAsBoolean(DisplayNodePropertyRef property, unsigned index);

/**
 * Assigns the display node's property value with a string.
 * @function DisplayNodePropertyInsertValueWithString
 * @since 0.7.0
 */
void DisplayNodePropertyInsertValueWithString(DisplayNodePropertyRef property, unsigned index, const char* value);

/**
 * Assigns the display node's property value with a number.
 * @function DisplayNodePropertyInsertValueWithNumber
 * @since 0.7.0
 */
void DisplayNodePropertyInsertValueWithNumber(DisplayNodePropertyRef property, unsigned index, double value);

/**
 * Assigns the display node's property value with a boolean.
 * @function DisplayNodePropertyInsertValueAsBoolean
 * @since 0.7.0
 */
void DisplayNodePropertyInsertValueAsBoolean(DisplayNodePropertyRef property, unsigned index, bool value);

#if __cplusplus
}
#endif
#endif 
