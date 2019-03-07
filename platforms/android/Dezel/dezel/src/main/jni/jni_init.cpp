#include "jni_init.h"
#include "jni_module_core.h"
#include "jni_module_style.h"
#include "jni_module_layout.h"

jclass
JNIGetClass(JNIEnv *env, const char *name)
{
	jclass cls = env->FindClass(name);
	if (cls == NULL) LOGE("Unable to find class %s", name);
	return cls;
}

jfieldID
JNIGetField(JNIEnv *env, jclass cls, const char *name, const char *sign)
{
	jfieldID res = env->GetFieldID(cls, name, sign);
	if (res == NULL) LOGE("Unable to find static field %s with signature %s", name, sign);
	return res;
}

jmethodID
JNIGetMethod(JNIEnv *env, jclass cls, const char *name, const char *sign)
{
	jmethodID res = env->GetMethodID(cls, name, sign);
	if (res == NULL) LOGE("Unable to find method %s with signature %s", name, sign);
	return res;
}

jint
JNI_OnLoad(JavaVM* vm, void* reserved)
{
	JNIEnv* env;

	if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK) {
		return -1;
	}

	JNI_OnLoad_core(env);
	JNI_OnLoad_style(env);
	JNI_OnLoad_layout(env);

	return JNI_VERSION_1_6;
}