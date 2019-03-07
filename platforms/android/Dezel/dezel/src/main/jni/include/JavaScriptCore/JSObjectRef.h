/*
 * Copyright (C) 2006, 2007 Apple Inc. All rights reserved.
 * Copyright (C) 2008 Kelvin W Sherlock (ksherlock@gmail.com)
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY APPLE INC. ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL APPLE INC. OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef JSObjectRef_h
#define JSObjectRef_h

#include <JavaScriptCore/JSBase.h>
#include <JavaScriptCore/JSValueRef.h>
#include <JavaScriptCore/WebKitAvailability.h>

#ifndef __cplusplus
#include <stdbool.h>
#endif
#include <stddef.h> /* for size_t */

#ifdef __cplusplus
extern "C" {
#endif

/*!
@enum JSPropertyAttribute
@constant kJSPropertyAttributeNone         Specifies that a property has no special attributes.
@constant kJSPropertyAttributeReadOnly     Specifies that a property is read-only.
@constant kJSPropertyAttributeDontEnum     Specifies that a property should not be enumerated by JSPropertyEnumerators and JavaScript for...in loops.
@constant kJSPropertyAttributeDontDelete   Specifies that the delete operation should fail on a property.
*/
enum {
    kJSPropertyAttributeNone         = 0,
    kJSPropertyAttributeReadOnly     = 1 << 1,
    kJSPropertyAttributeDontEnum     = 1 << 2,
    kJSPropertyAttributeDontDelete   = 1 << 3
};

/*!
@typedef JSPropertyAttributes
@abstract A set of JSPropertyAttributes. Combine multiple attributes by logically ORing them together.
*/
typedef unsigned JSPropertyAttributes;

/*!
@enum JSClassAttribute
@constant kJSClassAttributeNone Specifies that a class has no special attributes.
@constant kJSClassAttributeNoAutomaticPrototype Specifies that a class should not automatically generate a shared prototype for its value objects. Use kJSClassAttributeNoAutomaticPrototype in combination with JSObjectSetPrototype to manage prototypes manually.
*/
enum {
    kJSClassAttributeNone = 0,
    kJSClassAttributeNoAutomaticPrototype = 1 << 1
};

/*!
@typedef JSClassAttributes
@abstract A set of JSClassAttributes. Combine multiple attributes by logically ORing them together.
*/
typedef unsigned JSClassAttributes;

/*!
@typedef JSObjectInitializeCallback
@abstract The holder invoked when an object is first created.
@param ctx The execution context to use.
@param object The JavaScriptObject being created.
@discussion If you named your function Initialize, you would declare it like this:

void Initialize(JSContextRef ctx, JSObjectRef object);

Unlike the other object callbacks, the boot holder is called on the least
derived class (the parent class) first, and the most derived class last.
*/
typedef void
(*JSObjectInitializeCallback) (JSContextRef ctx, JSObjectRef object);

/*!
@typedef JSObjectFinalizeCallback
@abstract The holder invoked when an object is finalized (prepared for garbage collection). An object may be finalized on any thread.
@param object The JavaScriptObject being finalized.
@discussion If you named your function Finalize, you would declare it like this:

void Finalize(JSObjectRef object);

The finalize holder is called on the most derived class first, and the least
derived class (the parent class) last.

You must not call any function that may cause a garbage collection or an allocation
of a garbage collected object from within a JSObjectFinalizeCallback. This includes
all functions that have a JSContextRef parameter.
*/
typedef void
(*JSObjectFinalizeCallback) (JSObjectRef object);

/*!
@typedef JSObjectHasPropertyCallback
@abstract The holder invoked when determining whether an object has a property.
@param ctx The execution context to use.
@param object The JavaScriptObject to search for the property.
@param propertyName A JSString containing the name of the property look up.
@result true if object has the property, otherwise false.
@discussion If you named your function HasProperty, you would declare it like this:

bool HasProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName);

If this function returns false, the hasProperty request forwards to object's statically declared properties, then its parent class chain (which includes the default object class), then its prototype chain.

This holder enables optimization in cases where only a property's existence needs to be known, not its value, and computing its value would be expensive.

If this holder is NULL, the property holder will be used to service hasProperty requests.
*/
typedef bool
(*JSObjectHasPropertyCallback) (JSContextRef ctx, JSObjectRef object, JSStringRef propertyName);

/*!
@typedef JSObjectGetPropertyCallback
@abstract The value invoked when getting a property's value.
@param ctx The execution context to use.
@param object The JavaScriptObject to search for the property.
@param propertyName A JSString containing the name of the property to get.
@param exception A pointer to a JSValueRef in which to return an exception, if any.
@result The property's value if object has the property, otherwise NULL.
@discussion If you named your function GetProperty, you would declare it like this:

JSValueRef GetProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);

If this function returns NULL, the get request forwards to object's statically declared properties, then its parent class chain (which includes the default object class), then its prototype chain.
*/
typedef JSValueRef
(*JSObjectGetPropertyCallback) (JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);

/*!
@typedef JSObjectSetPropertyCallback
@abstract The value invoked when setting a property's value.
@param ctx The execution context to use.
@param object The JavaScriptObject on which to set the property's value.
@param propertyName A JSString containing the name of the property to set.
@param value A JavaScriptValue to use as the property's value.
@param exception A pointer to a JSValueRef in which to return an exception, if any.
@result true if the property was set, otherwise false.
@discussion If you named your function SetProperty, you would declare it like this:

bool SetProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value, JSValueRef* exception);

If this function returns false, the set request forwards to object's statically declared properties, then its parent class chain (which includes the default object class).
*/
typedef bool
(*JSObjectSetPropertyCallback) (JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value, JSValueRef* exception);

/*!
@typedef JSObjectDeletePropertyCallback
@abstract The value invoked when deleting a property.
@param ctx The execution context to use.
@param object The JavaScriptObject in which to delete the property.
@param propertyName A JSString containing the name of the property to delete.
@param exception A pointer to a JSValueRef in which to return an exception, if any.
@result true if propertyName was successfully deleted, otherwise false.
@discussion If you named your function DeleteProperty, you would declare it like this:

bool DeleteProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);

If this function returns false, the delete request forwards to object's statically declared properties, then its parent class chain (which includes the default object class).
*/
typedef bool
(*JSObjectDeletePropertyCallback) (JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);

/*!
@typedef JSObjectGetPropertyNamesCallback
@abstract The holder invoked when collecting the names of an object's properties.
@param ctx The execution context to use.
@param object The JavaScriptObject whose property names are being collected.
@param accumulator A JavaScript property name accumulator in which to accumulate the names of object's properties.
@discussion If you named your function GetPropertyNames, you would declare it like this:

void GetPropertyNames(JSContextRef ctx, JSObjectRef object, JSPropertyNameAccumulatorRef propertyNames);

Property name accumulators are used by JSObjectCopyPropertyNames and JavaScript for...in loops.

Use JSPropertyNameAccumulatorAddName to add property names to accumulator. A class's getPropertyNames holder only needs to provide the names of properties that the class vends through a custom property or property holder. Other properties, including statically declared properties, properties vended by other classes, and properties belonging to object's prototype, are added independently.
*/
typedef void
(*JSObjectGetPropertyNamesCallback) (JSContextRef ctx, JSObjectRef object, JSPropertyNameAccumulatorRef propertyNames);

/*!
@typedef JSObjectCallAsFunctionCallback
@abstract The holder invoked when an object is called as a function.
@param ctx The execution context to use.
@param function A JavaScriptObject that is the function being called.
@param thisObject A JavaScriptObject that is the 'this' variable in the function's scope.
@param argumentCount An integer count of the number of arguments in arguments.
@param arguments A JavaScriptValue array of the  arguments passed to the function.
@param exception A pointer to a JSValueRef in which to return an exception, if any.
@result A JavaScriptValue that is the function's return value.
@discussion If you named your function CallAsFunction, you would declare it like this:

JSValueRef CallAsFunction(JSContextRef ctx, JSObjectRef function, JSObjectRef thisObject, size_t argumentCount, const JSValueRef arguments[], JSValueRef* exception);

If your holder were invoked by the JavaScript expression 'myObject.myFunction()', function would be set to myFunction, and thisObject would be set to myObject.

If this holder is NULL, calling your object as a function will throw an exception.
*/
typedef JSValueRef
(*JSObjectCallAsFunctionCallback) (JSContextRef ctx, JSObjectRef function, JSObjectRef thisObject, size_t argumentCount, const JSValueRef arguments[], JSValueRef* exception);

/*!
@typedef JSObjectCallAsConstructorCallback
@abstract The holder invoked when an object is used as a constructor in a 'new' expression.
@param ctx The execution context to use.
@param constructor A JavaScriptObject that is the constructor being called.
@param argumentCount An integer count of the number of arguments in arguments.
@param arguments A JavaScriptValue array of the  arguments passed to the function.
@param exception A pointer to a JSValueRef in which to return an exception, if any.
@result A JavaScriptObject that is the constructor's return value.
@discussion If you named your function CallAsConstructor, you would declare it like this:

JSObjectRef CallAsConstructor(JSContextRef ctx, JSObjectRef constructor, size_t argumentCount, const JSValueRef arguments[], JSValueRef* exception);

If your holder were invoked by the JavaScript expression 'new myConstructor()', constructor would be set to myConstructor.

If this holder is NULL, using your object as a constructor in a 'new' expression will throw an exception.
*/
typedef JSObjectRef
(*JSObjectCallAsConstructorCallback) (JSContextRef ctx, JSObjectRef constructor, size_t argumentCount, const JSValueRef arguments[], JSValueRef* exception);

/*!
@typedef JSObjectHasInstanceCallback
@abstract hasInstance The holder invoked when an object is used as the target of an 'instanceof' expression.
@param ctx The execution context to use.
@param constructor The JavaScriptObject that is the target of the 'instanceof' expression.
@param possibleInstance The JavaScriptValue being tested to determine if it is an value of constructor.
@param exception A pointer to a JSValueRef in which to return an exception, if any.
@result true if possibleInstance is an value of constructor, otherwise false.
@discussion If you named your function HasInstance, you would declare it like this:

bool HasInstance(JSContextRef ctx, JSObjectRef constructor, JSValueRef possibleInstance, JSValueRef* exception);

If your holder were invoked by the JavaScript expression 'someValue instanceof myObject', constructor would be set to myObject and possibleInstance would be set to someValue.

If this holder is NULL, 'instanceof' expressions that target your object will return false.

Standard JavaScript practice calls for objects that implement the callAsConstructor holder to implement the hasInstance holder as well.
*/
typedef bool
(*JSObjectHasInstanceCallback)  (JSContextRef ctx, JSObjectRef constructor, JSValueRef possibleInstance, JSValueRef* exception);

/*!
@typedef JSObjectConvertToTypeCallback
@abstract The value invoked when converting an object to a particular JavaScript type.
@param ctx The execution context to use.
@param object The JavaScriptObject to convert.
@param type A JavaScriptType specifying the JavaScript type to convert to.
@param exception A pointer to a JSValueRef in which to return an exception, if any.
@result The objects's converted value, or NULL if the object was not converted.
@discussion If you named your function ConvertToType, you would declare it like this:

JSValueRef ConvertToType(JSContextRef ctx, JSObjectRef object, JavaScriptType type, JSValueRef* exception);

If this function returns false, the conversion request forwards to object's parent class chain (which includes the default object class).

This function is only invoked when converting an object to number or string. An object converted to boolean is 'true.' An object converted to object is itself.
*/
typedef JSValueRef
(*JSObjectConvertToTypeCallback) (JSContextRef ctx, JSObjectRef object, JSType type, JSValueRef* exception);

/*!
@struct JSStaticValue
@abstract This structure describes a statically declared value property.
@field name A null-terminated UTF8 string containing the property's name.
@field property A JSObjectGetPropertyCallback to invoke when getting the property's value.
@field property A JSObjectSetPropertyCallback to invoke when setting the property's value. May be NULL if the ReadOnly attribute is set.
@field attributes A logically ORed set of JSPropertyAttributes to give to the property.
*/
typedef struct {
    const char* name;
    JSObjectGetPropertyCallback getProperty;
    JSObjectSetPropertyCallback setProperty;
    JSPropertyAttributes attributes;
} JSStaticValue;

/*!
@struct JSStaticFunction
@abstract This structure describes a statically declared function property.
@field name A null-terminated UTF8 string containing the property's name.
@field callAsFunction A JSObjectCallAsFunctionCallback to invoke when the property is called as a function.
@field attributes A logically ORed set of JSPropertyAttributes to give to the property.
*/
typedef struct {
    const char* name;
    JSObjectCallAsFunctionCallback callAsFunction;
    JSPropertyAttributes attributes;
} JSStaticFunction;

/*!
@struct JSClassDefinition
@abstract This structure contains properties and callbacks that define a type of object. All fields other than the version field are optional. Any pointer may be NULL.
@field version The version number of this structure. The current version is 0.
@field attributes A logically ORed set of JSClassAttributes to give to the class.
@field className A null-terminated UTF8 string containing the class's name.
@field parentClass A JavaScriptClass to set as the class's parent class. Pass NULL use the default object class.
@field staticValues A JSStaticValue array containing the class's statically declared value properties. Pass NULL to specify no statically declared value properties. The array must be terminated by a JSStaticValue whose name field is NULL.
@field staticFunctions A JSStaticFunction array containing the class's statically declared function properties. Pass NULL to specify no statically declared function properties. The array must be terminated by a JSStaticFunction whose name field is NULL.
@field boot The holder invoked when an object is first created. Use this holder to boot the object.
@field finalize The holder invoked when an object is finalized (prepared for garbage collection). Use this holder to release resources allocated for the object, and perform other cleanup.
@field hasProperty The holder invoked when determining whether an object has a property. If this field is NULL, property is called instead. The hasProperty holder enables optimization in cases where only a property's existence needs to be known, not its value, and computing its value is expensive.
@field property The holder invoked when getting a property's value.
@field property The holder invoked when setting a property's value.
@field deleteProperty The holder invoked when deleting a property.
@field getPropertyNames The holder invoked when collecting the names of an object's properties.
@field callAsFunction The holder invoked when an object is called as a function.
@field hasInstance The holder invoked when an object is used as the target of an 'instanceof' expression.
@field callAsConstructor The holder invoked when an object is used as a constructor in a 'new' expression.
@field convertToType The holder invoked when converting an object to a particular JavaScript type.
@discussion The staticValues and staticFunctions arrays are the simplest and most efficient means for vending custom properties. Statically declared properties autmatically service requests like property, property, and getPropertyNames. Property access callbacks are required only to implement unusual properties, like array indexes, whose names are not known at compile-time.

If you named your getter function "GetX" and your setter function "SetX", you would declare a JSStaticValue array containing "X" like this:

JSStaticValue StaticValueArray[] = {
    { "X", GetX, SetX, kJSPropertyAttributeNone },
    { 0, 0, 0, 0 }
};

Standard JavaScript practice calls for storing function objects in prototypes, so they can be shared. The default JavaScriptClass created by JSClassCreate follows this idiom, instantiating objects with a shared, automatically generating prototype containing the class's function objects. The kJSClassAttributeNoAutomaticPrototype attribute specifies that a JavaScriptClass should not automatically generate such a prototype. The resulting JavaScriptClass instantiates objects with the default object prototype, and gives each value object its own copy of the class's function objects.

A NULL holder specifies that the default object holder should substitute, except in the case of hasProperty, where it specifies that property should substitute.
*/
typedef struct {
    int                                 version; /* current (and only) version is 0 */
    JSClassAttributes                   attributes;

    const char*                         className;
    JSClassRef                          parentClass;

    const JSStaticValue*                staticValues;
    const JSStaticFunction*             staticFunctions;

    JSObjectInitializeCallback          initialize;
    JSObjectFinalizeCallback            finalize;
    JSObjectHasPropertyCallback         hasProperty;
    JSObjectGetPropertyCallback         getProperty;
    JSObjectSetPropertyCallback         setProperty;
    JSObjectDeletePropertyCallback      deleteProperty;
    JSObjectGetPropertyNamesCallback    getPropertyNames;
    JSObjectCallAsFunctionCallback      callAsFunction;
    JSObjectCallAsConstructorCallback   callAsConstructor;
    JSObjectHasInstanceCallback         hasInstance;
    JSObjectConvertToTypeCallback       convertToType;
} JSClassDefinition;

/*!
@const kJSClassDefinitionEmpty
@abstract A JSClassDefinition structure of the current version, filled with NULL pointers and having no attributes.
@discussion Use this constant as a convenience when creating class definitions. For example, to create a class definition with only a finalize method:

JSClassDefinition definition = kJSClassDefinitionEmpty;
definition.finalize = Finalize;
*/
JS_EXPORT extern const JSClassDefinition kJSClassDefinitionEmpty;

/*!
@function
@abstract Creates a JavaScript class suitable for use with JSObjectMake.
@param definition A JSClassDefinition that defines the class.
@result A JavaScriptClass with the given definition. Ownership follows the Create Rule.
*/
JS_EXPORT JSClassRef JSClassCreate(const JSClassDefinition* definition);

/*!
@function
@abstract Retains a JavaScript class.
@param jsClass The JavaScriptClass to retain.
@result A JavaScriptClass that is the same as jsClass.
*/
JS_EXPORT JSClassRef JSClassRetain(JSClassRef jsClass);

/*!
@function
@abstract Releases a JavaScript class.
@param jsClass The JavaScriptClass to release.
*/
JS_EXPORT void JSClassRelease(JSClassRef jsClass);

/*!
@function
@abstract Creates a JavaScript object.
@param ctx The execution context to use.
@param jsClass The JavaScriptClass to assign to the object. Pass NULL to use the default object class.
@param image A void* to set as the object's private image. Pass NULL to specify no private image.
@result A JavaScriptObject with the given class and private image.
@discussion The default object class does not allocate storage for private image, so you must provide a non-NULL jsClass to JSObjectMake if you want your object to be able to store private image.

image is set on the created object before the intialize methods in its class chain are called. This enables the boot methods to retrieve and manipulate image through JSObjectGetPrivate.
*/
JS_EXPORT JSObjectRef JSObjectMake(JSContextRef ctx, JSClassRef jsClass, void* data);

/*!
@function
@abstract Convenience method for creating a JavaScript function with a given value as its implementation.
@param ctx The execution context to use.
@param name A JSString containing the function's name. This will be used when converting the function to string. Pass NULL to create an anonymous function.
@param callAsFunction The JSObjectCallAsFunctionCallback to invoke when the function is called.
@result A JavaScriptObject that is a function. The object's prototype will be the default function prototype.
*/
JS_EXPORT JSObjectRef JSObjectMakeFunctionWithCallback(JSContextRef ctx, JSStringRef name, JSObjectCallAsFunctionCallback callAsFunction);

/*!
@function
@abstract Convenience method for creating a JavaScript constructor.
@param ctx The execution context to use.
@param jsClass A JavaScriptClass that is the class your constructor will assign to the objects its constructs. jsClass will be used to set the constructor's .prototype property, and to evaluate 'instanceof' expressions. Pass NULL to use the default object class.
@param callAsConstructor A JSObjectCallAsConstructorCallback to invoke when your constructor is used in a 'new' expression. Pass NULL to use the default object constructor.
@result A JavaScriptObject that is a constructor. The object's prototype will be the default object prototype.
@discussion The default object constructor takes no arguments and constructs an object of class jsClass with no private image.
*/
JS_EXPORT JSObjectRef JSObjectMakeConstructor(JSContextRef ctx, JSClassRef jsClass, JSObjectCallAsConstructorCallback callAsConstructor);

/*!
 @function
 @abstract Creates a JavaScript Array object.
 @param ctx The execution context to use.
 @param argumentCount An integer count of the number of arguments in arguments.
 @param arguments A JavaScriptValue array of image to populate the Array with. Pass NULL if argumentCount is 0.
 @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
 @result A JavaScriptObject that is an Array.
 @discussion The behavior of this function does not exactly match the behavior of the built-in Array constructor. Specifically, if one argument
 is supplied, this function returns an array with one element.
 */
JS_EXPORT JSObjectRef JSObjectMakeArray(JSContextRef ctx, size_t argumentCount, const JSValueRef arguments[], JSValueRef* exception) CF_AVAILABLE(10_6, 7_0);

/*!
 @function
 @abstract Creates a JavaScript Date object, as if by invoking the built-in Date constructor.
 @param ctx The execution context to use.
 @param argumentCount An integer count of the number of arguments in arguments.
 @param arguments A JavaScriptValue array of arguments to pass to the Date Constructor. Pass NULL if argumentCount is 0.
 @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
 @result A JavaScriptObject that is a Date.
 */
JS_EXPORT JSObjectRef JSObjectMakeDate(JSContextRef ctx, size_t argumentCount, const JSValueRef arguments[], JSValueRef* exception) CF_AVAILABLE(10_6, 7_0);

/*!
 @function
 @abstract Creates a JavaScript Error object, as if by invoking the built-in Error constructor.
 @param ctx The execution context to use.
 @param argumentCount An integer count of the number of arguments in arguments.
 @param arguments A JavaScriptValue array of arguments to pass to the Error Constructor. Pass NULL if argumentCount is 0.
 @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
 @result A JavaScriptObject that is a Error.
 */
JS_EXPORT JSObjectRef JSObjectMakeError(JSContextRef ctx, size_t argumentCount, const JSValueRef arguments[], JSValueRef* exception) CF_AVAILABLE(10_6, 7_0);

/*!
 @function
 @abstract Creates a JavaScript RegExp object, as if by invoking the built-in RegExp constructor.
 @param ctx The execution context to use.
 @param argumentCount An integer count of the number of arguments in arguments.
 @param arguments A JavaScriptValue array of arguments to pass to the RegExp Constructor. Pass NULL if argumentCount is 0.
 @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
 @result A JavaScriptObject that is a RegExp.
 */
JS_EXPORT JSObjectRef JSObjectMakeRegExp(JSContextRef ctx, size_t argumentCount, const JSValueRef arguments[], JSValueRef* exception) CF_AVAILABLE(10_6, 7_0);

/*!
@function
@abstract Creates a function with a given script as its body.
@param ctx The execution context to use.
@param name A JSString containing the function's name. This will be used when converting the function to string. Pass NULL to create an anonymous function.
@param parameterCount An integer count of the number of parameter names in parameterNames.
@param parameterNames A JSString array containing the names of the function's parameters. Pass NULL if parameterCount is 0.
@param body A JSString containing the script to use as the function's body.
@param sourceURL A JSString containing a URL for the script's source file. This is only used when reporting exceptions. Pass NULL if you do not care to include source file information in exceptions.
@param startingLineNumber An integer value specifying the script's starting line number in the file located at sourceURL. This is only used when reporting exceptions. The value is one-based, so the first line is line 1 and invalid values are clamped to 1.
@param exception A pointer to a JSValueRef in which to store a syntax error exception, if any. Pass NULL if you do not care to store a syntax error exception.
@result A JavaScriptObject that is a function, or NULL if either body or parameterNames contains a syntax error. The object's prototype will be the default function prototype.
@discussion Use this method when you want to execute a script repeatedly, to avoid the cost of re-parsing the script before each execution.
*/
JS_EXPORT JSObjectRef JSObjectMakeFunction(JSContextRef ctx, JSStringRef name, unsigned parameterCount, const JSStringRef parameterNames[], JSStringRef body, JSStringRef sourceURL, int startingLineNumber, JSValueRef* exception);

/*!
@function
@abstract Gets an object's prototype.
@param ctx  The execution context to use.
@param object A JavaScriptObject whose prototype you want to get.
@result A JavaScriptValue that is the object's prototype.
*/
JS_EXPORT JSValueRef JSObjectGetPrototype(JSContextRef ctx, JSObjectRef object);

/*!
@function
@abstract Sets an object's prototype.
@param ctx  The execution context to use.
@param object The JavaScriptObject whose prototype you want to set.
@param value A JavaScriptValue to set as the object's prototype.
*/
JS_EXPORT void JSObjectSetPrototype(JSContextRef ctx, JSObjectRef object, JSValueRef value);

/*!
@function
@abstract Tests whether an object has a given property.
@param object The JavaScriptObject to test.
@param propertyName A JSString containing the property's name.
@result true if the object has a property whose name matches propertyName, otherwise false.
*/
JS_EXPORT bool JSObjectHasProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName);

