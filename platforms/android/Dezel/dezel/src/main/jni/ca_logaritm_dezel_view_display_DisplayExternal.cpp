#include "ca_logaritm_dezel_view_display_DisplayExternal.h"
#include "DisplayRef.h"
#include "DisplayNodeRef.h"
#include "wrappers/DisplayWrapper.h"
#include "jni_init.h"
#include "jni_module_view.h"

/*
 * Class:     ca_logaritm_dezel_view_display_DisplayExternal
 * Method:    create
 * Signature: (Ljava/lang/Object;)J
 */
jlong Java_ca_logaritm_dezel_view_display_DisplayExternal_create(JNIEnv* env, jclass, jobject object) {
	const auto handle = DisplayCreate();
	DisplaySetData(handle, DisplayWrapperCreate(env, object, handle));
	return reinterpret_cast<jlong>(handle);
}

/*
 * Class:     ca_logaritm_dezel_view_display_DisplayExternal
 * Method:    delete
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_view_display_DisplayExternal_delete(JNIEnv* env, jclass, jlong displayPtr) {
	
	const auto display = reinterpret_cast<DisplayRef>(displayPtr);

	if (display == NULL) {
		return;
	}

	DisplayWrapperDelete(env, reinterpret_cast<DisplayWrapperRef>(DisplayGetData(display)));
	DisplayDelete(display);
}

/*
 * Class:     ca_logaritm_dezel_view_display_DisplayExternal
 * Method:    isInvalid
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_view_display_DisplayExternal_isInvalid(JNIEnv* env, jclass, jlong displayPtr) {
	return DisplayIsInvalid(reinterpret_cast<DisplayRef>(displayPtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_DisplayExternal
 * Method:    isResolving
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_view_display_DisplayExternal_isResolving(JNIEnv* env, jclass, jlong displayPtr) {
	return DisplayIsResolving(reinterpret_cast<DisplayRef>(displayPtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_DisplayExternal
 * Method:    setViewportWidth
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_DisplayExternal_setViewportWidth(JNIEnv* env, jclass, jlong displayPtr, jdouble value) {
	DisplaySetViewportWidth(reinterpret_cast<DisplayRef>(displayPtr), value);
}

/*
 * Class:     ca_logaritm_dezel_view_display_DisplayExternal
 * Method:    setViewportHeight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_DisplayExternal_setViewportHeight(JNIEnv* env, jclass, jlong displayPtr, jdouble value) {
	DisplaySetViewportHeight(reinterpret_cast<DisplayRef>(displayPtr), value);
}

/*
 * Class:     ca_logaritm_dezel_view_display_DisplayExternal
 * Method:    setScale
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_DisplayExternal_setScale(JNIEnv* env, jclass, jlong displayPtr, jdouble value) {
	DisplaySetScale(reinterpret_cast<DisplayRef>(displayPtr), value);
}

/*
 * Class:     ca_logaritm_dezel_view_display_DisplayExternal
 * Method:    setWindow
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_view_display_DisplayExternal_setWindow(JNIEnv* env, jclass, jlong displayPtr, jlong windowPtr) {
	DisplaySetWindow(reinterpret_cast<DisplayRef>(displayPtr), reinterpret_cast<DisplayNodeRef>(windowPtr));
}