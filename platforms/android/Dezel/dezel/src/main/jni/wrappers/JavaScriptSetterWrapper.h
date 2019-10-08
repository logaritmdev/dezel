#ifndef JavaScriptSetterWrapper_h
#define JavaScriptSetterWrapper_h

#include <JavaScriptValue.h>
#include <JavaScriptContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptSetterWrapper
 * @since 0.1.0
 */
struct JavaScriptSetterWrapper {
	JNIEnv* env;
	jobject ctx;
	jobject callback;
	JSObjectRef function;
};

/**
 * @typedef JavaScriptSetterWrapperRef
 * @since 0.1.0
 */
typedef struct JavaScriptSetterWrapper* JavaScriptSetterWrapperRef;

/**
 * @function JavaScriptSetterWrapperCreate
 * @since 0.1.0
 */
JavaScriptSetterWrapperRef JavaScriptSetterWrapperCreate(JNIEnv* env, JSContextRef context, jobject callback, const char* name, jobject ctx);

#endif
