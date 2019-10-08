#ifndef JNIModuleCore_h
#define JNIModuleCore_h

#include <jni.h>
#include <JavaScriptValue.h>
#include <JavaScriptContext.h>
#include "jni_init.h"

/**
 * @macro JNI_ARGS_CREATE
 * @since 0.1.0
 */
#define JNI_ARGS_CREATE(DEST) \
	jlong *jargs = new jlong[argc]; \
	for (int i = 0; i < argc; i++) jargs[i] = reinterpret_cast<jlong>(argv[i]); \
	JNI_LONG_ARRAY_CREATE(env, DEST, jargs, argc);

/**
 * @macro JNI_ARGS_DELETE
 * @since 0.1.0
 */
#define JNI_ARGS_DELETE(DEST) \
	JNI_LONG_ARRAY_DELETE(env, DEST); \
	delete[] jargs;

extern jclass StringClass;
extern jclass JavaScriptValueClass;
extern jclass JavaScriptObjectClass;
extern jclass JavaScriptContextClass;

extern jclass JavaScriptFinalizeWrapperClass;
extern jclass JavaScriptFunctionWrapperClass;
extern jclass JavaScriptPropertyGetterWrapperClass;
extern jclass JavaScriptPropertySetterWrapperClass;
extern jclass JavaScriptExceptionWrapperClass;

extern jclass JavaScriptValueForEachWrapperClass;
extern jclass JavaScriptValueForOwnWrapperClass;

extern jclass JavaScriptFinalizeCallbackClass;
extern jclass JavaScriptFunctionCallbackClass;
extern jclass JavaScriptGetterCallbackClass;
extern jclass JavaScriptSetterCallbackClass;

extern jfieldID JavaScriptFunctionCallbackResult;
extern jfieldID JavaScriptGetterCallbackResult;
extern jfieldID JavaScriptSetterCallbackResult;

extern jmethodID JavaScriptValueReset;
extern jmethodID JavaScriptValueConstructor;

extern jmethodID JavaScriptFinalizeCallbackConstructor;
extern jmethodID JavaScriptFunctionCallbackConstructor;
extern jmethodID JavaScriptGetterCallbackConstructor;
extern jmethodID JavaScriptSetterCallbackConstructor;

extern jmethodID JavaScriptFinalizeWrapperExecute;
extern jmethodID JavaScriptFunctionWrapperExecute;
extern jmethodID JavaScriptGetterWrapperExecute;
extern jmethodID JavaScriptSetterWrapperExecute;
extern jmethodID JavaScriptExceptionWrapperExecute;

extern jmethodID JavaScriptValueForEachWrapperExecute;
extern jmethodID JavaScriptValueForOwnWrapperExecute;

extern const long long kJavaScriptFinalizeWrapperKey;
extern const long long kJavaScriptExceptionWrapperKey;

/**
 * Initializes JNI related variables.
 * @function JNICoreModule
 * @since 0.7.0
 */
void JNICoreModule(JNIEnv* env);

#endif