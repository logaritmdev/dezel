#ifndef JavaScriptValueForOwnWrapper_h
#define JavaScriptValueForOwnWrapper_h

#include <JavaScriptValue.h>
#include <JavaScriptContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptValueForOwnWrapper
 * @since 0.7.0
 */
struct JavaScriptValueForOwnWrapper {
	JNIEnv* env;
	jobject callback;
};

/**
 * @typedef JavaScriptValueForOwnWrapperRef
 * @since 0.7.0
 */
typedef struct JavaScriptValueForOwnWrapper* JavaScriptValueForOwnWrapperRef;

/**
 * @function JavaScriptValueForOwnWrapperCreate
 * @since 0.7.0
 */
JavaScriptValueForOwnWrapperRef JavaScriptValueForOwnWrapperCreate(JNIEnv* env, jobject handler);

/**
 * @function JavaScriptValueForOwnWrapperDelete
 * @since 0.7.0
 */
void JavaScriptValueForOwnWrapperDelete(JNIEnv* env, JavaScriptValueForOwnWrapperRef wrapper);

#endif
