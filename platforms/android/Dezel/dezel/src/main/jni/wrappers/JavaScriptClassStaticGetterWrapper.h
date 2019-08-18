#ifndef CLASSSTATICPROPERTYGETTERWRAPPER_H
#define CLASSSTATICPROPERTYGETTERWRAPPER_H

#include <DLValue.h>
#include <DLContext.h>
#include "jni_init.h"
#include "jni_module_core.h"

/**
 * @struct JavaScriptClassStaticGetterWrapper
 * @since 0.7.0
 */
struct JavaScriptClassStaticGetterWrapper {
	JNIEnv *env;
	jclass cls;
	jobject ctx;
	jmethodID callback;
	JSObjectRef function;
};

/**
 * @typedef JavaScriptClassStaticGetterWrapperRef
 * @since 0.7.0
 */
typedef struct JavaScriptClassStaticGetterWrapper* JavaScriptClassStaticGetterWrapperRef;

/**
 * @function JavaScriptClassStaticGetterWrapperCreate
 * @since 0.7.0
 */
JavaScriptClassStaticGetterWrapperRef JavaScriptClassStaticGetterWrapperCreate(JNIEnv *env, JSContextRef context, const char *name, const char *fqmn, jclass cls, jobject ctx);

#endif
