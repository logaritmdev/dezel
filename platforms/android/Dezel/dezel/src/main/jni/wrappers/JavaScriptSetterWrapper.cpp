#include "JavaScriptSetter.h"
#include "JavaScriptSetterWrapper.h"

static JSValueRef
JavaScriptSetterWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	auto wrapper = reinterpret_cast<JavaScriptSetterWrapperRef>(DLValueGetAssociatedObject(context, callee));

	auto result = JavaScriptSetterExecute(
		wrapper->env,
		wrapper->ctx,
		NULL,
		wrapper->callback,
		JavaScriptSetterWrapperExecute,
		object,
		callee,
		argc,
		argv
	);

	return result ? reinterpret_cast<JSValueRef>(result) : NULL;
}

static void
JavaScriptSetterWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	auto wrapper = reinterpret_cast<JavaScriptSetterWrapperRef>(DLValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->callback);
	}
}

JavaScriptSetterWrapperRef
JavaScriptSetterWrapperCreate(JNIEnv* env, JSContextRef context, jobject callback, const char* name, jobject ctx)
{
	auto function = DLValueCreateFunction(context, &JavaScriptSetterWrapperCallback, name);

	auto wrapper = new JavaScriptSetterWrapper();
	wrapper->env = env;
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = JNIGlobalRef(env, callback);
	wrapper->function = function;

	DLValueSetFinalizeHandler(context, function, &JavaScriptSetterWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
