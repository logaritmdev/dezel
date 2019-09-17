#include "jni_init.h"
#include "jni_module_core.h"
#include <DLContext.h>
#include <DLValue.h>
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
	auto wrapper = reinterpret_cast<JavaScriptClassGetterWrapperRef>(DLValueGetAssociatedObject(context, callee));

	auto result = JavaScriptGetterExecute(
		wrapper->env,
		wrapper->ctx,
		wrapper->cls,
		reinterpret_cast<jobject>(DLValueGetAssociatedObject(context, object)),
		wrapper->callback,
		object,
		callee,
		argc,
		argv
	);

	return result ? reinterpret_cast<JSValueRef>(result) : NULL;
}

static void
JavaScriptClassGetterWrapperFinalize(JSContextRef context, DLValueDataRef handle)
{
	auto wrapper = reinterpret_cast<JavaScriptClassGetterWrapperRef>(DLValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->cls);
	}
}

JavaScriptClassGetterWrapperRef
JavaScriptClassGetterWrapperCreate(JNIEnv* env, JSContextRef context, const char* name, const char* fqmn, jclass cls, jobject ctx)
{
	auto function = DLValueCreateFunction(context, &JavaScriptClassGetterWrapperCallback, name);

	auto wrapper = new JavaScriptClassGetterWrapper();
	wrapper->env = env;
	wrapper->cls = JNIGlobalRef(env, cls);
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->callback = JavaScriptClassFunctionWrapperGetCallback(env, cls, fqmn);
	wrapper->function = function;

	DLValueSetFinalizeHandler(context, function, &JavaScriptClassGetterWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}
