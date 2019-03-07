#include "jni_module_core.h"
#include "JavaScriptFunction.h"
#include "JavaScriptFunctionWrapper.h"

static JSValueRef
JavaScriptFunctionWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	JavaScriptFunctionWrapperRef wrapper = (JavaScriptFunctionWrapperRef) DLValueGetAssociatedObject(context, callee);

	jlong result = JavaScriptFunctionExecute(
		wrapper->env,
		wrapper->ctx,
		wrapper->handler,
		JavaScriptFunctionWrapperExecute,
		object,
		callee,
		argc,
		argv
	);

	return result ? (JSValueRef) result : NULL;
}

static void
JavaScriptFunctionWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	JavaScriptFunctionWrapperRef wrapper = (JavaScriptFunctionWrapperRef) DLValueDataGetAssociatedObject(handle);
	if (wrapper == NULL) {
		return;
	}

	wrapper->env->DeleteGlobalRef(wrapper->ctx);
	wrapper->env->DeleteGlobalRef(wrapper->handler);
}

JavaScriptFunctionWrapperRef
JavaScriptFunctionWrapperCreate(JNIEnv *env, JSContextRef context, jobject handler, const char *name, jobject ctx)
{
	JSObjectRef function = DLValueCreateFunction(context, &JavaScriptFunctionWrapperCallback, name);

	JavaScriptFunctionWrapperRef wrapper = new JavaScriptFunctionWrapper();
	wrapper->env = env;
	wrapper->ctx = env->NewGlobalRef(ctx);
	wrapper->handler = env->NewGlobalRef(handler);
	wrapper->function = function;

	DLValueSetFinalizeHandler(context, function, &JavaScriptFunctionWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
