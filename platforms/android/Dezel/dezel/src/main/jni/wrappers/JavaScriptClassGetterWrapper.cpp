#include "jni_init.h"
#include "jni_module_core.h"
#include <DLContext.h>
#include <DLValue.h>
#include "JavaScriptGetter.h"
#include "JavaScriptClassGetterWrapper.h"

static JSValueRef
JavaScriptClassGetterWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	JavaScriptClassGetterWrapperRef wrapper = (JavaScriptClassGetterWrapperRef) DLValueGetAssociatedObject(context, callee);
	if (wrapper == NULL) {
		return NULL;
	}

	jobject instance = (jobject) DLValueGetAssociatedObject(context, object);
	if (instance == NULL) {
		return NULL;
	}

	jlong result = JavaScriptGetterExecute(
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
JavaScriptClassGetterWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	JavaScriptClassGetterWrapperRef wrapper = (JavaScriptClassGetterWrapperRef) DLValueDataGetAssociatedObject(handle);
	if (wrapper == NULL) {
		return;
	}

	wrapper->env->DeleteGlobalRef(wrapper->ctx);
}

JavaScriptClassGetterWrapperRef
JavaScriptClassGetterWrapperCreate(JNIEnv *env, JSContextRef context, const char *name, const char *fqmn, jclass cls, jobject ctx)
{
	JSObjectRef function = DLValueCreateFunction(context, &JavaScriptClassGetterWrapperCallback, name);

	JavaScriptClassGetterWrapperRef wrapper = new JavaScriptClassGetterWrapper();
	wrapper->env = env;
	wrapper->ctx = env->NewGlobalRef(ctx);
	wrapper->function = function;
	wrapper->handler = JNIGetMethod(env, cls, fqmn, "(Lca/logaritm/dezel/core/JavaScriptGetterCallback;)V");

	DLValueSetFinalizeHandler(context, function, &JavaScriptClassGetterWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
