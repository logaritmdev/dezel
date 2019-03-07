#ifndef CLASSPROPERTYGETTERWRAPPER_H
#define CLASSPROPERTYGETTERWRAPPER_H

#include <DLValue.h>
#include <DLContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptClassGetterWrapper
 * @since 0.1.0
 */
struct JavaScriptClassGetterWrapper {
	JNIEnv *env;
	jobject ctx;
	jmethodID handler;
	JSObjectRef function;
};

/**
 * @typedef JavaScriptClassGetterWrapperRef
 * @since 0.1.0
 */
typedef struct JavaScriptClassGetterWrapper* JavaScriptClassGetterWrapperRef;

/**
 * @function JavaScriptClassGetterWrapperCreate
 * @since 0.1.0
 */
JavaScriptClassGetterWrapperRef JavaScriptClassGetterWrapperCreate(JNIEnv *env, JSContextRef context, const char *name, const char *fqmn, jclass cls, jobject ctx);

#endif
