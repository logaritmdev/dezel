#include "JavaScriptValueForOwnWrapper.h"

JavaScriptValueForOwnWrapperRef
JavaScriptValueForOwnWrapperCreate(JNIEnv *env, jobject handler)
{
	JavaScriptValueForOwnWrapperRef wrapper = new JavaScriptValueForOwnWrapper();
	wrapper->env = env;
	wrapper->handler = env->NewGlobalRef(handler);
	return wrapper;
}

void
JavaScriptValueForOwnWrapperDelete(JNIEnv *env, JavaScriptValueForOwnWrapperRef wrapper)
{
	env->DeleteGlobalRef(wrapper->handler);
	delete wrapper;
}