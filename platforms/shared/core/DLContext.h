#ifndef DLContext_h
#define DLContext_h

#ifdef ANDROID
#include "JavaScriptCore/JavaScriptCore.h"
#else
#import <JavaScriptCore/JavaScriptCore.h>
#endif

/**
 * The error holder holder.
 * @typedef DLExceptionHandler
 * @since 0.1.0
 */
typedef void (*DLExceptionHandler)(JSContextRef context, JSValueRef error);

/**
 * The array for each callback.
 * @typedef DLValueForEachHandler
 * @since 0.7.0
 */
typedef void (*DLValueForEachHandler)(JSContextRef context, JSValueRef value, int index, void* data);

/**
 * The object for each callback.
 * @typedef DLValueForOwnHandler
 * @since 0.7.0
 */
typedef void (*DLValueForOwnHandler)(JSContextRef context, JSValueRef value, const char *name, void* data);

#if __cplusplus
extern "C" {
#endif

/**
 * Creates a new context.
 * @function DLContextCreate
 * @since 0.1.0
 */
JSContextRef DLContextCreate(const char* name);

/**
 * Releases the context.
 * @function DLContextDelete
 * @since 0.1.0
 */
void DLContextDelete(JSContextRef context);

/**
 * Sets the JavaScriptContext Name
 * @function DLContextSetName
 * @since 0.1.0
 */
void DLContextSetName(JSContextRef context, const char* name);

/**
 * Returns the global object.
 * @function DLContextGetGlobalObject
 * @since 0.1.0
 */
JSObjectRef DLContextGetGlobalObject(JSContextRef context);

/**
 * Evaluates code within the current context.
 * @function DLContextEvaluate
 * @since 0.1.0
 */
void DLContextEvaluate(JSContextRef context, const char* code, const char* file);

/**
 * Sets an attribute on the specified context.
 * @function DLContextSetAttribute
 * @since 0.1.0
 */
void DLContextSetAttribute(JSContextRef context, long long key, void *value);

/**
 * Gets an attribute from the specified context.
 * @function DLContextSetAttribute
 * @since 0.1.0
 */
void * DLContextGetAttribute(JSContextRef context, long long key);

/**
 * Adds an error execute for the current context.
 * @function DLContextSetExceptionHandler
 * @since 0.1.0
 */
void DLContextSetExceptionHandler(JSContextRef context, DLExceptionHandler handler);

/**
 * Dispatches the error to the proper error value.
 * @function DLContextHandleError
 * @since 0.1.0
 */
void DLContextHandleError(JSContextRef context, JSValueRef error);

#if __cplusplus
}
#endif

#endif
