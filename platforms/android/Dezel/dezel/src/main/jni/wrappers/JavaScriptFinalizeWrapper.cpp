#include <jni.h>
#include <DLValue.h>
#include <DLValuePrivate.h>
#include "JavaScriptFinalizeWrapper.h"

static void
JavaScriptFinalizeWrapperCallback(JSContextRef context, DLValueDataRef handle)
{
	JavaScriptFinalizeWrapperRef wrapper = (JavaScriptFinalizeWrapperRef) DLValueDataGetAttribute(handle, kJavaScriptFinalizeWrapperKey);
	if (wrapper == NULL) {
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

	DLValueDataSetAttribute(handle, kJavaScriptFinalizeWrapperKey, NULL);

	delete wrapper;
}

JavaScriptFinalizeWrapperRef
JavaScriptFinalizeWrapperCreate(JNIEnv *env, JSContextRef context, JSObjectRef handle, jobject callback, jobject ctx)
{
	auto wrapper = new JavaScriptFinalizeWrapper();
	wrapper->env = env;
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = env->NewGlobalRef(callback);

	DLValueSetAttribute(context, handle, kJavaScriptFinalizeWrapperKey, wrapper);
	DLValueSetFinalizeHandler(context, handle, &JavaScriptFinalizeWrapperCallback);
	return wrapper;
}
