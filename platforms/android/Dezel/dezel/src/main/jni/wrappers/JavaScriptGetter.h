#ifndef PROPERTYGETTER_H
#define PROPERTYGETTER_H

#include <DLValue.h>
#include "jni_init.h"

/**
 * Executes a method with a property getter callback as parameter.
 * @function JavaScriptGetterExecute
 * @since 0.1.0
 */
jlong JavaScriptGetterExecute(JNIEnv *env, jobject context, jclass cls, jobject instance, jmethodID function, JSObjectRef object, JSValueRef callee, size_t argc, JSValueRef const *argv);

#endif
