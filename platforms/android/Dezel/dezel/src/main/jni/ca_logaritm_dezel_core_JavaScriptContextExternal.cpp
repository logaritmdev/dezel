#include <unordered_map>
#include "wrappers/JavaScriptExceptionWrapper.h"
#include "ca_logaritm_dezel_core_JavaScriptContextExternal.h"

static void
ContextExceptionCallback(JSContextRef context, JSValueRef error) {

	JavaScriptExceptionWrapperRef wrapper = (JavaScriptExceptionWrapperRef) JavaScriptContextGetAttribute(context, kJavaScriptExceptionWrapperKey);
	if (wrapper == NULL) {
		return;
	}

	jobject exception = wrapper->env->NewObject(
		JavaScriptValueClass,
		JavaScriptValueConstructor,
		wrapper->ctx
	);

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		exception,
		JavaScriptValueReset,
		reinterpret_cast<jlong>(error),
		true
	);

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->callback,
		JavaScriptExceptionWrapperExecute,
		exception
	);

	wrapper->env->DeleteLocalRef(exception);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptContextExternal
 * Method:    parse
 * Signature: (Ljava/lang/String;)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptContextExternal_create(JNIEnv* env, jclass, jstring identifier) {
	JNI_STRING_CREATE(identifier, name);
	JSContextRef context = JavaScriptContextCreate(name);
	JNI_STRING_DELETE(identifier, name)
	return reinterpret_cast<jlong>(context);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptContextExternal
 * Method:    delete
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptContextExternal_delete(JNIEnv* env, jclass, jlong contextPtr) {
	JavaScriptContextDelete(reinterpret_cast<JSContextRef>(contextPtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptContextExternal
 * Method:    getGlobalObject
 * Signature: (J)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptContextExternal_getGlobalObject(JNIEnv* env, jclass, jlong contextPtr) {
	return reinterpret_cast<jlong>(JavaScriptContextGetGlobalObject(reinterpret_cast<JSContextRef>(contextPtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptContextExternal
 * Method:    evaluate
 * Signature: (JLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptContextExternal_evaluate__JLjava_lang_String_2(JNIEnv* env, jclass, jlong contextPtr, jstring codeStr) {
	JNI_STRING_CREATE(codeStr, code);
	JavaScriptContextEvaluate(reinterpret_cast<JSContextRef>(contextPtr), code, NULL);
	JNI_STRING_DELETE(codeStr, code);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptContextExternal
 * Method:    evaluate
 * Signature: (JLjava/lang/String;Ljava/lang/String;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptContextExternal_evaluate__JLjava_lang_String_2Ljava_lang_String_2(JNIEnv* env, jclass, jlong contextPtr, jstring codeStr, jstring fileStr) {
	JNI_STRING_CREATE(fileStr, file);
	JNI_STRING_CREATE(codeStr, code);
	JavaScriptContextEvaluate(reinterpret_cast<JSContextRef>(contextPtr), code, file);
	JNI_STRING_DELETE(codeStr, code);
	JNI_STRING_DELETE(fileStr, file);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptContextExternal
 * Method:    setAttribute
 * Signature: (JILjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptContextExternal_setAttribute(JNIEnv* env, jclass, jlong contextPtr, jint key, jobject value) {
	JavaScriptContextSetAttribute(reinterpret_cast<JSContextRef>(contextPtr), key, value ? env->NewGlobalRef(value) : NULL);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptContextExternal
 * Method:    getAttribute
 * Signature: (JI)Ljava/lang/Object;
 */
jobject Java_ca_logaritm_dezel_core_JavaScriptContextExternal_getAttribute(JNIEnv* env, jclass, jlong contextPtr, jint key) {
	return reinterpret_cast<jobject>(JavaScriptContextGetAttribute(reinterpret_cast<JSContextRef>(contextPtr), key));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptContextExternal
 * Method:    delAttribute
 * Signature: (JI)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptContextExternal_delAttribute(JNIEnv* env, jclass, jlong contextPtr, jint key) {
	env->DeleteGlobalRef(reinterpret_cast<jobject>(JavaScriptContextGetAttribute(reinterpret_cast<JSContextRef>(contextPtr), key)));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptContextExternal
 * Method:    setExceptionCallback
 * Signature: (JLjava/lang/Object;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptContextExternal_setExceptionCallback(JNIEnv* env, jclass, jlong contextPtr, jobject handler, jobject context) {

	JavaScriptExceptionWrapperRef wrapper = (JavaScriptExceptionWrapperRef) JavaScriptContextGetAttribute(reinterpret_cast<JSContextRef>(contextPtr), kJavaScriptExceptionWrapperKey);

	if (wrapper) {
		JavaScriptContextGetAttribute(reinterpret_cast<JSContextRef>(contextPtr), kJavaScriptExceptionWrapperKey);
		delete wrapper;
	}

	JavaScriptContextSetAttribute(reinterpret_cast<JSContextRef>(contextPtr), kJavaScriptExceptionWrapperKey, JavaScriptExceptionWrapperCreate(env, handler, context));
	JavaScriptContextSetExceptionHandler(reinterpret_cast<JSContextRef>(contextPtr), &ContextExceptionCallback);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptContextExternal
 * Method:    throwError
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptContextExternal_throwError(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	JavaScriptContextHandleError(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptContextExternal
 * Method:    garbageCollect
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptContextExternal_garbageCollect(JNIEnv* env, jclass, jlong contextPtr) {
	JSGarbageCollect(reinterpret_cast<JSContextRef>(contextPtr));
}