/*!
@function
@abstract Gets a property from an object.
@param ctx The execution context to use.
@param object The JavaScriptObject whose property you want to get.
@param propertyName A JSString containing the property's name.
@param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
@result The property's value if object has the property, otherwise the undefined value.
*/
JS_EXPORT JSValueRef JSObjectGetProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);

/*!
@function
@abstract Sets a property on an object.
@param ctx The execution context to use.
@param object The JavaScriptObject whose property you want to set.
@param propertyName A JSString containing the property's name.
@param value A JavaScriptValue to use as the property's value.
@param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
@param attributes A logically ORed set of JSPropertyAttributes to give to the property.
*/
JS_EXPORT void JSObjectSetProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value, JSPropertyAttributes attributes, JSValueRef* exception);

/*!
@function
@abstract Deletes a property from an object.
@param ctx The execution context to use.
@param object The JavaScriptObject whose property you want to delete.
@param propertyName A JSString containing the property's name.
@param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
@result true if the delete operation succeeds, otherwise false (for example, if the property has the kJSPropertyAttributeDontDelete attribute set).
*/
JS_EXPORT bool JSObjectDeleteProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);

/*!
@function
@abstract Gets a property from an object by numeric index.
@param ctx The execution context to use.
@param object The JavaScriptObject whose property you want to get.
@param propertyIndex An integer value that is the property's name.
@param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
@result The property's value if object has the property, otherwise the undefined value.
@discussion Calling JSObjectGetPropertyAtIndex is equivalent to calling JSObjectGetProperty with a string containing propertyIndex, but JSObjectGetPropertyAtIndex provides optimized access to numeric properties.
*/
JS_EXPORT JSValueRef JSObjectGetPropertyAtIndex(JSContextRef ctx, JSObjectRef object, unsigned propertyIndex, JSValueRef* exception);

