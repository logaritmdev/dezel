#include "jni_init.h"
#include "jni_module_core.h"
#include "JavaScriptSetter.h"

jlong
JavaScriptSetterExecute(JNIEnv *env, jobject context, jobject instance, jmethodID function, JSObjectRef object, JSValueRef callee, size_t argc, JSValueRef const *argv)
{
	JNI_ARGS_CREATE(args);

	jobject callback = env->NewObject(
		JavaScriptSetterCallbackClass,
		JavaScriptSetterCallbackConstructor,
		context,
		reinterpret_cast<jlong>(object),
		reinterpret_cast<jlong>(callee),
		argc,
		args
	);

	JNI_CALL_VOID_METHOD(
		env,
		instance,
		function,
		callback
	);

	jlong result = env->GetLongField(callback, JavaScriptSetterCallbackResult);
	env->DeleteLocalRef(callback);
	JNI_ARGS_DELETE(args);

	return result;
}
