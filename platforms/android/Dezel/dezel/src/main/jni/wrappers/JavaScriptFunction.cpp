#include "jni_init.h"
#include "jni_module_core.h"
#include "JavaScriptFunction.h"

jlong
JavaScriptFunctionExecute(JNIEnv* env, jobject context, jclass cls, jobject instance, jmethodID function, JSObjectRef object, JSValueRef callee, size_t argc, JSValueRef const *argv)
{
	JNI_ARGS_CREATE(args);

	jobject callback = env->NewObject(
		JavaScriptFunctionCallbackClass,
		JavaScriptFunctionCallbackConstructor,
		context,
		reinterpret_cast<jlong>(object),
		reinterpret_cast<jlong>(callee),
		argc,
		args
	);

	if (instance) {

		JNI_CALL_VOID_METHOD(
			env,
			instance,
			function,
			callback
		);

	} else {

		JNI_CALL_STATIC_VOID_METHOD(
			env,
			cls,
			function,
			callback
		);

	}

	JNI_ARGS_DELETE(args);

	return env->GetLongField(callback, JavaScriptFunctionCallbackResult);
}