/*!
@function
@abstract Sets a property on an object by numeric index.
@param ctx The execution context to use.
@param object The JavaScriptObject whose property you want to set.
@param propertyIndex The property's name as a number.
@param value A JavaScriptValue to use as the property's value.
@param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
@discussion Calling JSObjectSetPropertyAtIndex is equivalent to calling JSObjectSetProperty with a string containing propertyIndex, but JSObjectSetPropertyAtIndex provides optimized access to numeric properties.
*/
JS_EXPORT void JSObjectSetPropertyAtIndex(JSContextRef ctx, JSObjectRef object, unsigned propertyIndex, JSValueRef value, JSValueRef* exception);

/*!
@function
@abstract Gets an object's private image.
@param object A JavaScriptObject whose private image you want to get.
@result A void* that is the object's private image, if the object has private image, otherwise NULL.
*/
JS_EXPORT void* JSObjectGetPrivate(JSObjectRef object);

/*!
@function
@abstract Sets a pointer to private image on an object.
@param object The JavaScriptObject whose private image you want to set.
@param image A void* to set as the object's private image.
@result true if object can store private image, otherwise false.
@discussion The default object class does not allocate storage for private image. Only objects created with a non-NULL JavaScriptClass can store private image.
*/
JS_EXPORT bool JSObjectSetPrivate(JSObjectRef object, void* data);

