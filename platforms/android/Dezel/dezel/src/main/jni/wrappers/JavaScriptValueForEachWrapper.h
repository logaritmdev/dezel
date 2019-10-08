#ifndef JavaScriptValueForEachWrapper_h
#define JavaScriptValueForEachWrapper_h

#include <JavaScriptValue.h>
#include <JavaScriptContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptValueForEachWrapper
 * @since 0.7.0
 */
struct JavaScriptValueForEachWrapper {
	JNIEnv* env;
	jobject callback;
};

/**
 * @typedef JavaScriptValueForEachWrapperRef
 * @since 0.7.0
 */
typedef struct JavaScriptValueForEachWrapper* JavaScriptValueForEachWrapperRef;

/**
 * @function JavaScriptValueForEachWrapperCreate
 * @since 0.7.0
 */
JavaScriptValueForEachWrapperRef JavaScriptValueForEachWrapperCreate(JNIEnv* env, jobject handler);

/**
 * @function JavaScriptValueForEachWrapperDelete
 * @since 0.7.0
 */
void JavaScriptValueForEachWrapperDelete(JNIEnv* env, JavaScriptValueForEachWrapperRef wrapper);

#endif
