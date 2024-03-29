#ifndef FUNCTIONWRAPPER_H
#define FUNCTIONWRAPPER_H

#include <DLValue.h>
#include <DLContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptFunctionWrapper
 * @since 0.1.0
 */
struct JavaScriptFunctionWrapper {
	JNIEnv *env;
	jobject ctx;
	jobject handler;
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
JavaScriptFunctionWrapperRef JavaScriptFunctionWrapperCreate(JNIEnv *env, JSContextRef context, jobject handler, const char *name, jobject ctx);

#endif