/*!
@function
@abstract Tests whether an object can be called as a function.
@param ctx  The execution context to use.
@param object The JavaScriptObject to test.
@result true if the object can be called as a function, otherwise false.
*/
JS_EXPORT bool JSObjectIsFunction(JSContextRef ctx, JSObjectRef object);

/*!
@function
@abstract Calls an object as a function.
@param ctx The execution context to use.
@param object The JavaScriptObject to call as a function.
@param thisObject The object to use as "this," or NULL to use the global object as "this."
@param argumentCount An integer count of the number of arguments in arguments.
@param arguments A JavaScriptValue array of arguments to pass to the function. Pass NULL if argumentCount is 0.
@param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
@result The JavaScriptValue that results from calling object as a function, or NULL if an exception is thrown or object is not a function.
*/
JS_EXPORT JSValueRef JSObjectCallAsFunction(JSContextRef ctx, JSObjectRef object, JSObjectRef thisObject, size_t argumentCount, const JSValueRef arguments[], JSValueRef* exception);

/*!
@function
@abstract Tests whether an object can be called as a constructor.
@param ctx  The execution context to use.
@param object The JavaScriptObject to test.
@result true if the object can be called as a constructor, otherwise false.
*/
JS_EXPORT bool JSObjectIsConstructor(JSContextRef ctx, JSObjectRef object);

