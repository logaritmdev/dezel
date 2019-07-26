#ifndef JAVASCRIPTVALUEFOREACHWRAPPER_H
#define JAVASCRIPTVALUEFOREACHWRAPPER_H

#include <DLValue.h>
#include <DLContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptValueForEachWrapper
 * @since 0.7.0
 */
struct JavaScriptValueForEachWrapper {
	JNIEnv *env;
	jobject handler;
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
JavaScriptValueForEachWrapperRef JavaScriptValueForEachWrapperCreate(JNIEnv *env, jobject handler);

/**
 * @function JavaScriptValueForEachWrapperDelete
 * @since 0.7.0
 */
void JavaScriptValueForEachWrapperDelete(JNIEnv *env, JavaScriptValueForEachWrapperRef wrapper);

#endif
