#include "jni_init.h"
#include "jni_module_layout.h"
#include <DLLayout.h>
#include <DLLayoutNode.h>
#include "wrappers/LayoutNodeWrapper.h"
#include "ca_logaritm_dezel_layout_LayoutNodeExternal.h"

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    parse
 * Signature: (Ljava/lang/Object;)J
 */
jlong Java_ca_logaritm_dezel_layout_LayoutNodeExternal_create(JNIEnv *env, jclass, jobject object) {
	DLLayoutNodeRef handle = DLLayoutNodeCreate();
	DLLayoutNodeSetData(handle, LayoutNodeWrapperCreate(env, object, handle));
	return reinterpret_cast<jlong>(handle);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    delete
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_delete(JNIEnv *env, jclass, jlong layoutNodePtr) {

	DLLayoutNodeRef node = reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr);
	if (node == NULL) {
		return;
	}

	LayoutNodeWrapperDelete(env, reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node)));

	DLLayoutNodeDelete(node);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setId
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setId(JNIEnv *env, jclass, jlong layoutNodePtr, jstring idStr) {
	JNI_STRING_CREATE(idStr, id);
	DLLayoutNodeSetId(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), id);
	JNI_STRING_DELETE(idStr, id)
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setLayout
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setLayout(JNIEnv *env, jclass, jlong layoutNodePtr, jlong layoutPtr) {
	DLLayoutNodeSetLayout(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), reinterpret_cast<DLLayoutRef>(layoutPtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredTop
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredTop(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredLeft
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredLeft(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredRight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredRight(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredBottom
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredBottom(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredWidth
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredWidth(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredWidth(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredHeight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredHeight(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredHeight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredInnerWidth
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredInnerWidth(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredInnerWidth(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredInnerHeight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredInnerHeight(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredInnerHeight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredContentWidth
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredContentWidth(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredContentWidth(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredContentHeight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredContentHeight(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredContentHeight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredMarginTop
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredMarginTop(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredMarginTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredMarginLeft
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredMarginLeft(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredMarginLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredMarginRight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredMarginRight(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredMarginRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredMarginBottom
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredMarginBottom(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredMarginBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredBorderTop
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredBorderTop(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredBorderTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredBorderLeft
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredBorderLeft(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredBorderLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredBorderRight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredBorderRight(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredBorderRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredBorderBottom
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredBorderBottom(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredBorderBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredPaddingTop
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredPaddingTop(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredPaddingTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredPaddingLeft
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredPaddingLeft(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredPaddingLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredPaddingRight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredPaddingRight(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredPaddingRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    getMeasuredPaddingBottom
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getMeasuredPaddingBottom(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetMeasuredPaddingBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutExternal
 * Method:    getViewportWidth
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getViewportWidth(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetViewportWidth(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutExternal
 * Method:    getViewportHeight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_layout_LayoutNodeExternal_getViewportHeight(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return DLLayoutNodeGetViewportWidth(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    fillsParentWidth
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_layout_LayoutNodeExternal_fillsParentWidth(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return static_cast<jboolean>(DLLayoutNodeFillsParentWidth(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr)));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    fillsParentHeight
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_layout_LayoutNodeExternal_fillsParentHeight(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return static_cast<jboolean>(DLLayoutNodeFillsParentHeight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr)));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    wrapsContentWidth
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_layout_LayoutNodeExternal_wrapsContentWidth(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return static_cast<jboolean>(DLLayoutNodeWrapsContentWidth(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr)));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    wrapsContentHeight
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_layout_LayoutNodeExternal_wrapsContentHeight(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return static_cast<jboolean>(DLLayoutNodeWrapsContentHeight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr)));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    hasInvalidSize
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_layout_LayoutNodeExternal_hasInvalidSize(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return (jboolean) DLLayoutNodeHasInvalidSize(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    hasInvalidPosition
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_layout_LayoutNodeExternal_hasInvalidPosition(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return (jboolean) DLLayoutNodeHasInvalidPosition(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    hasInvalidLayout
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_layout_LayoutNodeExternal_hasInvalidLayout(JNIEnv *env, jclass, jlong layoutNodePtr) {
	return (jboolean) DLLayoutNodeHasInvalidLayout(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setAnchorTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setAnchorTop(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetAnchorTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutAnchorType>(type), static_cast<DLLayoutAnchorUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setAnchorLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setAnchorLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetAnchorLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutAnchorType>(type), static_cast<DLLayoutAnchorUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setTop(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutPositionType>(type), static_cast<DLLayoutPositionUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinTop(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxTop(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutPositionType>(type), static_cast<DLLayoutPositionUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setRight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setRight(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutPositionType>(type), static_cast<DLLayoutPositionUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinRight(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxRight(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setBottom
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setBottom(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutPositionType>(type), static_cast<DLLayoutPositionUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinBottom(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxBottom(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setWidth
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setWidth(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetWidth(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutSizeType>(type), static_cast<DLLayoutSizeUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinWidth
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinWidth(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinWidth(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxWidth
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxWidth(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxWidth(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setHeight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setHeight(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetHeight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutSizeType>(type), static_cast<DLLayoutSizeUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinHeight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinHeight(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinHeight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxHeight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxHeight(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxHeight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setContentOrientation
 * Signature: (JI)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setContentOrientation(JNIEnv *env, jclass, jlong layoutNodePtr, jint orientation) {
	DLLayoutNodeSetContentOrientation(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutContentOrientation>(orientation));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setContentLocation
 * Signature: (JI)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setContentLocation(JNIEnv *env, jclass, jlong layoutNodePtr, jint location) {
	DLLayoutNodeSetContentLocation(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutContentLocation>(location));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setContentArrangement
 * Signature: (JI)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setContentArrangement(JNIEnv *env, jclass, jlong layoutNodePtr, jint arrangement) {
	DLLayoutNodeSetContentArrangement(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutContentArrangement>(arrangement));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setContentTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setContentTop(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetContentTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutContentPositionType>(type), static_cast<DLLayoutContentPositionUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setContentLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setContentLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetContentLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutContentPositionType>(type), static_cast<DLLayoutContentPositionUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setContentWidth
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setContentWidth(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetContentWidth(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutContentSizeType>(type), static_cast<DLLayoutContentSizeUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setContentHeight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setContentHeight(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetContentHeight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutContentSizeType>(type), static_cast<DLLayoutContentSizeUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setBorderTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setBorderTop(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetBorderTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutBorderType>(type), static_cast<DLLayoutBorderUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setBorderLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setBorderLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetBorderLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutBorderType>(type), static_cast<DLLayoutBorderUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setBorderRight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setBorderRight(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetBorderRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutBorderType>(type), static_cast<DLLayoutBorderUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setBorderBottom
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setBorderBottom(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetBorderBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutBorderType>(type), static_cast<DLLayoutBorderUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMarginTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMarginTop(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetMarginTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutMarginType>(type), static_cast<DLLayoutMarginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMarginLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMarginLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetMarginLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutMarginType>(type), static_cast<DLLayoutMarginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMarginRight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMarginRight(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetMarginRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutMarginType>(type), static_cast<DLLayoutMarginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMarginBottom
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMarginBottom(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetMarginBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutMarginType>(type), static_cast<DLLayoutMarginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinMarginTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinMarginTop(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinMarginTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxMarginTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxMarginTop(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxMarginTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinMarginLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinMarginLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinMarginLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxMarginLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxMarginLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxMarginLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinMarginRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinMarginRight(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinMarginRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxMarginRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxMarginRight(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxMarginRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinMarginBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinMarginBottom(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinMarginBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxMarginBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxMarginBottom(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxMarginBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setPaddingTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setPaddingTop(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetPaddingTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutPaddingType>(type), static_cast<DLLayoutPaddingUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setPaddingLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setPaddingLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetPaddingLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutPaddingType>(type), static_cast<DLLayoutPaddingUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setPaddingRight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setPaddingRight(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetPaddingRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutPaddingType>(type), static_cast<DLLayoutPaddingUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setPaddingBottom
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setPaddingBottom(JNIEnv *env, jclass, jlong layoutNodePtr, jint type, jint unit, jdouble length) {
	DLLayoutNodeSetPaddingBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), static_cast<DLLayoutPaddingType>(type), static_cast<DLLayoutPaddingUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinPaddingTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinPaddingTop(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinPaddingTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxPaddingTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxPaddingTop(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxPaddingTop(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinPaddingLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinPaddingLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinPaddingLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxPaddingLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxPaddingLeft(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxPaddingLeft(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinPaddingRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinPaddingRight(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinPaddingRight(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxPaddingRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxPaddingRight(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxPaddingBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMinPaddingBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMinPaddingBottom(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble min) {
	DLLayoutNodeSetMinPaddingBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setMaxPaddingBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setMaxPaddingBottom(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble max) {
	DLLayoutNodeSetMaxPaddingBottom(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setExpand
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setExpand(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble expand) {
	DLLayoutNodeSetExpand(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), expand);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setShrink
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setShrink(JNIEnv *env, jclass, jlong layoutNodePtr, jdouble shrink) {
	DLLayoutNodeSetShrink(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), shrink);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    setVisible
 * Signature: (JZ)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_setVisible(JNIEnv *env, jclass, jlong layoutNodePtr, jboolean visible) {
	DLLayoutNodeSetVisible(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), visible);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    invalidate
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_invalidate(JNIEnv *env, jclass, jlong layoutNodePtr) {
	DLLayoutNodeInvalidateLayout(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    invalidateSize
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_invalidateSize(JNIEnv *env, jclass, jlong layoutNodePtr) {
	DLLayoutNodeInvalidateSize(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    invalidatePosition
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_invalidatePosition(JNIEnv *env, jclass, jlong layoutNodePtr) {
	DLLayoutNodeInvalidatePosition(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    resolve
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_resolve(JNIEnv *env, jclass, jlong layoutNodePtr) {
	DLLayoutNodeResolve(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    measure
 * Signature: (JDD)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_measure(JNIEnv *env, jclass, jlong layoutNodePtr) {
	DLLayoutNodeResolveSelf(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    appendChild
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_appendChild(JNIEnv *env, jclass, jlong layoutNodePtr, jlong nodePtr) {
	DLLayoutNodeAppendChild(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), reinterpret_cast<DLLayoutNodeRef>(nodePtr));
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    insertChild
 * Signature: (JJI)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_insertChild(JNIEnv *env, jclass, jlong layoutNodePtr, jlong nodePtr, jint index) {
	DLLayoutNodeInsertChild(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), reinterpret_cast<DLLayoutNodeRef>(nodePtr), index);
}

/*
 * Class:     ca_logaritm_dezel_layout_LayoutNodeExternal
 * Method:    removeChild
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_layout_LayoutNodeExternal_removeChild(JNIEnv *env, jclass, jlong layoutNodePtr, jlong nodePtr) {
	DLLayoutNodeRemoveChild(reinterpret_cast<DLLayoutNodeRef>(layoutNodePtr), reinterpret_cast<DLLayoutNodeRef>(nodePtr));
}
