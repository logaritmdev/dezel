#include "jni_module_core.h"
#include "JavaScriptFunction.h"
#include "JavaScriptFunctionWrapper.h"

static JSValueRef
JavaScriptFunctionWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	auto wrapper = reinterpret_cast<JavaScriptFunctionWrapperRef>(DLValueGetAssociatedObject(context, callee));

	auto result = JavaScriptFunctionExecute(
		wrapper->env,
		wrapper->ctx,
		NULL,
		wrapper->callback,
		JavaScriptFunctionWrapperExecute,
		object,
		callee,
		argc,
		argv
	);

	return result ? reinterpret_cast<JSValueRef>(result) : NULL;
}

static void
JavaScriptFunctionWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	auto wrapper = reinterpret_cast<JavaScriptFunctionWrapperRef>(DLValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->callback);
	}
}

JavaScriptFunctionWrapperRef
JavaScriptFunctionWrapperCreate(JNIEnv *env, JSContextRef context, jobject callback, const char *name, jobject ctx)
{
	auto function = DLValueCreateFunction(context, &JavaScriptFunctionWrapperCallback, name);

	auto wrapper = new JavaScriptFunctionWrapper();
	wrapper->env = env;
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = env->NewGlobalRef(callback);
	wrapper->function = function;

	DLValueSetFinalizeHandler(context, function, &JavaScriptFunctionWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
