#ifndef JavaScriptFunction_h
#define JavaScriptFunction_h

#include <JavaScriptValue.h>
#include "jni_init.h"

/**
 * Executes a method with a function callback as parameter.
 * @function JavaScriptFunctionExecute
 * @since 0.1.0
 */
jlong JavaScriptFunctionExecute(JNIEnv* env, jobject context, jclass cls, jobject instance, jmethodID function, JSObjectRef object, JSValueRef callee, size_t argc, JSValueRef const *argv);

#endif
