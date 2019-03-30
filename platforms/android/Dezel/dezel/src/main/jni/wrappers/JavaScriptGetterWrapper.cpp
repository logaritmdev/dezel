#include "JavaScriptGetter.h"
#include "JavaScriptGetterWrapper.h"

static JSValueRef
JavaScriptGetterWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	JavaScriptGetterWrapperRef wrapper = (JavaScriptGetterWrapperRef) DLValueGetAssociatedObject(context, callee);
	if (wrapper == NULL) {
		return NULL;
	}

	jlong result = JavaScriptGetterExecute(
		wrapper->env,
		wrapper->ctx,
		wrapper->handler,
		JavaScriptGetterWrapperExecute,
		object,
		callee,
		argc,
		argv
	);

	return result ? (JSValueRef) result : NULL;
}

static void
JavaScriptGetterWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	JavaScriptGetterWrapperRef wrapper = (JavaScriptGetterWrapperRef) DLValueDataGetAssociatedObject(handle);
	if (wrapper == NULL) {
		return;
	}

	wrapper->env->DeleteGlobalRef(wrapper->ctx);
	wrapper->env->DeleteGlobalRef(wrapper->handler);
}

JavaScriptGetterWrapperRef
JavaScriptGetterWrapperCreate(JNIEnv *env, JSContextRef context, jobject handler, const char *name, jobject ctx)
{
	JSObjectRef function = DLValueCreateFunction(context, &JavaScriptGetterWrapperCallback, name);

	JavaScriptGetterWrapperRef wrapper = new JavaScriptGetterWrapper();
	wrapper->env = env;
	wrapper->ctx = env->NewGlobalRef(ctx);
	wrapper->handler = env->NewGlobalRef(handler);
	wrapper->function = function;

	DLValueSetFinalizeHandler(context, function, &JavaScriptGetterWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
