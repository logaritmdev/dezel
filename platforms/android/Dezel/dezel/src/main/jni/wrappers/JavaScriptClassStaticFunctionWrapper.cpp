#include "jni_init.h"
#include "jni_module_core.h"
#include <DLContext.h>
#include <DLValue.h>
#include "JavaScriptFunction.h"
#include "JavaScriptClassStaticFunctionWrapper.h"

static jmethodID
JavaScriptClassStaticFunctionWrapperGetCallback(JNIEnv *env, jclass cls, const char *fqmn)
{
	return JNIGetStaticMethod(env, cls, fqmn, "(Lca/logaritm/dezel/core/JavaScriptFunctionCallback;)V");
}

static JSValueRef
JavaScriptClassStaticFunctionWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	auto wrapper = reinterpret_cast<JavaScriptClassStaticFunctionWrapperRef>(DLValueGetAssociatedObject(context, callee));

	auto result = JavaScriptFunctionExecute(
		wrapper->env,
		wrapper->ctx,
		wrapper->cls,
		NULL,
		wrapper->callback,
		object,
		callee,
		argc,
		argv
	);

	return result ? reinterpret_cast<JSValueRef>(result) : NULL;
}

static void
JavaScriptClassStaticFunctionWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	auto wrapper = reinterpret_cast<JavaScriptClassStaticFunctionWrapperRef>(DLValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->cls);
	}
}

JavaScriptClassStaticFunctionWrapperRef
JavaScriptClassStaticFunctionWrapperCreate(JNIEnv *env, JSContextRef context, const char *name, const char *fqmn, jclass cls, jobject ctx)
{
	auto function = DLValueCreateFunction(context, &JavaScriptClassStaticFunctionWrapperCallback, name);

	auto wrapper = new JavaScriptClassStaticFunctionWrapper();
	wrapper->env = env;
	wrapper->cls = JNIGlobalRef(env, cls);
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = JavaScriptClassStaticFunctionWrapperGetCallback(env, cls, fqmn);
	wrapper->function = function;

	DLValueSetFinalizeHandler(context, function, &JavaScriptClassStaticFunctionWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
