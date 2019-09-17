#include <jni.h>
#include "JavaScriptExceptionWrapper.h"

JavaScriptExceptionWrapperRef
JavaScriptExceptionWrapperCreate(JNIEnv* env, jobject callback, jobject ctx)
{
	auto wrapper = new JavaScriptExceptionWrapper();
	wrapper->env = env;
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = env->NewGlobalRef(callback);
	return wrapper;
}
