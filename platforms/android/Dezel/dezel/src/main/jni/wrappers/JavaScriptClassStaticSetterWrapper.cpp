#include "jni_init.h"
#include "jni_module_core.h"
#include <JavaScriptContext.h>
#include <JavaScriptValue.h>
#include "JavaScriptSetter.h"
#include "JavaScriptClassStaticSetterWrapper.h"

static jmethodID
JavaScriptClassStaticSetterWrapperGetCallback(JNIEnv* env, jclass cls, const char* fqmn)
{
	return JNIGetMethod(env, cls, fqmn, "(Lca/logaritm/dezel/core/JavaScriptSetterCallback;)V");
}

static JSValueRef
JavaScriptClassStaticSetterWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	auto wrapper = reinterpret_cast<JavaScriptClassStaticSetterWrapperRef>(JavaScriptValueGetAssociatedObject(context, callee));

	auto result = JavaScriptSetterExecute(
		wrapper->env,
		wrapper->ctx,
		wrapper->cls,
		nullptr,
		wrapper->callback,
		object,
		callee,
		argc,
		argv
	);

	return result ? reinterpret_cast<JSValueRef>(result) : nullptr;
}

static void
JavaScriptClassStaticSetterWrapperFinalize(JSContextRef context, JavaScriptValueDataRef handle)
{
	auto wrapper = reinterpret_cast<JavaScriptClassStaticSetterWrapperRef>(JavaScriptValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->cls);
	}
}

JavaScriptClassStaticSetterWrapperRef
JavaScriptClassStaticSetterWrapperCreate(JNIEnv* env, JSContextRef context, const char* name, const char* fqmn, jclass cls, jobject ctx)
{
	auto function = JavaScriptValueCreateFunction(context, &JavaScriptClassStaticSetterWrapperCallback, name);

	auto wrapper = new JavaScriptClassStaticSetterWrapper();
	wrapper->env = env;
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->cls = JNIGlobalRef(env, cls);
	wrapper->callback = JavaScriptClassStaticSetterWrapperGetCallback(env, cls, fqmn);
	wrapper->function = function;

	JavaScriptValueSetFinalizeHandler(context, function, &JavaScriptClassStaticSetterWrapperFinalize);
	JavaScriptValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
