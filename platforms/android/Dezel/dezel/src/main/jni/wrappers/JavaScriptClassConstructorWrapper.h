#ifndef JavaScriptClassConstructorWrapper_h
#define JavaScriptClassConstructorWrapper_h

#include <JavaScriptValue.h>
#include <JavaScriptContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptClassConstructorWrapper
 * @since 0.1.0
 */
struct JavaScriptClassConstructorWrapper {
	JNIEnv* env;
	jobject ctx;
	jclass cls;
	jmethodID constructor;
	jmethodID callback;
	JSObjectRef function;
};

/**
 * @typedef JavaScriptClassConstructorWrapperRef
 * @since 0.1.0
 */
typedef struct JavaScriptClassConstructorWrapper* JavaScriptClassConstructorWrapperRef;

/**
 * @function JavaScriptClassConstructorWrapperCreate
 * @since 0.1.0
 */
JavaScriptClassConstructorWrapperRef JavaScriptClassConstructorWrapperCreate(JNIEnv* env, JSContextRef context, const char* name, const char* fqmn, jclass cls, jobject ctx);

#endif
