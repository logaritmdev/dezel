#ifndef JavaScriptClassStaticSetterWrapper_h
#define JavaScriptClassStaticSetterWrapper_h

#include <JavaScriptValue.h>
#include <JavaScriptContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptClassStaticSetterWrapper
 * @since 0.7.0
 */
struct JavaScriptClassStaticSetterWrapper {
	JNIEnv* env;
	jclass cls;
	jobject ctx;
	jmethodID callback;
	JSObjectRef function;
};

/**
 * @typedef JavaScriptClassStaticSetterWrapperRef
 * @since 0.7.0
 */
typedef struct JavaScriptClassStaticSetterWrapper* JavaScriptClassStaticSetterWrapperRef;

/**
 * @function JavaScriptClassStaticSetterWrapperCreate
 * @since 0.7.0
 */
JavaScriptClassStaticSetterWrapperRef JavaScriptClassStaticSetterWrapperCreate(JNIEnv* env, JSContextRef context, const char* name, const char* fqmn, jclass cls, jobject ctx);

#endif
