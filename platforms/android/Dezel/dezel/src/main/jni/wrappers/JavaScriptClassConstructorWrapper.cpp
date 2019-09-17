#include "jni_init.h"
#include "jni_module_core.h"
#include <DLContext.h>
#include <DLValue.h>
#include "JavaScriptFunction.h"
#include "JavaScriptFunctionWrapper.h"
#include "JavaScriptClassConstructorWrapper.h"

static jmethodID
JavaScriptClassConstructorWrapperGetCallback(JNIEnv* env, jclass cls, const char* fqmn)
{
	return JNIGetMethod(env, cls, fqmn, "(Lca/logaritm/dezel/core/JavaScriptFunctionCallback;)V");
}

static jmethodID
JavaScriptClassConstructorWrapperGetConstructor(JNIEnv* env, jclass cls)
{
	return JNIGetMethod(env, cls, "<init>", "(Lca/logaritm/dezel/core/JavaScriptContext;)V");
}

static JSValueRef
JavaScriptClassConstructorWrapperCallback(JSContextRef context, JSObjectRef object, JSObjectRef callee, size_t argc, JSValueRef const *argv)
{
	auto wrapper = reinterpret_cast<JavaScriptClassConstructorWrapperRef>(DLValueGetAssociatedObject(context, callee));

	auto instance = wrapper->env->NewObject(
		wrapper->cls,
		wrapper->constructor,
		wrapper->ctx
	);

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		instance,
		JavaScriptValueReset,
		reinterpret_cast<jlong>(object),
		false
	);

	DLValueSetAssociatedObject(context, object, wrapper->env->NewGlobalRef(instance));

	JavaScriptFunctionExecute(
		wrapper->env,
		wrapper->ctx,
		wrapper->cls,
		instance,
		wrapper->callback,
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
	auto wrapper = reinterpret_cast<JavaScriptClassConstructorWrapperRef>(DLValueDataGetAssociatedObject(handle));

	if (wrapper) {
		wrapper->env->DeleteGlobalRef(wrapper->ctx);
		wrapper->env->DeleteGlobalRef(wrapper->cls);
	}
}

JavaScriptClassConstructorWrapperRef
JavaScriptClassConstructorWrapperCreate(JNIEnv* env, JSContextRef context, const char* name, const char* fqmn, jclass cls, jobject ctx)
{
	JSObjectRef function = DLValueCreateFunction(context, &JavaScriptClassConstructorWrapperCallback, name);

	auto wrapper = new JavaScriptClassConstructorWrapper();
	wrapper->env = env;
	wrapper->cls = JNIGlobalRef(env, cls);
	wrapper->ctx = JNIGlobalRef(env, ctx);
	wrapper->function = function;
	wrapper->callback = JavaScriptClassConstructorWrapperGetCallback(env, cls, fqmn);
	wrapper->constructor = JavaScriptClassConstructorWrapperGetConstructor(env, cls);

	DLValueSetFinalizeHandler(context, function, &JavaScriptClassConstructorWrapperFinalize);
	DLValueSetAssociatedObject(context, function, wrapper);

	return wrapper;
}