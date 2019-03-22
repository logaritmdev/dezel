#include "jni_init.h"
#include "jni_module_style.h"
#include <DLStylerNode.h>
#include <DLStylerStyleItem.h>
#include "wrappers/StylerNodeWrapper.h"
#include "ca_logaritm_dezel_style_StylerNodeExternal.h"

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    parse
 * Signature: ()J
 */
jlong Java_ca_logaritm_dezel_style_StylerNodeExternal_create(JNIEnv *env, jclass, jobject object) {
	DLStylerNodeRef styler = DLStylerNodeCreate();
	DLStylerNodeSetData(styler, StylerNodeWrapperCreate(env, object, styler));
	return reinterpret_cast<jlong>(styler);
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    delete
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_delete(JNIEnv *env, jclass, jlong stylerNodePtr) {

	DLStylerNodeRef node = reinterpret_cast<DLStylerNodeRef>(stylerNodePtr);
	if (node == NULL) {
		return;
	}

	StylerNodeWrapperDelete(env, reinterpret_cast<StylerNodeWrapperRef>(DLStylerNodeGetData(node)));

	delete node;
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    setId
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_setId(JNIEnv *env, jclass, jlong stylerNodePtr, jstring idStr) {
	JNI_STRING_CREATE(idStr, id);
	DLStylerNodeSetId(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), id);
	JNI_STRING_DELETE(idStr, id)
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    setStyler
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_setStyler(JNIEnv *env, jclass, jlong stylerNodePtr, jlong stylerPtr) {
	DLStylerNodeSetStyler(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), reinterpret_cast<DLStylerRef>(stylerPtr));
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    setType
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_setType(JNIEnv *env, jclass, jlong stylerNodePtr, jstring typeStr) {
	JNI_STRING_CREATE(typeStr, type);
	DLStylerNodeSetType(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), type);
	JNI_STRING_DELETE(typeStr, type);
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    setVisible
 * Signature: (JZ)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_setVisible(JNIEnv *env, jclass, jlong stylerNodePtr, jboolean visible) {
	DLStylerNodeSetVisible(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), visible);
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    appendChild
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_appendChild(JNIEnv *env, jclass, jlong stylerNodePtr, jlong childPtr) {
	DLStylerNodeAppendChild(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), reinterpret_cast<DLStylerNodeRef>(childPtr));
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    insertChild
 * Signature: (JJI)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_insertChild(JNIEnv *env, jclass, jlong stylerNodePtr, jlong childPtr, jint index) {
	DLStylerNodeInsertChild(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), reinterpret_cast<DLStylerNodeRef>(childPtr), index);
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    removeChild
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_removeChild(JNIEnv *env, jclass, jlong stylerNodePtr, jlong childPtr) {
	DLStylerNodeRemoveChild(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), reinterpret_cast<DLStylerNodeRef>(childPtr));
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    appendShadowedNode
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_appendShadowedNode(JNIEnv *env, jclass, jlong stylerNodePtr, jlong childPtr) {
	DLStylerNodeAppendShadowedNode(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), reinterpret_cast<DLStylerNodeRef>(childPtr));
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    removeShadowedNode
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_removeShadowedNode(JNIEnv *env, jclass, jlong stylerNodePtr, jlong childPtr) {
	DLStylerNodeRemoveShadowedNode(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), reinterpret_cast<DLStylerNodeRef>(childPtr));
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    appendStyle
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_appendStyle(JNIEnv *env, jclass, jlong stylerNodePtr, jstring styleStr) {
	JNI_STRING_CREATE(styleStr, style);
	DLStylerNodeAppendStyle(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), style);
	JNI_STRING_DELETE(styleStr, style);
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    removeStyle
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_removeStyle(JNIEnv *env, jclass, jlong stylerNodePtr, jstring styleStr) {
	JNI_STRING_CREATE(styleStr, style);
	DLStylerNodeRemoveStyle(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), style);
	JNI_STRING_DELETE(styleStr, style);
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    appendState
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_appendState(JNIEnv *env, jclass, jlong stylerNodePtr, jstring stateStr) {
	JNI_STRING_CREATE(stateStr, state);
	DLStylerNodeAppendState(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), state);
	JNI_STRING_DELETE(stateStr, state);
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    removeState
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_removeState(JNIEnv *env, jclass, jlong stylerNodePtr, jstring stateStr) {
	JNI_STRING_CREATE(stateStr, state);
	DLStylerNodeRemoveState(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr), state);
	JNI_STRING_DELETE(stateStr, state);
}

/*
 * Class:     ca_logaritm_dezel_style_StyleExternal
 * Method:    resolve
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_resolve(JNIEnv *env, jclass, jlong stylerNodePtr) {
	DLStylerNodeResolve(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    getData
 * Signature: (J)Ljava/lang/Object;
 */
jobject Java_ca_logaritm_dezel_style_StylerNodeExternal_getData(JNIEnv *env, jclass, jlong stylerNodePtr) {

	StylerNodeWrapperRef wrapper = reinterpret_cast<StylerNodeWrapperRef>(DLStylerNodeGetData(reinterpret_cast<DLStylerNodeRef>(stylerNodePtr)));

	if (wrapper == NULL) {
		return NULL;
	}

	return wrapper->object;
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    getItemProperty
 * Signature: (J)Ljava/lang/String;
 */
jstring Java_ca_logaritm_dezel_style_StylerNodeExternal_getItemProperty(JNIEnv *env, jclass, jlong stylerStyleItemPtr) {
	return env->NewStringUTF(DLStylerStyleItemGetProperty(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr)));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    setItemValueType
 * Signature: (JI)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_setItemValueType(JNIEnv *env, jclass, jlong stylerStyleItemPtr, jint type) {
	DLStylerStyleItemSetValueType(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr), static_cast<DLStylerStyleItemType>(type));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    getItemValueType
 * Signature: (J)I
 */
jint Java_ca_logaritm_dezel_style_StylerNodeExternal_getItemValueType(JNIEnv *env, jclass, jlong stylerStyleItemPtr) {
	return static_cast<jint>(DLStylerStyleItemGetValueType(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr)));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    setItemValueUnit
 * Signature: (JI)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_setItemValueUnit(JNIEnv *env, jclass, jlong stylerStyleItemPtr, jint unit) {
	DLStylerStyleItemSetValueUnit(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr), static_cast<DLStylerStyleItemUnit>(unit));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    getItemValueUnit
 * Signature: (J)I
 */
jint Java_ca_logaritm_dezel_style_StylerNodeExternal_getItemValueUnit(JNIEnv *env, jclass, jlong stylerStyleItemPtr) {
	return static_cast<jint>(DLStylerStyleItemGetValueUnit(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr)));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    setItemValueWithString
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_setItemValueWithString(JNIEnv *env, jclass, jlong stylerStyleItemPtr, jstring valueStr) {
	JNI_STRING_CREATE(valueStr, value);
	DLStylerStyleItemSetValueWithString(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr), value);
	JNI_STRING_DELETE(valueStr, value);
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    getItemValueAsString
 * Signature: (J)Ljava/lang/String;
 */
jstring Java_ca_logaritm_dezel_style_StylerNodeExternal_getItemValueAsString(JNIEnv *env, jclass, jlong stylerStyleItemPtr) {
	return env->NewStringUTF(DLStylerStyleItemGetValueAsString(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr)));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    setItemValueWithNumber
 * Signature: (JD)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_setItemValueWithNumber(JNIEnv *env, jclass, jlong stylerStyleItemPtr, jdouble value) {
	DLStylerStyleItemSetValueWithNumber(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr), value);
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    getItemValueAsNumber
 * Signature: (J)D
 */
jdouble Java_ca_logaritm_dezel_style_StylerNodeExternal_getItemValueAsNumber(JNIEnv *env, jclass, jlong stylerStyleItemPtr) {
	return static_cast<jdouble>(DLStylerStyleItemGetValueAsNumber(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr)));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    setItemValueWithBoolean
 * Signature: (JZ)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_setItemValueWithBoolean(JNIEnv *env, jclass, jlong stylerStyleItemPtr, jboolean value) {
	DLStylerStyleItemSetValueWithBoolean(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr), value);
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    getItemValueAsBoolean
 * Signature: (J)Z
 */
jboolean Java_ca_logaritm_dezel_style_StylerNodeExternal_getItemValueAsBoolean(JNIEnv *env, jclass, jlong stylerStyleItemPtr) {
	return static_cast<jboolean>(DLStylerStyleItemGetValueAsBoolean(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr)));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    setItemData
 * Signature: (JLjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_style_StylerNodeExternal_setItemData(JNIEnv *env, jclass, jlong stylerStyleItemPtr, jobject data) {
	DLStylerStyleItemSetData(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr), env->NewGlobalRef(data));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerNodeExternal
 * Method:    getItemData
 * Signature: (J)Ljava/lang/Object;
 */
jobject Java_ca_logaritm_dezel_style_StylerNodeExternal_getItemData(JNIEnv *env, jclass, jlong stylerStyleItemPtr) {
	return reinterpret_cast<jobject>(DLStylerStyleItemGetData(reinterpret_cast<DLStylerStyleItemRef>(stylerStyleItemPtr)));
}