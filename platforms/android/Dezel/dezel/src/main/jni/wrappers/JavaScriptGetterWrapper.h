#ifndef JavaScriptGetterWrapper_h
#define JavaScriptGetterWrapper_h

#include <JavaScriptValue.h>
#include <JavaScriptContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptGetterWrapper
 * @since 0.1.0
 */
struct JavaScriptGetterWrapper {
	JNIEnv* env;
	jobject ctx;
	jobject callback;
	JSObjectRef function;
};

/**
 * @typedef JavaScriptGetterWrapperRef
 * @since 0.1.0
 */
typedef struct JavaScriptGetterWrapper* JavaScriptGetterWrapperRef;

/**
 * @function JavaScriptGetterWrapperCreate
 * @since 0.1.0
 */
JavaScriptGetterWrapperRef JavaScriptGetterWrapperCreate(JNIEnv* env, JSContextRef context, jobject callback, const char* name, jobject ctx);

#endif
