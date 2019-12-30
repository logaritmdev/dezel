#include "jni_init.h"
#include "jni_module_core.h"
#include <JavaScriptContext.h>
#include <JavaScriptValue.h>
#include "JavaScriptSetter.h"
#include "JavaScriptClassSetterWrapper.h"

static jmethodID
JavaScriptClassSetterWrapperGetCallback(JNIEnv* env, jclass cls, const char* fqmn)
{
	return JNIGetMethod(env, cls, fqmn, "(Lca/logaritm/dezel/core/JavaScriptSetterCallback;)V");
}

static JSValueRef
JavaScriptClassSetterWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	auto wrapper = reinterpret_cast<JavaScriptClassSetterWrapperRef>(JavaScriptValueGetAssociatedObject(context, callee));

	auto result = JavaScriptSetterExecute(
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
JavaScriptClassSetterWrapperFinalize(JSContextRef context, JavaScriptValueDataRef handle)
{
	auto wrapper = reinterpret_cast<JavaScriptClassSetterWrapperRef>(JavaScriptValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->cls);
	}
}

JavaScriptClassSetterWrapperRef
JavaScriptClassSetterWrapperCreate(JNIEnv* env, JSContextRef context, const char* name, const char* fqmn, jclass cls, jobject ctx)
{
	auto function = JavaScriptValueCreateFunction(context, &JavaScriptClassSetterWrapperCallback, name);

	auto wrapper = new JavaScriptClassSetterWrapper();
	wrapper->env = env;
	wrapper->cls = JNIGlobalRef(env, cls);
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = JavaScriptClassSetterWrapperGetCallback(env, cls, fqmn);
	wrapper->function = function;

	JavaScriptValueSetFinalizeHandler(context, function, &JavaScriptClassSetterWrapperFinalize);
	JavaScriptValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
