#include <DLLayout.h>
#include "wrappers/LayoutWrapper.h"
#include "ca_logaritm_dezel_layout_LayoutExternal.h"
#include "jni_init.h"

/*
 * Class:     ca_logaritm_dezel_layout_LayoutExternal
 * Method:    parse
 * Signature: ()J
 */
jlong Java_ca_logaritm_dezel_layout_LayoutExternal_create(JNIEnv *env, jclass, jobject object) {
	DLLayoutRef handle = DLLayoutCreate();
	DLLayoutSetData(handle, LayoutWrapperCreate(env, object, handle));
	return reinterpret_cast<jlong>(handle);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutExternal
 * Method:    delete
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_layout_LayoutExternal_delete(JNIEnv *env, jclass, jlong layoutPtr) {

	DLLayoutRef layout = reinterpret_cast<DLLayoutRef>(layoutPtr);
	if (layout == NULL) {
		return;
	}

	LayoutWrapperDelete(env, reinterpret_cast<LayoutWrapperRef>(DLLayoutGetData(layout)));

	DLLayoutDelete(layout);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutExternal
 * Method:    isInvalid
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_layout_LayoutExternal_isInvalid(JNIEnv *env, jclass, jlong layoutPtr) {
	return static_cast<jboolean>(DLLayoutIsInvalid(reinterpret_cast<DLLayoutRef>(layoutPtr)));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutExternal
 * Method:    isResolving
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_layout_LayoutExternal_isResolving(JNIEnv *env, jclass, jlong layoutPtr) {
	return static_cast<jboolean>(DLLayoutIsResolving(reinterpret_cast<DLLayoutRef>(layoutPtr)));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutExternal
 * Method:    setRoot
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_layout_LayoutExternal_setRoot(JNIEnv *env, jclass, jlong layoutPtr, jlong windowPtr) {
	DLLayoutSetRoot(reinterpret_cast<DLLayoutRef>(layoutPtr), reinterpret_cast<DLLayoutNodeRef>(windowPtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutExternal
 * Method:    setViewportWidth
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutExternal_setViewportWidth(JNIEnv *, jclass, jlong layoutPtr, jdouble width) {
	DLLayoutSetViewportWidth(reinterpret_cast<DLLayoutRef>(layoutPtr), width);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutExternal
 * Method:    setViewportHeight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutExternal_setViewportHeight(JNIEnv *, jclass, jlong layoutPtr, jdouble height) {
	DLLayoutSetViewportHeight(reinterpret_cast<DLLayoutRef>(layoutPtr), height);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutExternal
 * Method:    setScale
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutExternal_setScale(JNIEnv *env, jclass, jlong layoutPtr, jdouble scale) {
	DLLayoutSetScale(reinterpret_cast<DLLayoutRef>(layoutPtr), scale);
}
