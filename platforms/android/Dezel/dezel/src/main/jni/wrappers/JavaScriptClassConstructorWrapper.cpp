#include "jni_init.h"
#include "jni_module_core.h"
#include <DLContext.h>
#include <DLValue.h>
#include "JavaScriptFunction.h"
#include "JavaScriptFunctionWrapper.h"
#include "JavaScriptClassConstructorWrapper.h"

static JSValueRef
JavaScriptClassConstructorWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	JavaScriptClassConstructorWrapperRef wrapper = (JavaScriptClassConstructorWrapperRef) DLValueGetAssociatedObject(context, callee);
	if (wrapper == NULL) {
		return NULL;
	}

	jobject instance = wrapper->env->NewObject(
		wrapper->cls,
		wrapper->init,
		wrapper->ctx
	);

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		instance,
		JavaScriptValueReset,
		reinterpret_cast<jlong>(object),
		false
	);

	JNI_CHECK_EXCEPTION(wrapper->env);

	DLValueSetAssociatedObject(context, object, wrapper->env->NewGlobalRef(instance));

	JavaScriptFunctionExecute(
		wrapper->env,
		wrapper->ctx,
		instance,
		wrapper->handler,
		object,
		callee,
		argc,
		argv
	);

	wrapper->env->DeleteLocalRef(instance);

	return object;
}

static void
JavaScriptClassConstructorWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	JavaScriptClassConstructorWrapperRef wrapper = (JavaScriptClassConstructorWrapperRef) DLValueDataGetAssociatedObject(handle);
	if (wrapper == NULL) {
		return;
	}

	wrapper->env->DeleteGlobalRef(wrapper->ctx);
	wrapper->env->DeleteGlobalRef(wrapper->cls);
}

JavaScriptClassConstructorWrapperRef
JavaScriptClassConstructorWrapperCreate(JNIEnv *env, JSContextRef context, const char *name, const char *fqmn, jclass cls, jobject ctx)
{
	JSObjectRef function = DLValueCreateFunction(context, &JavaScriptClassConstructorWrapperCallback, name);

	JavaScriptClassConstructorWrapperRef wrapper = new JavaScriptClassConstructorWrapper();
	wrapper->env = env;
	wrapper->cls = (jclass) env->NewGlobalRef(cls);
	wrapper->ctx = env->NewGlobalRef(ctx);
	wrapper->function = function;
	wrapper->handler = env->GetMethodID(cls, fqmn, "(Lca/logaritm/dezel/core/JavaScriptFunctionCallback;)V");
	wrapper->init = env->GetMethodID(cls, "<init>", "(Lca/logaritm/dezel/core/JavaScriptContext;)V");

	DLValueSetFinalizeHandler(context, function, &JavaScriptClassConstructorWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
