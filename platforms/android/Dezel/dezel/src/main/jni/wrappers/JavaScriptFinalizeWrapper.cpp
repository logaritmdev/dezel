#include <jni.h>
#include <JavaScriptValue.h>
#include <JavaScriptValuePrivate.h>
#include "JavaScriptFinalizeWrapper.h"

static void
JavaScriptFinalizeWrapperCallback(JSContextRef context, JavaScriptValueDataRef handle)
{
	JavaScriptFinalizeWrapperRef wrapper = (JavaScriptFinalizeWrapperRef) JavaScriptValueDataGetAttribute(handle, kJavaScriptFinalizeWrapperKey);
	if (wrapper == nullptr) {
		return;
	}

	jobject callback = wrapper->env->NewObject(
		JavaScriptFinalizeCallbackClass,
		JavaScriptFinalizeCallbackConstructor,
		wrapper->ctx,
		reinterpret_cast<jlong>(handle)
	);

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->callback,
		JavaScriptFinalizeWrapperExecute,
		callback
	);

	wrapper->env->DeleteLocalRef(callback);
	wrapper->env->DeleteGlobalRef(wrapper->ctx);
	wrapper->env->DeleteGlobalRef(wrapper->callback);

	JavaScriptValueDataSetAttribute(handle, kJavaScriptFinalizeWrapperKey, nullptr);

	delete wrapper;
}

JavaScriptFinalizeWrapperRef
JavaScriptFinalizeWrapperCreate(JNIEnv* env, JSContextRef context, JSObjectRef handle, jobject callback, jobject ctx)
{
	auto wrapper = new JavaScriptFinalizeWrapper();
	wrapper->env = env;
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = env->NewGlobalRef(callback);

	JavaScriptValueSetAttribute(context, handle, kJavaScriptFinalizeWrapperKey, wrapper);
	JavaScriptValueSetFinalizeHandler(context, handle, &JavaScriptFinalizeWrapperCallback);
	return wrapper;
}
