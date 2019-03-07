#include "jni_init.h"
#include "jni_module_core.h"
#include <DLContext.h>
#include <DLValue.h>
#include "JavaScriptSetter.h"
#include "JavaScriptClassSetterWrapper.h"

static JSValueRef
JavaScriptClassSetterWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	JavaScriptClassSetterWrapperRef wrapper = (JavaScriptClassSetterWrapperRef) DLValueGetAssociatedObject(context, callee);
	if (wrapper == NULL) {
		return NULL;
	}

	jobject instance = (jobject) DLValueGetAssociatedObject(context, object);
	if (instance == NULL) {
		return NULL;
	}

	jlong result = JavaScriptSetterExecute(
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
JavaScriptClassSetterWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	JavaScriptClassSetterWrapperRef wrapper = (JavaScriptClassSetterWrapperRef) DLValueDataGetAssociatedObject(handle);

	if (wrapper == NULL) {
		return;
	}

	wrapper->env->DeleteGlobalRef(wrapper->ctx);
}

JavaScriptClassSetterWrapperRef
JavaScriptClassSetterWrapperCreate(JNIEnv *env, JSContextRef context, const char *name, const char *fqmn, jclass cls, jobject ctx)
{
	JSObjectRef function = DLValueCreateFunction(context, &JavaScriptClassSetterWrapperCallback, name);

	JavaScriptClassSetterWrapperRef wrapper = new JavaScriptClassSetterWrapper();
	wrapper->env = env;
	wrapper->ctx = env->NewGlobalRef(ctx);
	wrapper->function = function;
	wrapper->handler = JNIGetMethod(env, cls, fqmn, "(Lca/logaritm/dezel/core/JavaScriptSetterCallback;)V");

	DLValueSetFinalizeHandler(context, function, &JavaScriptClassSetterWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
