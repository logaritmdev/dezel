#ifndef FINALIZEWRAPPER_H
#define FINALIZEWRAPPER_H

#include <DLValue.h>
#include <DLContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptFinalizeWrapper
 * @since 0.1.0
 */
struct JavaScriptFinalizeWrapper {
	JNIEnv* env;
	jobject ctx;
	jobject handler;
};

/**
 * @typedef JavaScriptFinalizeWrapperRef
 * @since 0.1.0
 */
typedef struct JavaScriptFinalizeWrapper* JavaScriptFinalizeWrapperRef;

/**
 * @function JavaScriptFinalizeWrapperCreate
 * @since 0.1.0
 */
JavaScriptFinalizeWrapperRef JavaScriptFinalizeWrapperCreate(JNIEnv *env, JSContextRef context, JSObjectRef handle, jobject handler, jobject ctx);

#endif
