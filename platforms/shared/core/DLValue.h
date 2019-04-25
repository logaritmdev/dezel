#ifndef DLValue_h
#define DLValue_h

#include "DLContext.h"

#define DL_TYPE_UNDEFINED 1
#define DL_TYPE_NULL      2
#define DL_TYPE_BOOLEAN   3
#define DL_TYPE_NUMBER    4
#define DL_TYPE_STRING    5
#define DL_TYPE_OBJECT    6
#define DL_TYPE_ARRAY     7
#define DL_TYPE_FUNCTION  8

/**
 * A structure that stores image associated to a value.
 * @typedef DLValueDataRef
 * @since 0.1.0
 */
typedef struct OpaqueDLValueData* DLValueDataRef;

/**
 * The finalize handler.
 * @typedef DLFinalizeCallback
 * @since 0.1.0
 */
typedef void (*DLFinalizeCallback)(JSContextRef context, DLValueDataRef data);

/**
 * The function handler.
 * @typedef DLFunctionCallback
 * @since 0.1.0
 */
typedef JSValueRef (*DLFunctionCallback)(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, const JSValueRef argv[]);

#if __cplusplus
extern "C" {
#endif

/**
 * Creates a JavaScript value of the null type.
 * @function DLValueCreateNull
 * @since 0.1.0
 */
JSValueRef DLValueCreateNull(JSContextRef context);

/**
 * Creates a JavaScript value of the undefined type.
 * @function DLValueCreateUndefined
 * @since 0.1.0
 */
JSValueRef DLValueCreateUndefined(JSContextRef context);

/**
 * Creates a JavaScript value of the boolean type using a native boolean value.
 * @function DLValueCreateBool
 * @since 0.1.0
 */
JSValueRef DLValueCreateBoolean(JSContextRef context, DLBoolean value);

/**
 * Creates a JavaScript value of the number type using a native double value.
 * @function DLValueCreateNumber
 * @since 0.1.0
 */
JSValueRef DLValueCreateNumber(JSContextRef context, DLNumber value);

/**
 * Creates a JavaScript value of the string type using a native string value.
 * @function DLValueCreateString
 * @since 0.1.0
 */
JSValueRef DLValueCreateString(JSContextRef context, DLString value);

/**
 * Creates an empty JavaScript object.
 * @function DLValueCreateEmptyObject
 * @since 0.1.0
 */
JSObjectRef DLValueCreateEmptyObject(JSContextRef context, JSObjectRef proto);

/**
 * Creates an empty JavaScript array.
 * @function DLValueCreateEmptyArray
 * @since 0.1.0
 */
JSObjectRef DLValueCreateEmptyArray(JSContextRef context);

/**
 * Creates a JavaScript value of the function type that calls the specified handler.
 * @function DLValueCreateFunction
 * @since 0.1.0
 */
JSObjectRef DLValueCreateFunction(JSContextRef context, DLFunctionCallback callback, DLString name);

/**
 * Protect the value from garbage collection.
 * @function DLValueProtect
 * @since 0.1.0
 */
void DLValueProtect(JSContextRef context, JSValueRef value);

/**
 * Unprotect the value from garbage collection.
 * @function DLValueUnprotect
 * @since 0.1.0
 */
void DLValueUnprotect(JSContextRef context, JSValueRef value);

/**
* Defines a property on the specified value.
* @function DLValueDefineProperty
* @since 0.1.0
*/
void DLValueDefineProperty(JSContextRef context, JSObjectRef object, DLString property, JSValueRef getter, JSValueRef setter, JSValueRef value, DLBoolean writable, DLBoolean enumerable, DLBoolean configurable);

/**
* Defines a constructor on the specified prototype;
* @function DLValueDefineFunction
* @since 0.1.0
*/
void DLValueDefineConstructor(JSContextRef context, JSObjectRef prototype, JSObjectRef function);

/**
* Defines a function on the specified prototype;
* @function DLValueDefineFunction
* @since 0.1.0
*/
void DLValueDefineFunction(JSContextRef context, JSObjectRef prototype, DLString name, JSObjectRef function);

/**
* Defines a property setter on the specified prototype.
* @function DLValueDefinePropertySetter
* @since 0.1.0
*/
void DLValueDefinePropertySetter(JSContextRef context, JSObjectRef prototype, DLString name, JSObjectRef function);

/**
* Defines a property getter on the specified prototype.
* @function DLValueDefinePropertyGetter
* @since 0.1.0
*/
void DLValueDefinePropertyGetter(JSContextRef context, JSObjectRef prototype, DLString name, JSObjectRef function);

/**
 * Sets a property on the specified value.
 * @function DLValueSetProperty
 * @since 0.1.0
 */
void DLValueSetProperty(JSContextRef context, JSObjectRef prototype, DLString property, JSValueRef value);

/**
 * Sets a property on the specified value using a native string value.
 * @function DLValueSetPropertyWithString
 * @since 0.1.0
 */
void DLValueSetPropertyWithString(JSContextRef context, JSObjectRef object, DLString property, DLString value);

/**
 * Sets a property on the specified value using a native double value.
 * @function DLValueSetPropertyWithNumber
 * @since 0.1.0
 */
void DLValueSetPropertyWithNumber(JSContextRef context, JSObjectRef object, DLString property, DLNumber value);

/**
 * Sets a property on the specified value using a native boolean value.
 * @function DLValueSetPropertyWithBoolean
 * @since 0.1.0
 */
void DLValueSetPropertyWithBoolean(JSContextRef context, JSObjectRef object, DLString property, DLBoolean value);

/**
 * Returns a property from the specified value.
 * @function DLValueGetProperty
 * @since 0.1.0
 */
JSValueRef DLValueGetProperty(JSContextRef context, JSObjectRef object, DLString property);

/**
 * Returns the name of all properties from the specified object.
 * @function DLValueGetProperties
 * @since 0.1.0
 */
DLString* DLValueGetProperties(JSContextRef context, JSObjectRef object, int *count);

/**
 * Sets a property at a numeric index on the specified value.
 * @function DLValueSetPropertyAtIndex
 * @since 0.1.0
 */
void DLValueSetPropertyAtIndex(JSContextRef context, JSObjectRef object, unsigned int index, JSValueRef value);

/**
 * Sets a property at a numeric index on the specified value using a native string value.
 * @function DLValueSetPropertyAtIndexWithString
 * @since 0.1.0
 */
void DLValueSetPropertyAtIndexWithString(JSContextRef context, JSObjectRef object, unsigned int index, DLString value);

/**
 * Sets a property at a numeric index on the specified value using a native double value.
 * @function DLValueSetPropertyAtIndexWithNumber
 * @since 0.1.0
 */
void DLValueSetPropertyAtIndexWithNumber(JSContextRef context, JSObjectRef object, unsigned int index, DLNumber value);

/**
 * Sets a property at a numeric index on the specified value using a native boolean value.
 * @function DLValueSetPropertyAtIndexWithBoolean
 * @since 0.1.0
 */
void DLValueSetPropertyAtIndexWithBoolean(JSContextRef context, JSObjectRef object, unsigned int index, DLBoolean value);

/**
 * Returns a property at a numeric index from the specified value.
 * @function DLValueGetPropertyAtIndex
 * @since 0.1.0
 */
JSValueRef DLValueGetPropertyAtIndex(JSContextRef context, JSObjectRef object, unsigned int index);

/**
 * Executes the specified value as a function bound to the specified object.
 * @function DLValueCall
 * @since 0.1.0
 */
JSValueRef DLValueCall(JSContextRef context, JSObjectRef function, JSObjectRef object, unsigned int argc, const JSValueRef argv[]);

/**
 * Executes a handler from this value.
 * @function DLValueCallMethod
 * @since 0.1.0
 */
JSValueRef DLValueCallMethod(JSContextRef context, JSObjectRef object, DLString method, unsigned int argc, const JSValueRef argv[]);

/**
 * Executes the specified value as a constructor.
 * @function DLValueConstruct
 * @since 0.1.0
 */
JSValueRef DLValueConstruct(JSContextRef context, JSObjectRef function, unsigned int argc, JSValueRef argv[]);

/**
 * Sets the prototype object of the specified value.
 * @function DLValueSetPrototype
 * @since 0.1.0
 */
void DLValueSetPrototype(JSContextRef context, JSObjectRef object, JSValueRef prototype);

/**
 * Gets the prototype object from the specified value.
 * @function DLValueGetPrototype
 * @since 0.1.0
 */
JSValueRef DLValueGetPrototype(JSContextRef context, JSObjectRef object);

/**
 * Gets the prototype object from the specified constructor.
 * @function DLValueGetPrototypeOfConstructor
 * @since 0.1.0
 */
JSObjectRef DLValueGetPrototypeOfConstructor(JSContextRef context, JSObjectRef constructor);

/**
 * Gets the prototype object from the specified native constructor.
 * @function DLValueGetPrototypeOfNativeConstructor
 * @since 0.1.0
 */
JSObjectRef DLValueGetPrototypeOfNativeConstructor(JSContextRef context, DLString constructor);

/**
 * Sets an attribute on the specified value.
 * @function DLValueSetAttribute
 * @since 0.1.0
 */
void DLValueSetAttribute(JSContextRef context, JSObjectRef object, long long key, void *value);

/**
 * Gets an attribute from the specified value.
 * @function DLValueSetAttribute
 * @since 0.1.0
 */
void * DLValueGetAttribute(JSContextRef context, JSObjectRef object, long long key);

/**
 * Sets an associated object on the specified value.
 * @function DLValueSetAssociatedObject
 * @since 0.1.0
 */
void DLValueSetAssociatedObject(JSContextRef context, JSObjectRef object, void *associatedObject);

/**
 * Gets an associated object from the specified value.
 * @function DLValueSetAssociatedObject
 * @since 0.1.0
 */
void * DLValueGetAssociatedObject(JSContextRef context, JSObjectRef object);

/**
 * Sets the handler that will be executed when this value is finalized.
 * @function DLValueSetFinalizeHandler
 * @since 0.1.0
 */
void DLValueSetFinalizeHandler(JSContextRef context, JSObjectRef object, DLFinalizeCallback callback);

/**
 * Tests whether two values are strict equals.
 * @function DLValueEquals
 * @since 0.1.0
 */
bool DLValueEquals(JSContextRef context, JSValueRef value1, JSValueRef value2);

/**
 * Test whether a specified value equals a native string value.
 * @function DLValueEqualsString
 * @since 0.1.0
 */
bool DLValueEqualsString(JSContextRef context, JSValueRef value1, DLString value2);

/**
 * Test whether a specified value equals a native double value.
 * @function DLValueEqualsNumber
 * @since 0.1.0
 */
bool DLValueEqualsNumber(JSContextRef context, JSValueRef value1, DLNumber value2);

/**
 * Test whether a specified value equals a native boolean value.
 * @function DLValueEqualsBoolean
 * @since 0.1.0
 */
bool DLValueEqualsBoolean(JSContextRef context, JSValueRef value1, DLBoolean value2);

/**
 * Indicates whether the specified value is a boolean.
 * @function DLValueIsBoolean
 * @since 0.1.0
 */
bool DLValueIsBoolean(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is a number.
 * @function DLValueIsNumber
 * @since 0.1.0
 */
bool DLValueIsNumber(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is a string.
 * @function DLValueIsString
 * @since 0.1.0
 */
bool DLValueIsString(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is a function.
 * @function DLValueIsFunction
 * @since 0.1.0
 */
bool DLValueIsFunction(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is an object.
 * @function DLValueIsObject
 * @since 0.1.0
 */
bool DLValueIsObject(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is an array.
 * @function DLValueIsArray
 * @since 0.1.0
 */
bool DLValueIsArray(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is undefined.
 * @function DLValueIsUndefined
 * @since 0.1.0
 */
bool DLValueIsUndefined(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is null.
 * @function DLValueIsNull
 * @since 0.1.0
 */
bool DLValueIsNull(JSContextRef context, JSValueRef value);

/**
 * Returns the type of the specified value.
 * @function DLValueGetType
 * @since 0.1.0
 */
int DLValueGetType(JSContextRef context, JSValueRef value);

/**
 * Casts the specified valie into a JavaScript object.
 * @function DLValueToObject
 * @since 0.1.0
 */
JSObjectRef DLValueToObject(JSContextRef context, JSValueRef object);

/**
 * Casts the specified value into a native string value.
 * @function DLValueToString
 * @since 0.1.0
 */
DLString DLValueToString(JSContextRef context, JSValueRef value);

/**
 * Casts the specified value into a native double value.
 * @function DLValueToNumber
 * @since 0.1.0
 */
DLNumber DLValueToNumber(JSContextRef context, JSValueRef value);

/**
 * Casts the specified value into a native boolean value.
 * @function DLValueToBoolean
 * @since 0.1.0
 */
DLBoolean DLValueToBoolean(JSContextRef context, JSValueRef value);

/**
 * Standalone function to set an attribute on the specified value image structure.
 * @function DLValueDataSetAttribute
 * @since 0.1.0
 */
void DLValueDataSetAttribute(DLValueDataRef data, long long key, void *value);

/**
 * Standalone function to retrieve an attribute on the specified value image structure.
 * @function DLValueDataSetAttribute
 * @since 0.1.0
 */
void * DLValueDataGetAttribute(DLValueDataRef data, long long key);

/**
 * Standalone function to assign an associated object on the specified value image structure.
 * @function DLValueDataSetAssociatedObject
 * @since 0.1.0
 */
void DLValueDataSetAssociatedObject(DLValueDataRef data, void *associatedObject);

/**
 * Standalone function to retrieve an associated object on the specified value image structure.
 * @function DLValueDataGetAssociatedObject
 * @since 0.1.0
 */
void * DLValueDataGetAssociatedObject(DLValueDataRef data);

#if __cplusplus
}
#endif

#endif
