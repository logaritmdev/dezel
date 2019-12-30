#include "jni_init.h"
#include "jni_module_display.h"
#include "ca_logaritm_dezel_view_display_external_FunctionValueExternal.h"
#include "FunctionValueRef.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Class:     ca_logaritm_dezel_view_display_external_FunctionValueExternal
 * Method:    getName
 * Signature: (J)Ljava/lang/String;
 */
jstring Java_ca_logaritm_dezel_view_display_external_FunctionValueExternal_getName(JNIEnv* env, jclass, jlong functionValuePtr) {
	return env->NewStringUTF(FunctionValueGetName(reinterpret_cast<FunctionValueRef>(functionValuePtr)));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_FunctionValueExternal
 * Method:    getArguments
 * Signature: (J)I
 */
jint Java_ca_logaritm_dezel_view_display_external_FunctionValueExternal_getArguments(JNIEnv* env, jclass, jlong functionValuePtr) {
	return FunctionValueGetArgumentCount(reinterpret_cast<FunctionValueRef>(functionValuePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_FunctionValueExternal
 * Method:    getArgument
 * Signature: (JI)J
 */
jlong Java_ca_logaritm_dezel_view_display_external_FunctionValueExternal_getArgument(JNIEnv* env, jclass, jlong functionValuePtr, jint index) {
	return reinterpret_cast<jlong>(
		FunctionValueGetArgumentValues(reinterpret_cast<FunctionValueRef>(functionValuePtr), index)
	);
}

#ifdef __cplusplus
}
#endif