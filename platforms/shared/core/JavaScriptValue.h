#ifndef JavaScriptValue_h
#define JavaScriptValue_h

#include "JavaScriptContext.h"

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
 * @typedef JavaScriptValueDataRef
 * @since 0.7.0
 */
typedef struct JavaScriptValueData* JavaScriptValueDataRef;

/**
 * The finalize handler.
 * @typedef JavaScriptValueFinalizeCallback
 * @since 0.7.0
 */
typedef void (*JavaScriptValueFinalizeCallback)(JSContextRef context, JavaScriptValueDataRef data);

/**
 * The function handler.
 * @typedef JavaScriptValueFunctionCallback
 * @since 0.7.0
 */
typedef JSValueRef (*JavaScriptValueFunctionCallback)(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, const JSValueRef argv[]);

#if __cplusplus
extern "C" {
#endif

/**
 * Creates a JavaScript value of the null type.
 * @function JavaScriptValueCreateNull
 * @since 0.7.0
 */
JSValueRef JavaScriptValueCreateNull(JSContextRef context);

/**
 * Creates a JavaScript value of the undefined type.
 * @function JavaScriptValueCreateUndefined
 * @since 0.7.0
 */
JSValueRef JavaScriptValueCreateUndefined(JSContextRef context);

/**
 * Creates a JavaScript value of the boolean type using a native boolean value.
 * @function JavaScriptValueCreateBool
 * @since 0.7.0
 */
JSValueRef JavaScriptValueCreateBoolean(JSContextRef context, bool value);

/**
 * Creates a JavaScript value of the number type using a native double value.
 * @function JavaScriptValueCreateNumber
 * @since 0.7.0
 */
JSValueRef JavaScriptValueCreateNumber(JSContextRef context, double value);

/**
 * Creates a JavaScript value of the string type using a native string value.
 * @function JavaScriptValueCreateString
 * @since 0.7.0
 */
JSValueRef JavaScriptValueCreateString(JSContextRef context, const char* value);

/**
 * Creates an empty JavaScript object.
 * @function JavaScriptValueCreateEmptyObject
 * @since 0.7.0
 */
JSObjectRef JavaScriptValueCreateEmptyObject(JSContextRef context, JSObjectRef proto);

/**
 * Creates an empty JavaScript array.
 * @function JavaScriptValueCreateEmptyArray
 * @since 0.7.0
 */
JSObjectRef JavaScriptValueCreateEmptyArray(JSContextRef context);

/**
 * Creates a JavaScript value of the function type that calls the specified handler.
 * @function JavaScriptValueCreateFunction
 * @since 0.7.0
 */
JSObjectRef JavaScriptValueCreateFunction(JSContextRef context, JavaScriptValueFunctionCallback callback, const char* name);

/**
 * Protect the value from garbage collection.
 * @function JavaScriptValueProtect
 * @since 0.7.0
 */
void JavaScriptValueProtect(JSContextRef context, JSValueRef value);

/**
 * Unprotect the value from garbage collection.
 * @function JavaScriptValueUnprotect
 * @since 0.7.0
 */
void JavaScriptValueUnprotect(JSContextRef context, JSValueRef value);

/**
* Defines a property on the specified value.
* @function JavaScriptValueDefineProperty
* @since 0.7.0
*/
void JavaScriptValueDefineProperty(JSContextRef context, JSObjectRef object, const char* property, JSValueRef getter, JSValueRef setter, JSValueRef value, bool writable, bool enumerable, bool configurable);

/**
* Defines a constructor on the specified prototype;
* @function JavaScriptValueDefineFunction
* @since 0.7.0
*/
void JavaScriptValueDefineConstructor(JSContextRef context, JSObjectRef prototype, JSObjectRef function);

/**
* Defines a function on the specified prototype;
* @function JavaScriptValueDefineFunction
* @since 0.7.0
*/
void JavaScriptValueDefineFunction(JSContextRef context, JSObjectRef prototype, const char* name, JSObjectRef function);

/**
* Defines a property setter on the specified prototype.
* @function JavaScriptValueDefinePropertySetter
* @since 0.7.0
*/
void JavaScriptValueDefinePropertySetter(JSContextRef context, JSObjectRef prototype, const char* name, JSObjectRef function);

/**
* Defines a property getter on the specified prototype.
* @function JavaScriptValueDefinePropertyGetter
* @since 0.7.0
*/
void JavaScriptValueDefinePropertyGetter(JSContextRef context, JSObjectRef prototype, const char* name, JSObjectRef function);

/**
 * Sets a property on the specified value.
 * @function JavaScriptValueSetProperty
 * @since 0.7.0
 */
void JavaScriptValueSetProperty(JSContextRef context, JSObjectRef prototype, const char* property, JSValueRef value);

/**
 * Sets a property on the specified value using a native string value.
 * @function JavaScriptValueSetPropertyWithString
 * @since 0.7.0
 */
void JavaScriptValueSetPropertyWithString(JSContextRef context, JSObjectRef object, const char* property, const char* value);

/**
 * Sets a property on the specified value using a native double value.
 * @function JavaScriptValueSetPropertyWithNumber
 * @since 0.7.0
 */
void JavaScriptValueSetPropertyWithNumber(JSContextRef context, JSObjectRef object, const char* property, double value);

/**
 * Sets a property on the specified value using a native boolean value.
 * @function JavaScriptValueSetPropertyWithBoolean
 * @since 0.7.0
 */
void JavaScriptValueSetPropertyWithBoolean(JSContextRef context, JSObjectRef object, const char* property, bool value);

/**
 * Returns a property from the specified value.
 * @function JavaScriptValueGetProperty
 * @since 0.7.0
 */
JSValueRef JavaScriptValueGetProperty(JSContextRef context, JSObjectRef object, const char* property);

/**
 * Sets a property at a numeric index on the specified value.
 * @function JavaScriptValueSetPropertyAtIndex
 * @since 0.7.0
 */
void JavaScriptValueSetPropertyAtIndex(JSContextRef context, JSObjectRef object, unsigned int index, JSValueRef value);

/**
 * Sets a property at a numeric index on the specified value using a native string value.
 * @function JavaScriptValueSetPropertyAtIndexWithString
 * @since 0.7.0
 */
void JavaScriptValueSetPropertyAtIndexWithString(JSContextRef context, JSObjectRef object, unsigned int index, const char* value);

/**
 * Sets a property at a numeric index on the specified value using a native double value.
 * @function JavaScriptValueSetPropertyAtIndexWithNumber
 * @since 0.7.0
 */
void JavaScriptValueSetPropertyAtIndexWithNumber(JSContextRef context, JSObjectRef object, unsigned int index, double value);

/**
 * Sets a property at a numeric index on the specified value using a native boolean value.
 * @function JavaScriptValueSetPropertyAtIndexWithBoolean
 * @since 0.7.0
 */
void JavaScriptValueSetPropertyAtIndexWithBoolean(JSContextRef context, JSObjectRef object, unsigned int index, bool value);

/**
 * Returns a property at a numeric index from the specified value.
 * @function JavaScriptValueGetPropertyAtIndex
 * @since 0.7.0
 */
JSValueRef JavaScriptValueGetPropertyAtIndex(JSContextRef context, JSObjectRef object, unsigned int index);

/**
 * Executes the specified value as a function bound to the specified object.
 * @function JavaScriptValueCall
 * @since 0.7.0
 */
JSValueRef JavaScriptValueCall(JSContextRef context, JSObjectRef function, JSObjectRef object, unsigned int argc, const JSValueRef argv[]);

/**
 * Executes a handler from this value.
 * @function JavaScriptValueCallMethod
 * @since 0.7.0
 */
JSValueRef JavaScriptValueCallMethod(JSContextRef context, JSObjectRef object, const char* method, unsigned int argc, const JSValueRef argv[]);

/**
 * Executes the specified value as a constructor.
 * @function JavaScriptValueConstruct
 * @since 0.7.0
 */
JSValueRef JavaScriptValueConstruct(JSContextRef context, JSObjectRef function, unsigned int argc, JSValueRef argv[]);

/**
 * Sets the prototype object of the specified value.
 * @function JavaScriptValueSetPrototype
 * @since 0.7.0
 */
void JavaScriptValueSetPrototype(JSContextRef context, JSObjectRef object, JSValueRef prototype);

/**
 * Gets the prototype object from the specified value.
 * @function JavaScriptValueGetPrototype
 * @since 0.7.0
 */
JSValueRef JavaScriptValueGetPrototype(JSContextRef context, JSObjectRef object);

/**
 * Gets the prototype object from the specified constructor.
 * @function JavaScriptValueGetPrototypeOfConstructor
 * @since 0.7.0
 */
JSObjectRef JavaScriptValueGetPrototypeOfConstructor(JSContextRef context, JSObjectRef constructor);

/**
 * Gets the prototype object from the specified native constructor.
 * @function JavaScriptValueGetPrototypeOfNativeConstructor
 * @since 0.7.0
 */
JSObjectRef JavaScriptValueGetPrototypeOfNativeConstructor(JSContextRef context, const char* constructor);

/**
 * Sets an attribute on the specified value.
 * @function JavaScriptValueSetAttribute
 * @since 0.7.0
 */
void JavaScriptValueSetAttribute(JSContextRef context, JSObjectRef object, long long key, void *value);

/**
 * Gets an attribute from the specified value.
 * @function JavaScriptValueSetAttribute
 * @since 0.7.0
 */
void * JavaScriptValueGetAttribute(JSContextRef context, JSObjectRef object, long long key);

/**
 * Sets an associated object on the specified value.
 * @function JavaScriptValueSetAssociatedObject
 * @since 0.7.0
 */
void JavaScriptValueSetAssociatedObject(JSContextRef context, JSObjectRef object, void *associatedObject);

/**
 * Gets an associated object from the specified value.
 * @function JavaScriptValueSetAssociatedObject
 * @since 0.7.0
 */
void * JavaScriptValueGetAssociatedObject(JSContextRef context, JSObjectRef object);

/**
 * Sets the handler that will be executed when this value is finalized.
 * @function JavaScriptValueSetFinalizeHandler
 * @since 0.7.0
 */
void JavaScriptValueSetFinalizeHandler(JSContextRef context, JSObjectRef object, JavaScriptValueFinalizeCallback callback);

/**
 * Tests whether two values are strict equals.
 * @function JavaScriptValueEquals
 * @since 0.7.0
 */
bool JavaScriptValueEquals(JSContextRef context, JSValueRef value1, JSValueRef value2);

/**
 * Test whether a specified value equals a native string value.
 * @function JavaScriptValueEqualsString
 * @since 0.7.0
 */
bool JavaScriptValueEqualsString(JSContextRef context, JSValueRef value1, const char* value2);

/**
 * Test whether a specified value equals a native double value.
 * @function JavaScriptValueEqualsNumber
 * @since 0.7.0
 */
bool JavaScriptValueEqualsNumber(JSContextRef context, JSValueRef value1, double value2);

/**
 * Test whether a specified value equals a native boolean value.
 * @function JavaScriptValueEqualsBoolean
 * @since 0.7.0
 */
bool JavaScriptValueEqualsBoolean(JSContextRef context, JSValueRef value1, bool value2);

/**
 * Indicates whether the specified value is a boolean.
 * @function JavaScriptValueIsBoolean
 * @since 0.7.0
 */
bool JavaScriptValueIsBoolean(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is a number.
 * @function JavaScriptValueIsNumber
 * @since 0.7.0
 */
bool JavaScriptValueIsNumber(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is a string.
 * @function JavaScriptValueIsString
 * @since 0.7.0
 */
bool JavaScriptValueIsString(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is a function.
 * @function JavaScriptValueIsFunction
 * @since 0.7.0
 */
bool JavaScriptValueIsFunction(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is an object.
 * @function JavaScriptValueIsObject
 * @since 0.7.0
 */
bool JavaScriptValueIsObject(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is an array.
 * @function JavaScriptValueIsArray
 * @since 0.7.0
 */
bool JavaScriptValueIsArray(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is undefined.
 * @function JavaScriptValueIsUndefined
 * @since 0.7.0
 */
bool JavaScriptValueIsUndefined(JSContextRef context, JSValueRef value);

/**
 * Indicates whether the specified value is null.
 * @function JavaScriptValueIsNull
 * @since 0.7.0
 */
bool JavaScriptValueIsNull(JSContextRef context, JSValueRef value);

/**
 * Returns the type of the specified value.
 * @function JavaScriptValueGetType
 * @since 0.7.0
 */
int JavaScriptValueGetType(JSContextRef context, JSValueRef value);

/**
 * Casts the specified valie into a JavaScript object.
 * @function JavaScriptValueToObject
 * @since 0.7.0
 */
JSObjectRef JavaScriptValueToObject(JSContextRef context, JSValueRef object);

/**
 * Casts the specified value into a native string value.
 * @function JavaScriptValueToString
 * @since 0.7.0
 */
const char* JavaScriptValueToString(JSContextRef context, JSValueRef value);

/**
 * Casts the specified value into a native double value.
 * @function JavaScriptValueToNumber
 * @since 0.7.0
 */
double JavaScriptValueToNumber(JSContextRef context, JSValueRef value);

/**
 * Casts the specified value into a native boolean value.
 * @function JavaScriptValueToBoolean
 * @since 0.7.0
 */
bool JavaScriptValueToBoolean(JSContextRef context, JSValueRef value);

/**
 * Standalone function to set an attribute on the specified value image structure.
 * @function JavaScriptValueDataSetAttribute
 * @since 0.7.0
 */
void JavaScriptValueDataSetAttribute(JavaScriptValueDataRef data, long long key, void *value);

/**
 * Standalone function to retrieve an attribute on the specified value image structure.
 * @function JavaScriptValueDataSetAttribute
 * @since 0.7.0
 */
void * JavaScriptValueDataGetAttribute(JavaScriptValueDataRef data, long long key);

/**
 * Standalone function to assign an associated object on the specified value image structure.
 * @function JavaScriptValueDataSetAssociatedObject
 * @since 0.7.0
 */
void JavaScriptValueDataSetAssociatedObject(JavaScriptValueDataRef data, void *associatedObject);

/**
 * Standalone function to retrieve an associated object on the specified value image structure.
 * @function JavaScriptValueDataGetAssociatedObject
 * @since 0.7.0
 */
void* JavaScriptValueDataGetAssociatedObject(JavaScriptValueDataRef data);

/**
 * Loop through all the values of an array.
 * @function JavaScriptValueForEach
 * @since 0.7.0
 */
void JavaScriptValueForEach(JSContextRef context, JSValueRef value, JavaScriptValueForEachHandler callback, void* data);

/**
 * Loop through all the values of an object.
 * @function JavaScriptValueForOwn
 * @since 0.7.0
 */
void JavaScriptValueForOwn(JSContextRef context, JSValueRef value, JavaScriptValueForOwnHandler callback, void* data);

#if __cplusplus
}
#endif

#endif
