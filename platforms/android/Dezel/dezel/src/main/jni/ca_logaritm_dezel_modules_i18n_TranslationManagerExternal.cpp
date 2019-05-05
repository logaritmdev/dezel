#include <jni.h>
#include "jni_init.h"
#include "ca_logaritm_dezel_modules_i18n_TranslationManagerExternal.h"
#include "DLTranslationManager.h"

/*
 * Class:     ca_logaritm_dezel_modules_i18n_TranslationManagerExternal
 * Method:    load
 * Signature: ([B)V
 */
void Java_ca_logaritm_dezel_modules_i18n_TranslationManagerExternal_load(JNIEnv *env, jclass, jbyteArray bytes)  {
	JNI_CONVERT_BUFFER(buf, bytes, unsigned char);
	DLTranslationManagerLoad(buf);
	JNI_DELETE_BUFFER(buf);
}

/*
 * Class:     ca_logaritm_dezel_modules_i18n_TranslationManagerExternal
 * Method:    clear
 * Signature: ()V
 */
void Java_ca_logaritm_dezel_modules_i18n_TranslationManagerExternal_clear(JNIEnv *env, jclass) {
	DLTranslationManagerClear();
}

/*
 * Class:     ca_logaritm_dezel_modules_i18n_TranslationManagerExternal
 * Method:    translate
 * Signature: (Ljava/lang/String;)Ljava/lang/String;
 */
jstring Java_ca_logaritm_dezel_modules_i18n_TranslationManagerExternal_translate__Ljava_lang_String_2(JNIEnv *env, jclass, jstring messageStr) {
	JNI_STRING_CREATE(messageStr, message);
	auto string = DLTranslationManagerTranslate(message, NULL);
	JNI_STRING_DELETE(messageStr, message);
	return env->NewStringUTF(string);
}

/*
 * Class:     ca_logaritm_dezel_modules_i18n_TranslationManagerExternal
 * Method:    translate
 * Signature: (Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
jstring Java_ca_logaritm_dezel_modules_i18n_TranslationManagerExternal_translate__Ljava_lang_String_2Ljava_lang_String_2(JNIEnv *env, jclass, jstring messageStr, jstring contextStr) {
	JNI_STRING_CREATE(messageStr, message);
	JNI_STRING_CREATE(contextStr, context);
	auto string = DLTranslationManagerTranslate(message, context);
	JNI_STRING_DELETE(messageStr, message);
	JNI_STRING_DELETE(contextStr, context);
	return env->NewStringUTF(string);
}

