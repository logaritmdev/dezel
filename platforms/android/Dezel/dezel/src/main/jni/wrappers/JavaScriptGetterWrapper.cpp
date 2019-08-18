#include "JavaScriptGetter.h"
#include "JavaScriptGetterWrapper.h"

static JSValueRef
JavaScriptGetterWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	auto wrapper = (JavaScriptGetterWrapperRef) DLValueGetAssociatedObject(context, callee);

	auto result = JavaScriptGetterExecute(
		wrapper->env,
		wrapper->ctx,
		NULL,
		wrapper->callback,
		JavaScriptGetterWrapperExecute,
		object,
		callee,
		argc,
		argv
	);

	return result ? reinterpret_cast<JSValueRef>(result) : NULL;
}

static void
JavaScriptGetterWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	auto wrapper = reinterpret_cast<JavaScriptGetterWrapperRef>(DLValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->callback);
	}
}

JavaScriptGetterWrapperRef
JavaScriptGetterWrapperCreate(JNIEnv *env, JSContextRef context, jobject callback, const char *name, jobject ctx)
{
	JSObjectRef function = DLValueCreateFunction(context, &JavaScriptGetterWrapperCallback, name);

	auto wrapper = new JavaScriptGetterWrapper();
	wrapper->env = env;
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = JNIGlobalRef(env, callback);
	wrapper->function = function;

	DLValueSetFinalizeHandler(context, function, &JavaScriptGetterWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
