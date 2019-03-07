#include "JavaScriptSetter.h"
#include "JavaScriptSetterWrapper.h"

static JSValueRef
JavaScriptSetterWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	JavaScriptSetterWrapperRef wrapper = (JavaScriptSetterWrapperRef) DLValueGetAssociatedObject(context, callee);
	if (wrapper == NULL) {
		return NULL;
	}

	jlong result = JavaScriptSetterExecute(
		wrapper->env,
		wrapper->ctx,
		wrapper->handler,
		JavaScriptSetterWrapperExecute,
		object,
		callee,
		argc,
		argv
	);

	return result ? (JSValueRef) result : NULL;
}

static void
JavaScriptSetterWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	JavaScriptSetterWrapperRef wrapper = (JavaScriptSetterWrapperRef) DLValueDataGetAssociatedObject(handle);

	if (wrapper == NULL) {
		return;
	}

	wrapper->env->DeleteGlobalRef(wrapper->ctx);
	wrapper->env->DeleteGlobalRef(wrapper->handler);
}

JavaScriptSetterWrapperRef
JavaScriptSetterWrapperCreate(JNIEnv *env, JSContextRef context, jobject handler, const char *name, jobject ctx)
{
	JSObjectRef function = DLValueCreateFunction(context, &JavaScriptSetterWrapperCallback, name);

	JavaScriptSetterWrapperRef wrapper = new JavaScriptSetterWrapper();
	wrapper->env = env;
	wrapper->ctx = env->NewGlobalRef(ctx);
	wrapper->handler = env->NewGlobalRef(handler);
	wrapper->function = function;

	DLValueSetFinalizeHandler(context, function, &JavaScriptSetterWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
