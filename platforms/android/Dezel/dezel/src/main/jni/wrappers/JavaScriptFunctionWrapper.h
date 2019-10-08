#ifndef JavaScriptFunctionWrapper_h
#define JavaScriptFunctionWrapper_h

#include <JavaScriptValue.h>
#include <JavaScriptContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptFunctionWrapper
 * @since 0.1.0
 */
struct JavaScriptFunctionWrapper {
	JNIEnv* env;
	jobject ctx;
	jobject callback;
	JSObjectRef function;
};

/**
 * @typedef JavaScriptFunctionWrapperRef
 * @since 0.1.0
 */
typedef struct JavaScriptFunctionWrapper* JavaScriptFunctionWrapperRef;

/**
 * @function JavaScriptFunctionWrapperCreate
 * @since 0.1.0
 */
JavaScriptFunctionWrapperRef JavaScriptFunctionWrapperCreate(JNIEnv* env, JSContextRef context, jobject handler, const char* name, jobject ctx);

#endif
