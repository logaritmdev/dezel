#ifndef JavaScriptExceptionWrapper_h
#define JavaScriptExceptionWrapper_h

#include <JavaScriptValue.h>
#include <JavaScriptContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptExceptionWrapper
 * @since 0.1.0
 */
struct JavaScriptExceptionWrapper {
	JNIEnv* env;
	jobject ctx;
	jobject callback;
};

/**
 * @typedef JavaScriptExceptionWrapperRef
 * @since 0.1.0
 */
typedef struct JavaScriptExceptionWrapper* JavaScriptExceptionWrapperRef;

/**
 * @function JavaScriptExceptionWrapperCreate
 * @since 0.1.0
 */
JavaScriptExceptionWrapperRef JavaScriptExceptionWrapperCreate(JNIEnv* env, jobject handler, jobject ctx);

#endif
