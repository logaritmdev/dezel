#include <jni.h>
#include "JavaScriptExceptionWrapper.h"

JavaScriptExceptionWrapperRef
JavaScriptExceptionWrapperCreate(JNIEnv *env, jobject handler, jobject ctx)
{
	JavaScriptExceptionWrapperRef wrapper = new JavaScriptExceptionWrapper();
	wrapper->env = env;
	wrapper->ctx = env->NewGlobalRef(ctx);
	wrapper->handler = env->NewGlobalRef(handler);
	return wrapper;
}
