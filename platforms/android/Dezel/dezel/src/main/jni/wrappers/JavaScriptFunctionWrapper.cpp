#include "jni_module_core.h"
#include "JavaScriptFunction.h"
#include "JavaScriptFunctionWrapper.h"

static JSValueRef
JavaScriptFunctionWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	auto wrapper = reinterpret_cast<JavaScriptFunctionWrapperRef>(JavaScriptValueGetAssociatedObject(context, callee));

	auto result = JavaScriptFunctionExecute(
		wrapper->env,
		wrapper->ctx,
		nullptr,
		wrapper->callback,
		JavaScriptFunctionWrapperExecute,
		object,
		callee,
		argc,
		argv
	);

	return result ? reinterpret_cast<JSValueRef>(result) : nullptr;
}

static void
JavaScriptFunctionWrapperFinalize(JSContextRef context, JavaScriptValueDataRef handle)
{
	auto wrapper = reinterpret_cast<JavaScriptFunctionWrapperRef>(JavaScriptValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->callback);
	}
}

JavaScriptFunctionWrapperRef
JavaScriptFunctionWrapperCreate(JNIEnv* env, JSContextRef context, jobject callback, const char* name, jobject ctx)
{
	auto function = JavaScriptValueCreateFunction(context, &JavaScriptFunctionWrapperCallback, name);

	auto wrapper = new JavaScriptFunctionWrapper();
	wrapper->env = env;
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = env->NewGlobalRef(callback);
	wrapper->function = function;

	JavaScriptValueSetFinalizeHandler(context, function, &JavaScriptFunctionWrapperFinalize);
	JavaScriptValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
