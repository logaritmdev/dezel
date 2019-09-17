#include "JavaScriptValueForEachWrapper.h"

JavaScriptValueForEachWrapperRef
JavaScriptValueForEachWrapperCreate(JNIEnv* env, jobject callback)
{
	auto wrapper = new JavaScriptValueForEachWrapper();
	wrapper->env = env;
	wrapper->callback = JNIGlobalRef(env, callback);
	return wrapper;
}

void
JavaScriptValueForEachWrapperDelete(JNIEnv* env, JavaScriptValueForEachWrapperRef wrapper)
{
	env->DeleteGlobalRef(wrapper->callback);
	delete wrapper;
}