#include "jni_init.h"
#include "jni_module_core.h"
#include <JavaScriptContext.h>
#include <JavaScriptValue.h>
#include "JavaScriptGetter.h"
#include "JavaScriptClassGetterWrapper.h"

static jmethodID
JavaScriptClassFunctionWrapperGetCallback(JNIEnv* env, jclass cls, const char* fqmn)
{
	return JNIGetMethod(env, cls, fqmn, "(Lca/logaritm/dezel/core/JavaScriptGetterCallback;)V");
}

static JSValueRef
JavaScriptClassGetterWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	auto wrapper = reinterpret_cast<JavaScriptClassGetterWrapperRef>(JavaScriptValueGetAssociatedObject(context, callee));

	auto result = JavaScriptGetterExecute(
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
JavaScriptClassGetterWrapperFinalize(JSContextRef context, JavaScriptValueDataRef handle)
{
	auto wrapper = reinterpret_cast<JavaScriptClassGetterWrapperRef>(JavaScriptValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->cls);
	}
}

JavaScriptClassGetterWrapperRef
JavaScriptClassGetterWrapperCreate(JNIEnv* env, JSContextRef context, const char* name, const char* fqmn, jclass cls, jobject ctx)
{
	auto function = JavaScriptValueCreateFunction(context, &JavaScriptClassGetterWrapperCallback, name);

	auto wrapper = new JavaScriptClassGetterWrapper();
	wrapper->env = env;
	wrapper->cls = JNIGlobalRef(env, cls);
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = JavaScriptClassFunctionWrapperGetCallback(env, cls, fqmn);
	wrapper->function = function;

	JavaScriptValueSetFinalizeHandler(context, function, &JavaScriptClassGetterWrapperFinalize);
	JavaScriptValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