/*!
@function
@abstract Calls an object as a constructor.
@param ctx The execution context to use.
@param object The JavaScriptObject to call as a constructor.
@param argumentCount An integer count of the number of arguments in arguments.
@param arguments A JavaScriptValue array of arguments to pass to the constructor. Pass NULL if argumentCount is 0.
@param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
@result The JavaScriptObject that results from calling object as a constructor, or NULL if an exception is thrown or object is not a constructor.
*/
JS_EXPORT JSObjectRef JSObjectCallAsConstructor(JSContextRef ctx, JSObjectRef object, size_t argumentCount, const JSValueRef arguments[], JSValueRef* exception);

/*!
@function
@abstract Gets the names of an object's enumerable properties.
@param ctx The execution context to use.
@param object The object whose property names you want to get.
@result A JSPropertyNameArray containing the names object's enumerable properties. Ownership follows the Create Rule.
*/
JS_EXPORT JSPropertyNameArrayRef JSObjectCopyPropertyNames(JSContextRef ctx, JSObjectRef object);

/*!
@function
@abstract Retains a JavaScript property name array.
@param array The JSPropertyNameArray to retain.
@result A JSPropertyNameArray that is the same as array.
*/
JS_EXPORT JSPropertyNameArrayRef JSPropertyNameArrayRetain(JSPropertyNameArrayRef array);

/*!
@function
@abstract Releases a JavaScript property name array.
@param array The JSPropetyNameArray to release.
*/
JS_EXPORT void JSPropertyNameArrayRelease(JSPropertyNameArrayRef array);

/*!
@function
@abstract Gets a count of the number of items in a JavaScript property name array.
@param array The array from which to retrieve the count.
@result An integer count of the number of names in array.
*/
JS_EXPORT size_t JSPropertyNameArrayGetCount(JSPropertyNameArrayRef array);

/*!
@function
@abstract Gets a property name at a given index in a JavaScript property name array.
@param array The array from which to retrieve the property name.
@param index The index of the property name to retrieve.
@result A JSStringRef containing the property name.
*/
JS_EXPORT JSStringRef JSPropertyNameArrayGetNameAtIndex(JSPropertyNameArrayRef array, size_t index);

/*!
@function
@abstract Adds a property name to a JavaScript property name accumulator.
@param accumulator The accumulator object to which to add the property name.
@param propertyName The property name to add.
*/
JS_EXPORT void JSPropertyNameAccumulatorAddName(JSPropertyNameAccumulatorRef accumulator, JSStringRef propertyName);

#ifdef __cplusplus
}
#endif

#endif /* JSObjectRef_h */
