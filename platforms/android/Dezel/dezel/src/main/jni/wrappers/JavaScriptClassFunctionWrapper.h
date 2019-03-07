#ifndef CLASSFUNCTIONWRAPPER_H
#define CLASSFUNCTIONWRAPPER_H

#include <DLValue.h>
#include <DLContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptClassFunctionWrapper
 * @since 0.1.0
 */
struct JavaScriptClassFunctionWrapper {
	JNIEnv *env;
	jobject ctx;
	jmethodID handler;
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
JavaScriptClassFunctionWrapperRef JavaScriptClassFunctionWrapperCreate(JNIEnv *env, JSContextRef context, const char *name, const char *fqmn, jclass cls, jobject ctx);

#endif
