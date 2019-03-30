#include "jni_init.h"
#include "jni_module_core.h"
#include <DLContext.h>
#include <DLValue.h>
#include "JavaScriptFunction.h"
#include "JavaScriptClassFunctionWrapper.h"

static JSValueRef
JavaScriptClassFunctionWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	JavaScriptClassFunctionWrapperRef wrapper = (JavaScriptClassFunctionWrapperRef) DLValueGetAssociatedObject(context, callee);
	if (wrapper == NULL) {
		return NULL;
	}

	jobject instance = (jobject) DLValueGetAssociatedObject(context, object);
	if (instance == NULL) {
		return NULL;
	}

	jlong result = JavaScriptFunctionExecute(
		wrapper->env,
		wrapper->ctx,
		instance,
		wrapper->handler,
		object,
		callee,
		argc,
		argv
	);

	return result ? (JSValueRef) result : NULL;
}

static void
JavaScriptClassFunctionWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	JavaScriptClassFunctionWrapperRef wrapper = (JavaScriptClassFunctionWrapperRef) DLValueDataGetAssociatedObject(handle);
	if (wrapper == NULL) {
		return;
	}

	wrapper->env->DeleteGlobalRef(wrapper->ctx);
}

JavaScriptClassFunctionWrapperRef
JavaScriptClassFunctionWrapperCreate(JNIEnv *env, JSContextRef context, const char *name, const char *fqmn, jclass cls, jobject ctx)
{
	JSObjectRef function = DLValueCreateFunction(context, &JavaScriptClassFunctionWrapperCallback, name);

	JavaScriptClassFunctionWrapperRef wrapper = new JavaScriptClassFunctionWrapper();
	wrapper->env = env;
	wrapper->ctx = env->NewGlobalRef(ctx);
	wrapper->function = function;
	wrapper->handler = JNIGetMethod(env, cls, fqmn, "(Lca/logaritm/dezel/core/JavaScriptFunctionCallback;)V");

	DLValueSetFinalizeHandler(context, function, &JavaScriptClassFunctionWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
