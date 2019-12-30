#ifndef ValueRef_h
#define ValueRef_h

#include "DisplayBase.h"

#if __cplusplus
extern "C" {
#endif

/**
 * @function ParseValue
 * @since 0.7.0
 * @hidden
 */
void ParseValue(const char* source, void* that, void* lock, ParseValueCallback callback);

/**
 * @function ValueParse
 * @since 0.7.0
 * @hidden
 */
ValueListRef ValueParse(const char* source);

/**
 * @function ValueGetType
 * @since 0.7.0
 * @hidden
 */
ValueType ValueGetType(ValueRef value);

/**
 * @function ValueGetUnit
 * @since 0.7.0
 * @hidden
 */
ValueUnit ValueGetUnit(ValueRef value);

/**
 * @function ValueGetString
 * @since 0.7.0
 * @hidden
 */
const char* ValueGetString(ValueRef value);

/**
 * @function ValueGetNumber
 * @since 0.7.0
 * @hidden
 */
double ValueGetNumber(ValueRef value);

/**
 * @function ValueGetBoolean
 * @since 0.7.0
 * @hidden
 */
bool ValueGetBoolean(ValueRef value);

/**
 * @function ValueGetVariable
 * @since 0.7.0
 * @hidden
 */
VariableValueRef ValueGetVariable(ValueRef value);

/**
 * @function ValueGetFunction
 * @since 0.7.0
 * @hidden
 */
FunctionValueRef ValueGetFunction(ValueRef value);

#if __cplusplus
}
#endif
#endif 
