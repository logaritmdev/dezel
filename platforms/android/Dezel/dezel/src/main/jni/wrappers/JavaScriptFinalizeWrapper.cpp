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
		(jlong) handle
	);

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->handler,
		JavaScriptFinalizeWrapperExecute,
		callback
	);

	wrapper->env->DeleteLocalRef(callback);
	wrapper->env->DeleteGlobalRef(wrapper->ctx);
	wrapper->env->DeleteGlobalRef(wrapper->handler);

	DLValueDataDeleteAttribute(handle, kJavaScriptFinalizeWrapperKey);

	delete wrapper;
}

JavaScriptFinalizeWrapperRef
JavaScriptFinalizeWrapperCreate(JNIEnv *env, JSContextRef context, JSObjectRef handle, jobject handler, jobject ctx)
{
	JavaScriptFinalizeWrapperRef wrapper = new JavaScriptFinalizeWrapper();
	wrapper->env = env;
	wrapper->ctx = env->NewGlobalRef(ctx);
	wrapper->handler = env->NewGlobalRef(handler);

	DLValueSetAttribute(context, handle, kJavaScriptFinalizeWrapperKey, wrapper);
	DLValueSetFinalizeHandler(context, handle, &JavaScriptFinalizeWrapperCallback);
	return wrapper;
}
