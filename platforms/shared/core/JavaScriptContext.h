#ifndef JavaScriptContext_h
#define JavaScriptContext_h

#ifdef ANDROID
#include "JavaScriptCore/JavaScriptCore.h"
#else
#import <JavaScriptCore/JavaScriptCore.h>
#endif

/**
 * The error holder holder.
 * @typedef JavaScriptContextExceptionHandler
 * @since 0.7.0
 */
typedef void (*JavaScriptContextExceptionHandler)(JSContextRef context, JSValueRef error);

/**
 * The array for each callback.
 * @typedef JavaScriptValueForEachHandler
 * @since 0.7.0
 */
typedef void (*JavaScriptValueForEachHandler)(JSContextRef context, JSValueRef value, int index, void* data);

/**
 * The object for each callback.
 * @typedef JavaScriptValueForOwnHandler
 * @since 0.7.0
 */
typedef void (*JavaScriptValueForOwnHandler)(JSContextRef context, JSValueRef value, const char *name, void* data);

#if __cplusplus
extern "C" {
#endif

/**
 * Creates a new context.
 * @function JavaScriptContextCreate
 * @since 0.7.0
 */
JSContextRef JavaScriptContextCreate(const char* name);

/**
 * Releases the context.
 * @function JavaScriptContextDelete
 * @since 0.7.0
 */
void JavaScriptContextDelete(JSContextRef context);

/**
 * Sets the JavaScriptContext Name
 * @function JavaScriptContextSetName
 * @since 0.7.0
 */
void JavaScriptContextSetName(JSContextRef context, const char* name);

/**
 * Returns the global object.
 * @function JavaScriptContextGetGlobalObject
 * @since 0.7.0
 */
JSObjectRef JavaScriptContextGetGlobalObject(JSContextRef context);

/**
 * Evaluates code within the current context.
 * @function JavaScriptContextEvaluate
 * @since 0.7.0
 */
void JavaScriptContextEvaluate(JSContextRef context, const char* code, const char* file);

/**
 * Sets an attribute on the specified context.
 * @function JavaScriptContextSetAttribute
 * @since 0.7.0
 */
void JavaScriptContextSetAttribute(JSContextRef context, long long key, void *value);

/**
 * Gets an attribute from the specified context.
 * @function JavaScriptContextSetAttribute
 * @since 0.7.0
 */
void* JavaScriptContextGetAttribute(JSContextRef context, long long key);

/**
 * Adds an error execute for the current context.
 * @function JavaScriptContextSetExceptionHandler
 * @since 0.7.0
 */
void JavaScriptContextSetExceptionHandler(JSContextRef context, JavaScriptContextExceptionHandler handler);

/**
 * Dispatches the error to the proper error value.
 * @function JavaScriptContextHandleError
 * @since 0.7.0
 */
void JavaScriptContextHandleError(JSContextRef context, JSValueRef error);

#if __cplusplus
}
#endif

#endif
