#include "jni_init.h"
#include "jni_module_core.h"
#include <JavaScriptContext.h>
#include <JavaScriptValue.h>
#include "JavaScriptFunction.h"
#include "JavaScriptClassFunctionWrapper.h"

static jmethodID
JavaScriptClassFunctionWrapperGetCallback(JNIEnv* env, jclass cls, const char* fqmn)
{
	return JNIGetMethod(env, cls, fqmn, "(Lca/logaritm/dezel/core/JavaScriptFunctionCallback;)V");
}

static JSValueRef
JavaScriptClassFunctionWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	auto wrapper = reinterpret_cast<JavaScriptClassFunctionWrapperRef>(JavaScriptValueGetAssociatedObject(context, callee));

	auto result = JavaScriptFunctionExecute(
		wrapper->env,
		wrapper->ctx,
		wrapper->cls,
		reinterpret_cast<jobject>(JavaScriptValueGetAssociatedObject(context, object)),
		wrapper->callback,
		object,
		callee,
		argc,
		argv
	);

	return result ? reinterpret_cast<JSValueRef>(result) : nullptr;
}

static void
JavaScriptClassFunctionWrapperFinalize(JSContextRef context, JavaScriptValueDataRef handle)
{
	auto wrapper = reinterpret_cast<JavaScriptClassFunctionWrapperRef>(JavaScriptValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->cls);
	}
}

JavaScriptClassFunctionWrapperRef
JavaScriptClassFunctionWrapperCreate(JNIEnv* env, JSContextRef context, const char* name, const char* fqmn, jclass cls, jobject ctx)
{
	auto function = JavaScriptValueCreateFunction(context, &JavaScriptClassFunctionWrapperCallback, name);

	auto wrapper = new JavaScriptClassFunctionWrapper();
	wrapper->env = env;
	wrapper->cls = JNIGlobalRef(env, cls);
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = JavaScriptClassFunctionWrapperGetCallback(env, cls, fqmn);
	wrapper->function = function;

	JavaScriptValueSetFinalizeHandler(context, function, &JavaScriptClassFunctionWrapperFinalize);
	JavaScriptValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
