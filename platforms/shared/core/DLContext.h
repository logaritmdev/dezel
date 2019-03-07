#ifndef DLContext_h
#define DLContext_h

#ifdef ANDROID
#include "JavaScriptCore/JavaScriptCore.h"
#else
#import <JavaScriptCore/JavaScriptCore.h>
#endif

#define DLString const char *
#define DLNumber double
#define DLBoolean bool

/**
 * The error holder holder.
 * @typedef DLExceptionHandler
 * @since 0.1.0
 */
typedef void (*DLExceptionHandler)(JSContextRef context, JSValueRef error);

#if __cplusplus
extern "C" {
#endif

/**
 * Creates a new context.
 * @function DLContextCreate
 * @since 0.1.0
 */
JSContextRef DLContextCreate(DLString name);

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
void DLContextSetName(JSContextRef context, DLString name);

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
void DLContextEvaluate(JSContextRef context, DLString code, DLString file);

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
 * Deletes a property from the specified context.
 * @function DLContextGetProperty
 * @since 0.1.0
 */
void DLContextDeleteAttribute(JSContextRef context, long long key);

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
