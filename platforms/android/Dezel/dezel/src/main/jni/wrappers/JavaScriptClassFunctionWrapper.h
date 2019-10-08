#ifndef JavaScriptClassFunctionWrapper_h
#define JavaScriptClassFunctionWrapper_h

#include <JavaScriptValue.h>
#include <JavaScriptContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptClassFunctionWrapper
 * @since 0.1.0
 */
struct JavaScriptClassFunctionWrapper {
	JNIEnv* env;
	jobject ctx;
	jclass cls;
	jmethodID callback;
	JSObjectRef function;
};

/**
 * @typedef JavaScriptClassFunctionWrapperRef
 * @since 0.1.0
 */
typedef struct JavaScriptClassFunctionWrapper* JavaScriptClassFunctionWrapperRef;

/**
 * @function JavaScriptClassFunctionWrapperCreate
 * @since 0.1.0
 */
JavaScriptClassFunctionWrapperRef JavaScriptClassFunctionWrapperCreate(JNIEnv* env, JSContextRef context, const char* name, const char* fqmn, jclass cls, jobject ctx);

#endif
