#include "jni_init.h"
#include "jni_module_display.h"
#include "ca_logaritm_dezel_view_display_external_ValueExternal.h"
#include "ValueRef.h"

static void javaScriptPropertyParse(ValueListRef values, void* self, void* lock) {

}

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Class:     ca_logaritm_dezel_view_display_external_ValueExternal
 * Method:    getType
 * Signature: (J)I
 */
jint Java_ca_logaritm_dezel_view_display_external_ValueExternal_getType(JNIEnv* env, jclass, jlong valuePtr) {
	return static_cast<jint>(ValueGetType(reinterpret_cast<ValueRef>(valuePtr)));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_ValueExternal
 * Method:    getUnit
 * Signature: (J)I
 */
jint Java_ca_logaritm_dezel_view_display_external_ValueExternal_getUnit(JNIEnv* env, jclass, jlong valuePtr) {
	return static_cast<jint>(ValueGetUnit(reinterpret_cast<ValueRef>(valuePtr)));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_ValueExternal
 * Method:    getString
 * Signature: (J)Ljava/lang/String;
 */
jstring Java_ca_logaritm_dezel_view_display_external_ValueExternal_getString(JNIEnv* env, jclass, jlong valuePtr) {
	return env->NewStringUTF(ValueGetString(reinterpret_cast<ValueRef>(valuePtr)));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_ValueExternal
 * Method:    getNumber
 * Signature: (J)Ljava/lang/Double;
 */
jdouble Java_ca_logaritm_dezel_view_display_external_ValueExternal_getNumber(JNIEnv* env, jclass, jlong valuePtr) {
	return ValueGetNumber(reinterpret_cast<ValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_ValueExternal
 * Method:    getBoolean
 * Signature: (J)Ljava/lang/Boolean;
 */
jboolean Java_ca_logaritm_dezel_view_display_external_ValueExternal_getBoolean(JNIEnv* env, jclass, jlong valuePtr) {
	return ValueGetBoolean(reinterpret_cast<ValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_ValueExternal
 * Method:    parse
 * Signature: (Ljava/lang/String;)J
 */
jlong Java_ca_logaritm_dezel_view_display_external_ValueExternal_parse(JNIEnv* env, jclass, jstring sourceStr) {
	JNI_STRING_CREATE(sourceStr, source);
	auto values = ValueParse(source);
	JNI_STRING_DELETE(sourceStr, source);
	return reinterpret_cast<jlong>(values);
}

#ifdef __cplusplus
}
#endif