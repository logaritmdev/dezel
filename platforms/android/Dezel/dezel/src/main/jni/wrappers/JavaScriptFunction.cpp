#include "jni_init.h"
#include "jni_module_core.h"
#include "JavaScriptFunction.h"

jlong
JavaScriptFunctionExecute(JNIEnv *env, jobject context, jobject instance, jmethodID function, JSObjectRef object, JSValueRef callee, size_t argc, JSValueRef const *argv)
{
	JNI_ARGS_CREATE(args);

	jobject callback = env->NewObject(
		JavaScriptFunctionCallbackClass,
		JavaScriptFunctionCallbackConstructor,
		context,
		(jlong) object,
		(jlong) callee,
		argc,
		args
	);

	JNI_CHECK_EXCEPTION(env);

	JNI_CALL_VOID_METHOD(
		env,
		instance,
		function,
		callback
	);

	jlong result = env->GetLongField(callback, JavaScriptFunctionCallbackResult);
	env->DeleteLocalRef(callback);
	JNI_ARGS_DELETE(args);

	return result;
}

