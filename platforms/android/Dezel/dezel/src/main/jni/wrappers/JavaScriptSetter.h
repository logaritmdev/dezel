#ifndef JavaScriptSetter_h
#define PROPERTYSETTER_H

#include <JavaScriptValue.h>
#include "jni_init.h"

/**
 * Executes a method with a property setter callback as parameter.
 * @function JavaScriptSetterExecute
 * @since 0.1.0
 */
jlong JavaScriptSetterExecute(JNIEnv* env, jobject context, jclass cls, jobject instance, jmethodID function, JSObjectRef object, JSValueRef callee, size_t argc, JSValueRef const *argv);

#endif
