#include "jni_init.h"
#include "jni_module_core.h"
#include <JavaScriptContext.h>
#include <JavaScriptValue.h>
#include "JavaScriptGetter.h"
#include "JavaScriptClassStaticGetterWrapper.h"

static jmethodID
JavaScriptClassStaticFunctionWrapperGetCallback(JNIEnv* env, jclass cls, const char* fqmn)
{
	return JNIGetStaticMethod(env, cls, fqmn, "(Lca/logaritm/dezel/core/JavaScriptGetterCallback;)V");
}

static JSValueRef
JavaScriptClassStaticGetterWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	auto wrapper = reinterpret_cast<JavaScriptClassStaticGetterWrapperRef>(JavaScriptValueGetAssociatedObject(context, callee));

	auto result = JavaScriptGetterExecute(
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
JavaScriptClassStaticGetterWrapperFinalize(JSContextRef context, JavaScriptValueDataRef handle)
{
	auto wrapper = reinterpret_cast<JavaScriptClassStaticGetterWrapperRef>(JavaScriptValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->cls);
	}
}

JavaScriptClassStaticGetterWrapperRef
JavaScriptClassStaticGetterWrapperCreate(JNIEnv* env, JSContextRef context, const char* name, const char* fqmn, jclass cls, jobject ctx)
{
	auto function = JavaScriptValueCreateFunction(context, &JavaScriptClassStaticGetterWrapperCallback, name);

	auto wrapper = new JavaScriptClassStaticGetterWrapper();
	wrapper->env = env;
	wrapper->cls = JNIGlobalRef(env, cls);
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = JavaScriptClassStaticFunctionWrapperGetCallback(env, cls, fqmn);
	wrapper->function = function;

	JavaScriptValueSetFinalizeHandler(context, function, &JavaScriptClassStaticGetterWrapperFinalize);
	JavaScriptValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
