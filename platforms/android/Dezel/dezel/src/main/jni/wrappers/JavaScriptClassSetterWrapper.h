#ifndef JavaScriptClassSetterWrapper_h
#define JavaScriptClassSetterWrapper_h

#include <JavaScriptValue.h>
#include <JavaScriptContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptClassSetterWrapper
 * @since 0.1.0
 */
struct JavaScriptClassSetterWrapper {
	JNIEnv* env;
	jobject ctx;
	jclass cls;
	jmethodID callback;
	JSObjectRef function;
};

/**
 * @typedef JavaScriptClassSetterWrapperRef
 * @since 0.1.0
 */
typedef struct JavaScriptClassSetterWrapper* JavaScriptClassSetterWrapperRef;

/**
 * @function JavaScriptClassSetterWrapperCreate
 * @since 0.1.0
 */
JavaScriptClassSetterWrapperRef JavaScriptClassSetterWrapperCreate(JNIEnv* env, JSContextRef context, const char* name, const char* fqmn, jclass cls, jobject ctx);

#endif
