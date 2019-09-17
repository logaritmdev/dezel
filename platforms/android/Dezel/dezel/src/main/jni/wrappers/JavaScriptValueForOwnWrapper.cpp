#include "JavaScriptValueForOwnWrapper.h"

JavaScriptValueForOwnWrapperRef
JavaScriptValueForOwnWrapperCreate(JNIEnv* env, jobject callback)
{
	auto wrapper = new JavaScriptValueForOwnWrapper();
	wrapper->env = env;
	wrapper->callback = JNIGlobalRef(env, callback);
	return wrapper;
}

void
JavaScriptValueForOwnWrapperDelete(JNIEnv* env, JavaScriptValueForOwnWrapperRef wrapper)
{
	env->DeleteGlobalRef(wrapper->callback);
	delete wrapper;
}