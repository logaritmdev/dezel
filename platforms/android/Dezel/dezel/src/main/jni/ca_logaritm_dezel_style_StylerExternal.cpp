#include "jni_init.h"
#include "jni_module_style.h"
#include <DLStylerNode.h>
#include <DLStyler.h>
#include <DLStylerPrivate.h>
#include "ca_logaritm_dezel_style_StylerExternal.h"

/*
 * Class:     ca_logaritm_dezel_style_StylerExternal
 * Method:    parse
 * Signature: ()J
 */
jlong Java_ca_logaritm_dezel_style_StylerExternal_create(JNIEnv* , jclass) {
	return reinterpret_cast<jlong>(DLStylerCreate());
}

/*
 * Class:     ca_logaritm_dezel_style_StylerExternal
 * Method:    delete
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_style_StylerExternal_delete(JNIEnv* , jclass, jlong stylerPtr) {
	DLStylerDelete(reinterpret_cast<DLStylerRef>(stylerPtr));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerExternal
 * Method:    setRoot
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_style_StylerExternal_setRoot(JNIEnv* env, jclass, jlong stylerPtr, jlong stylerNodePtr) {
	DLStylerSetRoot(reinterpret_cast<DLStylerRef>(stylerPtr), reinterpret_cast<DLStylerNodeRef>(stylerNodePtr));
}

/*
 * Class:     ca_logaritm_dezel_style_StylerExternal
 * Method:    load
 * Signature: (JLjava/lang/String;Ljava/lang/String;)V
 */
void Java_ca_logaritm_dezel_style_StylerExternal_load(JNIEnv* env, jclass, jlong stylerPtr, jstring codeStr, jstring fileStr) {
	JNI_STRING_CREATE(codeStr, code);
	JNI_STRING_CREATE(fileStr, file);
	DLStylerLoadStyles(reinterpret_cast<DLStylerRef>(stylerPtr), code, file);
	JNI_STRING_DELETE(fileStr, file);
	JNI_STRING_DELETE(codeStr, code);
}

/*
 * Class:     ca_logaritm_dezel_style_StylerExternal
 * Method:    setVariable
 * Signature: (JLjava/lang/String;Ljava/lang/String;)V
 */ 
void Java_ca_logaritm_dezel_style_StylerExternal_setVariable(JNIEnv* env, jclass, jlong stylerPtr, jstring nameStr, jstring valueStr) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(valueStr, value);
	DLStylerSetVariable(reinterpret_cast<DLStylerRef>(stylerPtr), name, value);
	JNI_STRING_DELETE(valueStr, value);
	JNI_STRING_DELETE(nameStr, name);
}