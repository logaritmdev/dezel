#include "jni_init.h"
#include "jni_module_display.h"
#include "ca_logaritm_dezel_view_display_external_ValueListExternal.h"
#include "ValueListRef.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Class:     ca_logaritm_dezel_view_display_external_ValueListExternal
 * Method:    delete
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_view_display_external_ValueListExternal_delete(JNIEnv* env, jclass, jlong valueListPtr) {
	ValueListDelete(reinterpret_cast<ValueListRef>(valueListPtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_ValueListExternal
 * Method:    getCount
 * Signature: (J)I
 */
jint Java_ca_logaritm_dezel_view_display_external_ValueListExternal_getCount(JNIEnv* env, jclass, jlong valueListPtr) {
	return ValueListGetCount(reinterpret_cast<ValueListRef>(valueListPtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_ValueListExternal
 * Method:    getValue
 * Signature: (JI)J
 */
jlong Java_ca_logaritm_dezel_view_display_external_ValueListExternal_getValue(JNIEnv* env, jclass, jlong valueListPtr, jint index) {
	return reinterpret_cast<jlong>(
		ValueListGetValue(reinterpret_cast<ValueListRef>(valueListPtr), index)
	);
}

#ifdef __cplusplus
}
#endif