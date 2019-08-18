#include "jni_init.h"
#include "jni_module_core.h"
#include "jni_module_style.h"
#include "jni_module_layout.h"
#include <string>

jclass Throwable;
jclass StackTraceElement;
jmethodID ThrowableGetCause;
jmethodID ThrowableGetStackTrace;
jmethodID ThrowableToString;
jmethodID StackTraceElementToString;

static std::string error = "";

jobjectArray
JNIExceptionGetStackTrace(JNIEnv *env, jthrowable exception) {
	return (jobjectArray) env->CallObjectMethod(exception, ThrowableGetStackTrace);
}

jsize
JNIExceptionGetStackTraceLength(JNIEnv *env, jobjectArray frames) {
	return frames ? env->GetArrayLength(frames) : 0;
}

jstring
JNIExceptionGetMessage(JNIEnv *env, jthrowable exception) {
	return (jstring) env->CallObjectMethod(exception, ThrowableToString);
}

jthrowable
JNIExceptionGetCause(JNIEnv *env, jthrowable exception) {
	return (jthrowable) env->CallObjectMethod(exception, ThrowableGetCause);
}

jstring
JNIStackTraceElementGetString(JNIEnv *env, jobject frame) {
	return (jstring) env->CallObjectMethod(frame,  StackTraceElementToString);
}

void
JNIAppendException(JNIEnv *env, jthrowable exception) {

	auto frames = JNIExceptionGetStackTrace(env, exception);
	auto length = JNIExceptionGetStackTraceLength(env, frames);

	if (frames != 0) {

		auto string = JNIExceptionGetMessage(env, exception);

		JNI_STRING_CREATE(string, message);

		if (error.empty() == false) {
			error += "\n";
			error += "Caused by: ";
			error += message;
		} else {
			error = message;
		}

		JNI_STRING_DELETE(string, message);

		env->DeleteLocalRef(string);
	}

	if (length > 0) {

		jsize i = 0;

		for (i = 0; i < length; i++) {

			auto frame = env->GetObjectArrayElement(frames, i);

			auto string = JNIStackTraceElementGetString(env, frame);

			JNI_STRING_CREATE(string, message)
			error += "\n";
			error += "    ";
			error += message;
			JNI_STRING_DELETE(string, message)

			env->DeleteLocalRef(string);
			env->DeleteLocalRef(frame);
		}
	}

	if (frames != 0) {

		auto cause = JNIExceptionGetCause(env, exception);

		if (cause != 0) {
			JNIAppendException(env, cause);
		}
	}
}

void
JNIHandleException(JNIEnv *env) {

	if (env->ExceptionCheck() == false) {
		return;
	}

	JNIAppendException(
		env,
		env->ExceptionOccurred()
	);

	env->ExceptionDescribe();
}

jclass
JNIGetClass(JNIEnv *env, const char *name)
{
	auto res = env->FindClass(name);

	if (res == NULL) {
		LOGE("Unable to find class %s", name);
	}

	return res;
}

jfieldID
JNIGetField(JNIEnv *env, jclass cls, const char *name, const char *sign)
{
	auto res = env->GetFieldID(
		cls,
		name,
		sign
	);

	if (res == NULL) {
		LOGE("Unable to find static field %s with signature %s", name, sign);
	}

	return res;
}

jmethodID
JNIGetMethod(JNIEnv *env, jclass cls, const char *name, const char *sign)
{
	auto res = env->GetMethodID(
		cls,
		name,
		sign
	);

	if (res == NULL) {
		LOGE("Unable to find method %s with signature %s", name, sign);
	}

	return res;
}

jmethodID
JNIGetStaticMethod(JNIEnv *env, jclass cls, const char *name, const char *sign)
{
	auto res = env->GetStaticMethodID(
		cls,
		name,
		sign
	);

	if (res == NULL) {
		LOGE("Unable to find static method %s with signature %s", name, sign);
	}

	return res;
}

jobject
JNIGlobalRef(JNIEnv *env, jobject value)
{
	return env->NewGlobalRef(value);
}

/**
* @function JNIGlobalRef
* @since 0.7.0
* @hidden
*/
jclass
JNIGlobalRef(JNIEnv *env, jclass value)
{
	return reinterpret_cast<jclass>(env->NewGlobalRef(value));
}

jint
JNI_OnLoad(JavaVM* vm, void* reserved)
{
	JNIEnv* env;

	if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK) {
		return -1;
	}

	Throwable                  = JNIGetClass(env, "java/lang/Throwable");
	StackTraceElement          = JNIGetClass(env, "java/lang/StackTraceElement");
	ThrowableGetCause         = JNIGetMethod(env, Throwable, "getCause", "()Ljava/lang/Throwable;");
	ThrowableGetStackTrace    = JNIGetMethod(env, Throwable, "getStackTrace", "()[Ljava/lang/StackTraceElement;");
	ThrowableToString         = JNIGetMethod(env, Throwable, "toString", "()Ljava/lang/String;");
	StackTraceElementToString = JNIGetMethod(env, StackTraceElement, "toString", "()Ljava/lang/String;");
	Throwable                  = (jclass) env->NewGlobalRef(Throwable);
	StackTraceElement          = (jclass) env->NewGlobalRef(StackTraceElement);

	JNI_OnLoad_core(env);
	JNI_OnLoad_style(env);
	JNI_OnLoad_layout(env);

	return JNI_VERSION_1_6;
}