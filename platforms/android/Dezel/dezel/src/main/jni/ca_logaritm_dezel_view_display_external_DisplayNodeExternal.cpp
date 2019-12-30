#include "jni_init.h"
#include "jni_module_display.h"
#include "ca_logaritm_dezel_view_display_external_DisplayNodeExternal.h"
#include "DisplayNode.h"
#include "DisplayNodeRef.h"
#include "wrappers/DisplayNodeWrapper.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    create
 * Signature: (Ljava/lang/Object;)J
 */
jlong Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_create(JNIEnv* env, jclass, jobject object) {
	const auto handle = DisplayNodeCreate();
	DisplayNodeSetData(handle, DisplayNodeWrapperCreate(env, object, handle));
	return reinterpret_cast<jlong>(handle);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    delete
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_delete(JNIEnv* env, jclass, jlong displayNodePtr) {

	const auto node = reinterpret_cast<DisplayNodeRef>(displayNodePtr);

	if (node == nullptr) {
		return;
	}

	DisplayNodeWrapperDelete(env, reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node)));
	DisplayNodeDelete(node);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setDisplay
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setDisplay(JNIEnv* env, jclass, jlong displayNodePtr, jlong displayPtr) {
	DisplayNodeSetDisplay(reinterpret_cast<DisplayNodeRef>(displayNodePtr), reinterpret_cast<DisplayRef>(displayPtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setOpaque
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setOpaque(JNIEnv* env, jclass, jlong displayNodePtr) {
	DisplayNodeSetOpaque(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
  * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
  * Method:    setName
  * Signature: (JLjava/lang/String;)V
  */
 void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setName(JNIEnv* env, jclass, jlong displayNodePtr, jstring nameStr) {
 	JNI_STRING_CREATE(nameStr, name);
 	DisplayNodeSetName(reinterpret_cast<DisplayNodeRef>(displayNodePtr), name);
 	JNI_STRING_DELETE(nameStr, name);
 }

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setName
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setType(JNIEnv* env, jclass, jlong displayNodePtr, jstring typeStr) {
	JNI_STRING_CREATE(typeStr, type);
	DisplayNodeSetType(reinterpret_cast<DisplayNodeRef>(displayNodePtr), type);
	JNI_STRING_DELETE(typeStr, type);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredTop
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredTop(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredLeft
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredLeft(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredRight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredRight(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredBottom
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredBottom(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredWidth
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredWidth(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredWidth(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredHeight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredHeight(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredHeight(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredInnerWidth
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredInnerWidth(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredInnerWidth(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredInnerHeight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredInnerHeight(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredInnerHeight(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredContentWidth
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredContentWidth(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredContentWidth(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredContentHeight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredContentHeight(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredContentHeight(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredMarginTop
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredMarginTop(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredMarginTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredMarginLeft
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredMarginLeft(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredMarginLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredMarginRight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredMarginRight(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredMarginRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredMarginBottom
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredMarginBottom(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredMarginBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredBorderTop
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredBorderTop(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredBorderTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredBorderLeft
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredBorderLeft(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredBorderLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredBorderRight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredBorderRight(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredBorderRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredBorderBottom
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredBorderBottom(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredBorderBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredPaddingTop
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredPaddingTop(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredPaddingTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredPaddingLeft
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredPaddingLeft(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredPaddingLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredPaddingRight
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredPaddingRight(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredPaddingRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    getMeasuredPaddingBottom
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_getMeasuredPaddingBottom(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeGetMeasuredPaddingBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    appendStyle
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_appendStyle(JNIEnv* env, jclass, jlong displayNodePtr, jstring styleStr) {
	JNI_STRING_CREATE(styleStr, style);
	DisplayNodeAppendStyle(reinterpret_cast<DisplayNodeRef>(displayNodePtr), style);
	JNI_STRING_DELETE(styleStr, style);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    removeStyle
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_removeStyle(JNIEnv* env, jclass, jlong displayNodePtr, jstring styleStr) {
	JNI_STRING_CREATE(styleStr, style);
	DisplayNodeRemoveStyle(reinterpret_cast<DisplayNodeRef>(displayNodePtr), style);
	JNI_STRING_DELETE(styleStr, style);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    hasStyle
 * Signature: (JLjava/lang/String;)Z
 */
jboolean Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_hasStyle(JNIEnv* env, jclass, jlong displayNodePtr, jstring styleStr) {
	JNI_STRING_CREATE(styleStr, style);
	bool has = DisplayNodeHasStyle(reinterpret_cast<DisplayNodeRef>(displayNodePtr), style);
	JNI_STRING_DELETE(styleStr, style);
	return has;
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    appendState
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_appendState(JNIEnv* env, jclass, jlong displayNodePtr, jstring stateStr) {
	JNI_STRING_CREATE(stateStr, state);
	DisplayNodeAppendState(reinterpret_cast<DisplayNodeRef>(displayNodePtr), state);
	JNI_STRING_DELETE(stateStr, state);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    removeState
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_removeState(JNIEnv* env, jclass, jlong displayNodePtr, jstring stateStr) {
	JNI_STRING_CREATE(stateStr, state);
	DisplayNodeRemoveState(reinterpret_cast<DisplayNodeRef>(displayNodePtr), state);
	JNI_STRING_DELETE(stateStr, state);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    hasState
 * Signature: (JLjava/lang/String;)Z
 */
jboolean Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_hasState(JNIEnv* env, jclass, jlong displayNodePtr, jstring stateStr) {
	JNI_STRING_CREATE(stateStr, state);
	bool has = DisplayNodeHasState(reinterpret_cast<DisplayNodeRef>(displayNodePtr), state);
	JNI_STRING_DELETE(stateStr, state);
	return has;
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setAnchorTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setAnchorTop(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetAnchorTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<AnchorType>(type), static_cast<AnchorUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setAnchorLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setAnchorLeft(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetAnchorLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<AnchorType>(type), static_cast<AnchorUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setTop(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<OriginType>(type), static_cast<OriginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinTop(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxTop(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setLeft(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<OriginType>(type), static_cast<OriginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinLeft(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxLeft(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setRight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setRight(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<OriginType>(type), static_cast<OriginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinRight(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxRight(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setBottom
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setBottom(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<OriginType>(type), static_cast<OriginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinBottom(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxBottom(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setWidth
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setWidth(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetWidth(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<SizeType>(type), static_cast<SizeUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinWidth
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinWidth(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinWidth(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxWidth
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxWidth(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxWidth(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setHeight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setHeight(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetHeight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<SizeType>(type), static_cast<SizeUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinHeight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinHeight(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinHeight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxHeight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxHeight(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxHeight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setContentDirection
 * Signature: (JI)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setContentDirection(JNIEnv* env, jclass, jlong displayNodePtr, jint contentDirection) {
	DisplayNodeSetContentDirection(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<ContentDirection>(contentDirection));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setContentAlignment
 * Signature: (JI)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setContentAlignment(JNIEnv* env, jclass, jlong displayNodePtr, jint contentAlignment) {
	DisplayNodeSetContentAlignment(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<ContentAlignment>(contentAlignment));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setContentDisposition
 * Signature: (JI)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setContentDisposition(JNIEnv* env, jclass, jlong displayNodePtr, jint contentDisposition) {
	DisplayNodeSetContentDisposition(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<ContentDisposition>(contentDisposition));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setContentTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setContentTop(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetContentTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<ContentOriginType>(type), static_cast<ContentOriginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setContentLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setContentLeft(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetContentLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<ContentOriginType>(type), static_cast<ContentOriginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setContentWidth
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setContentWidth(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetContentWidth(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<ContentSizeType>(type), static_cast<ContentSizeUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setContentHeight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setContentHeight(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetContentHeight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<ContentSizeType>(type), static_cast<ContentSizeUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setBorderTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setBorderTop(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetBorderTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<BorderType>(type), static_cast<BorderUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setBorderLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setBorderLeft(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetBorderLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<BorderType>(type), static_cast<BorderUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setBorderRight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setBorderRight(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetBorderRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<BorderType>(type), static_cast<BorderUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setBorderBottom
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setBorderBottom(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetBorderBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<BorderType>(type), static_cast<BorderUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMarginTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMarginTop(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetMarginTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<MarginType>(type), static_cast<MarginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMarginLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMarginLeft(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetMarginLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<MarginType>(type), static_cast<MarginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMarginRight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMarginRight(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetMarginRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<MarginType>(type), static_cast<MarginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMarginBottom
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMarginBottom(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetMarginBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<MarginType>(type), static_cast<MarginUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinMarginTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinMarginTop(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinMarginTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxMarginTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxMarginTop(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxMarginTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinMarginLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinMarginLeft(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinMarginLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxMarginLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxMarginLeft(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxMarginLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinMarginRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinMarginRight(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinMarginRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxMarginRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxMarginRight(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxMarginRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinMarginBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinMarginBottom(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinMarginBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxMarginBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxMarginBottom(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxMarginBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setPaddingTop
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setPaddingTop(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetPaddingTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<PaddingType>(type), static_cast<PaddingUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setPaddingLeft
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setPaddingLeft(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetPaddingLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<PaddingType>(type), static_cast<PaddingUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setPaddingRight
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setPaddingRight(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetPaddingRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<PaddingType>(type), static_cast<PaddingUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setPaddingBottom
 * Signature: (JIID)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setPaddingBottom(JNIEnv* env, jclass, jlong displayNodePtr, jint type, jint unit, jdouble length) {
	DisplayNodeSetPaddingBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr), static_cast<PaddingType>(type), static_cast<PaddingUnit>(unit), length);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinPaddingTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinPaddingTop(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinPaddingTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxPaddingTop
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxPaddingTop(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxPaddingTop(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinPaddingLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinPaddingLeft(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinPaddingLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxPaddingLeft
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxPaddingLeft(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxPaddingLeft(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinPaddingRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinPaddingRight(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinPaddingRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxPaddingRight
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxPaddingRight(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxPaddingRight(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMinPaddingBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMinPaddingBottom(JNIEnv* env, jclass, jlong displayNodePtr, jdouble min) {
	DisplayNodeSetMinPaddingBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr), min);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setMaxPaddingBottom
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setMaxPaddingBottom(JNIEnv* env, jclass, jlong displayNodePtr, jdouble max) {
	DisplayNodeSetMaxPaddingBottom(reinterpret_cast<DisplayNodeRef>(displayNodePtr), max);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setExpandFactor
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setExpandFactor(JNIEnv* env, jclass, jlong displayNodePtr, jdouble factor) {
	DisplayNodeSetExpandFactor(reinterpret_cast<DisplayNodeRef>(displayNodePtr), factor);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setShrinkFactor
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setShrinkFactor(JNIEnv* env, jclass, jlong displayNodePtr, jdouble factor) {
	DisplayNodeSetShrinkFactor(reinterpret_cast<DisplayNodeRef>(displayNodePtr), factor);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    setVisible
 * Signature: (JZ)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_setVisible(JNIEnv* env, jclass, jlong displayNodePtr, jboolean visible) {
	DisplayNodeSetVisible(reinterpret_cast<DisplayNodeRef>(displayNodePtr), visible);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    invalidateSize
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_invalidateSize(JNIEnv* env, jclass, jlong displayNodePtr) {
	DisplayNodeInvalidateSize(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    invalidateOrigin
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_invalidateOrigin(JNIEnv* env, jclass, jlong displayNodePtr) {
	DisplayNodeInvalidateOrigin(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    invalidateLayout
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_invalidateLayout(JNIEnv* env, jclass, jlong displayNodePtr) {
	DisplayNodeInvalidateLayout(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    resolve
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_resolve(JNIEnv* env, jclass, jlong displayNodePtr) {
	DisplayNodeResolve(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    measure
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_measure(JNIEnv* env, jclass, jlong displayNodePtr) {
	DisplayNodeMeasure(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    appendChild
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_appendChild(JNIEnv* env, jclass, jlong displayNodePtr, jlong childPtr) {
	DisplayNodeAppendChild(reinterpret_cast<DisplayNodeRef>(displayNodePtr), reinterpret_cast<DisplayNodeRef>(childPtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    insertChild
 * Signature: (JJI)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_insertChild(JNIEnv* env, jclass, jlong displayNodePtr, jlong childPtr, jint index) {
	DisplayNodeInsertChild(reinterpret_cast<DisplayNodeRef>(displayNodePtr), reinterpret_cast<DisplayNodeRef>(childPtr), index);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    removeChild
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_removeChild(JNIEnv* env, jclass, jlong displayNodePtr, jlong childPtr) {
	DisplayNodeRemoveChild(reinterpret_cast<DisplayNodeRef>(displayNodePtr), reinterpret_cast<DisplayNodeRef>(childPtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    isFillingParentWidth
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_isFillingParentWidth(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeIsFillingParentWidth(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    isFillingParentHeight
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_isFillingParentHeight(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeIsFillingParentHeight(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    isWrappingContentWidth
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_isWrappingContentWidth(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeIsWrappingContentWidth(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_DisplayNodeExternal
 * Method:    isWrappingContentHeight
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_view_display_external_DisplayNodeExternal_isWrappingContentHeight(JNIEnv* env, jclass, jlong displayNodePtr) {
	return DisplayNodeIsWrappingContentHeight(reinterpret_cast<DisplayNodeRef>(displayNodePtr));
}

#ifdef __cplusplus
}
#endif