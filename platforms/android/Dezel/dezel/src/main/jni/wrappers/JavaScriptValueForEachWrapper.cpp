#include "JavaScriptValueForEachWrapper.h"

JavaScriptValueForEachWrapperRef
JavaScriptValueForEachWrapperCreate(JNIEnv *env, jobject handler)
{
	JavaScriptValueForEachWrapperRef wrapper = new JavaScriptValueForEachWrapper();
	wrapper->env = env;
	wrapper->handler = env->NewGlobalRef(handler);
	return wrapper;
}

void
JavaScriptValueForEachWrapperDelete(JNIEnv *env, JavaScriptValueForEachWrapperRef wrapper)
{
	env->DeleteGlobalRef(wrapper->handler);
	delete wrapper;
}