#include "jni_init.h"
#include "jni_module_display.h"
#include "ca_logaritm_dezel_view_display_external_StylesheetExternal.h"
#include "StylesheetRef.h"
#include "Stylesheet.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Class:     ca_logaritm_dezel_view_display_external_StylesheetExternal
 * Method:    create
 * Signature: ()J
 */
jlong Java_ca_logaritm_dezel_view_display_external_StylesheetExternal_create(JNIEnv* env, jclass) {
	return reinterpret_cast<jlong>(StylesheetCreate());
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_StylesheetExternal
 * Method:    delete
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_view_display_external_StylesheetExternal_delete(JNIEnv* env, jclass, jlong stylesheetPtr) {
	delete reinterpret_cast<StylesheetRef>(stylesheetPtr);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_StylesheetExternal
 * Method:    setVariable
 * Signature: (JLjava/lang/String;Ljava/lang/String;)V
 */
void Java_ca_logaritm_dezel_view_display_external_StylesheetExternal_setVariable(JNIEnv* env, jclass, jlong stylesheetPtr, jstring nameStr, jstring valueStr) {

	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(valueStr, value);

	ParseError* error = nullptr;

	StylesheetSetVariable(reinterpret_cast<StylesheetRef>(stylesheetPtr), name, value, &error);

	if (error) {

		jobject exception = env->NewObject(
			ParseErrorClass,
			ParseErrorConstructor,
			env->NewStringUTF(error->message),
			static_cast<jint>(error->col),
			static_cast<jint>(error->row),
			env->NewStringUTF(error->url)
		);

		env->Throw(reinterpret_cast<jthrowable>(exception));
	}

	JNI_STRING_DELETE(valueStr, value)
	JNI_STRING_DELETE(nameStr, name);
}

/*
 * Class:     ca_logaritm_dezel_view_display_external_StylesheetExternal
 * Method:    evaluate
 * Signature: (JLjava/lang/String;Ljava/lang/String;)V
 */
void Java_ca_logaritm_dezel_view_display_external_StylesheetExternal_evaluate(JNIEnv* env, jclass, jlong stylesheetPtr, jstring sourceStr, jstring urlStr) {

	JNI_STRING_CREATE(sourceStr, source);
	JNI_STRING_CREATE(urlStr, url);

	ParseError* error = nullptr;

	StylesheetEvaluate(reinterpret_cast<StylesheetRef>(stylesheetPtr), source, url, &error);

	if (error) {

		jobject exception = env->NewObject(
			ParseErrorClass,
			ParseErrorConstructor,
			env->NewStringUTF(error->message),
			static_cast<jint>(error->col),
			static_cast<jint>(error->row),
			env->NewStringUTF(error->url)
		);

		env->Throw(reinterpret_cast<jthrowable>(exception));
	}

	JNI_STRING_DELETE(urlStr, url);
	JNI_STRING_DELETE(sourceStr, source)
}

#ifdef __cplusplus
}
#endif