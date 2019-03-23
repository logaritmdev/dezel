#include <DLContext.h>
#include <DLValue.h>
#include "wrappers/JavaScriptFunctionWrapper.h"
#include "wrappers/JavaScriptGetterWrapper.h"
#include "wrappers/JavaScriptSetterWrapper.h"
#include "wrappers/JavaScriptFinalizeWrapper.h"
#include "ca_logaritm_dezel_core_JavaScriptValueExternal.h"
#include "jni_module_core.h"

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    createNull
 * Signature: (J)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptValueExternal_createNull(JNIEnv *env, jclass, jlong contextPtr) {
	return reinterpret_cast<jlong>(DLValueCreateNull(reinterpret_cast<JSContextRef>(contextPtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    createUndefined
 * Signature: (J)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptValueExternal_createUndefined(JNIEnv *env, jclass, jlong contextPtr) {
	return reinterpret_cast<jlong>(DLValueCreateUndefined(reinterpret_cast<JSContextRef>(contextPtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    createString
 * Signature: (JLjava/lang/String;)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptValueExternal_createString(JNIEnv *env, jclass, jlong contextPtr, jstring valueStr) {
	JNI_STRING_CREATE(valueStr, value);
	JSValueRef result = DLValueCreateString(reinterpret_cast<JSContextRef>(contextPtr), value);
	JNI_STRING_DELETE(valueStr, value);
	return reinterpret_cast<jlong>(result);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    createNumber
 * Signature: (JD)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptValueExternal_createNumber(JNIEnv *env, jclass, jlong contextPtr, jdouble value) {
	return reinterpret_cast<jlong>(DLValueCreateNumber(reinterpret_cast<JSContextRef>(contextPtr), value));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    createBoolean
 * Signature: (JZ)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptValueExternal_createBoolean(JNIEnv *env, jclass, jlong contextPtr, jboolean value) {
	return reinterpret_cast<jlong>(DLValueCreateBoolean(reinterpret_cast<JSContextRef>(contextPtr), value));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    createEmtpyObject
 * Signature: (J)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptValueExternal_createEmtpyObject(JNIEnv *env, jclass, jlong contextPtr) {
	return reinterpret_cast<jlong>(DLValueCreateEmptyObject(reinterpret_cast<JSContextRef>(contextPtr), NULL));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    createEmptyArray
 * Signature: (J)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptValueExternal_createEmptyArray(JNIEnv *env, jclass, jlong contextPtr) {
	return reinterpret_cast<jlong>(DLValueCreateEmptyArray(reinterpret_cast<JSContextRef>(contextPtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    createFunction
 * Signature: (JLjava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptValueExternal_createFunction(JNIEnv *env, jclass, jlong contextPtr, jobject callback, jstring nameStr, jobject context) {

	if (nameStr == NULL) {
		return reinterpret_cast<jlong>(JavaScriptFunctionWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), callback, NULL, context)->function);
	}

	JNI_STRING_CREATE(nameStr, name);
	JSValueRef result = JavaScriptFunctionWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), callback, name, context)->function;
	JNI_STRING_DELETE(nameStr, name);

	return reinterpret_cast<jlong>(result);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    protect
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_protect(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	DLValueProtect(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    unprotect
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_unprotect(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	DLValueUnprotect(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    call
 * Signature: (JJJ[JILjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_call(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jlong objectPtr, jlongArray valuesPtr, jint argc, jobject result) {

	JNI_LONG_ARRAY_CONVERT(argv, valuesPtr, argc, JSValueRef);

	JSValueRef value = DLValueCall(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), reinterpret_cast<JSObjectRef>(objectPtr), static_cast<unsigned int>(argc), argv);

	if (result) {
		JNI_CALL_VOID_METHOD(env, result, JavaScriptValueReset, reinterpret_cast<jlong>(value), true);
	}
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    callMethod
 * Signature: (JJLjava/lang/String;[JILjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_callMethod(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jstring methodStr, jlongArray valuesPtr, jint argc, jobject result) {

	JNI_LONG_ARRAY_CONVERT(argv, valuesPtr, argc, JSValueRef);

	JNI_STRING_CREATE(methodStr, method);
	JSValueRef value = DLValueCallMethod(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), method, static_cast<unsigned int>(argc), argv);
	JNI_STRING_DELETE(methodStr, method);

	if (result) {
		JNI_CALL_VOID_METHOD(env, result, JavaScriptValueReset, reinterpret_cast<jlong>(value), true);
	}
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    construct
 * Signature: (JJ[JILjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_construct(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jlongArray valuesPtr, jint argc, jobject result) {

	JNI_LONG_ARRAY_CONVERT(argv, valuesPtr, argc, JSValueRef);

	JSValueRef value = DLValueConstruct(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), static_cast<unsigned int>(argc), argv);

	if (result) {
		JNI_CALL_VOID_METHOD(env, result, JavaScriptValueReset, reinterpret_cast<jlong>(value), true);
	}
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    defineProperty
 * Signature: (JJLjava/lang/String;JLjava/lang/Object;Ljava/lang/Object;ZZZLjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_defineProperty(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr, jlong value, jobject getter, jobject setter, jboolean writable, jboolean enumerable, jboolean configurable, jobject context) {

	if (value) {
		JNI_STRING_CREATE(propertyStr, property);
		DLValueDefineProperty(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, NULL, NULL, reinterpret_cast<JSValueRef>(value), writable, configurable, enumerable);
		JNI_STRING_DELETE(propertyStr, property);
		return;
	}

	JSObjectRef get = NULL;
	JSObjectRef set = NULL;

	if (getter) get = JavaScriptGetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), getter, NULL, context)->function;
	if (setter) set = JavaScriptSetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), setter, NULL, context)->function;

	JNI_STRING_CREATE(propertyStr, property);
	DLValueDefineProperty(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, get, set, NULL, writable, enumerable, configurable);
	JNI_STRING_DELETE(propertyStr, property);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setProperty
 * Signature: (JJLjava/lang/String;J)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setProperty__JJLjava_lang_String_2J(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr, jlong value) {
	JNI_STRING_CREATE(propertyStr, property);
	DLValueSetProperty(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, reinterpret_cast<JSValueRef>(value));
	JNI_STRING_DELETE(propertyStr, property);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setProperty
 * Signature: (JJLjava/lang/String;Ljava/lang/String;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setProperty__JJLjava_lang_String_2Ljava_lang_String_2(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr, jstring valueStr) {
	JNI_STRING_CREATE(valueStr, value);
	JNI_STRING_CREATE(propertyStr, property);
	DLValueSetPropertyWithString(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, value);
	JNI_STRING_DELETE(propertyStr, property);
	JNI_STRING_DELETE(valueStr, value);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setProperty
 * Signature: (JJLjava/lang/String;D)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setProperty__JJLjava_lang_String_2D(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr, jdouble value) {
	JNI_STRING_CREATE(propertyStr, property);
	DLValueSetPropertyWithNumber(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, value);
	JNI_STRING_DELETE(propertyStr, property);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setProperty
 * Signature: (JJLjava/lang/String;Z)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setProperty__JJLjava_lang_String_2Z(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr, jboolean value) {
	JNI_STRING_CREATE(propertyStr, property);
	DLValueSetPropertyWithBoolean(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, value);
	JNI_STRING_DELETE(propertyStr, property);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    getProperty
 * Signature: (JJLjava/lang/String;)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptValueExternal_getProperty(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr) {
	JNI_STRING_CREATE(propertyStr, property);
	JSValueRef result = DLValueGetProperty(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property);
	JNI_STRING_DELETE(propertyStr, property);
	return reinterpret_cast<jlong>(result);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    deleteProperty
 * Signature: (JJLjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_deleteProperty(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr) {
	JNI_STRING_CREATE(propertyStr, property);
	DLValueDeleteProperty(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property);
	JNI_STRING_DELETE(propertyStr, property);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setPropertyAtIndex
 * Signature: (JJIJ)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setPropertyAtIndex__JJIJ(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jint index, jlong value) {
	DLValueSetPropertyAtIndex(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (unsigned int) index, reinterpret_cast<JSValueRef>(value));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setPropertyAtIndex
 * Signature: (JJILjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setPropertyAtIndex__JJILjava_lang_String_2(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jint index, jstring valueStr) {
	JNI_STRING_CREATE(valueStr, value);
	DLValueSetPropertyAtIndexWithString(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (unsigned int) index, value);
	JNI_STRING_DELETE(valueStr, value);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setPropertyAtIndex
 * Signature: (JJID)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setPropertyAtIndex__JJID(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jint index, jdouble value) {
	DLValueSetPropertyAtIndexWithNumber(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (unsigned int) index, value);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setPropertyAtIndex
 * Signature: (JJIZ)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setPropertyAtIndex__JJIZ(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jint index, jboolean value) {
	DLValueSetPropertyAtIndexWithBoolean(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (unsigned int) index, value);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    getPropertyAtIndex
 * Signature: (JJI)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptValueExternal_getPropertyAtIndex(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jint index) {
	return reinterpret_cast<jlong>(DLValueGetPropertyAtIndex(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (unsigned int) index));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setPrototype
 * Signature: (JJJ)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setPrototype(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jlong prototypePtr) {
	DLValueSetPrototype(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (JSValueRef) prototypePtr);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    getPrototype
 * Signature: (JJ)J
 */
jlong Java_ca_logaritm_dezel_core_JavaScriptValueExternal_getPrototype(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return reinterpret_cast<jlong>(DLValueGetPrototype(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setAttribute
 * Signature: (JJILjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setAttribute(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jint key, jobject value) {
	DLValueSetAttribute(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), static_cast<long long>(key), env->NewGlobalRef(value));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    getAttribute
 * Signature: (JJI)Ljava/lang/Object;
 */
jobject Java_ca_logaritm_dezel_core_JavaScriptValueExternal_getAttribute(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jint key) {
	return reinterpret_cast<jobject>(DLValueGetAttribute(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), static_cast<long long>(key)));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    getAttribute
 * Signature: (JI)Ljava/lang/Object;
 */
jobject Java_ca_logaritm_dezel_core_JavaScriptValueExternal_getAttribute(JNIEnv *env, jclass, jlong valuePtr, jint key) {
	return reinterpret_cast<jobject>(DLValueDataGetAttribute(reinterpret_cast<DLValueDataRef>(valuePtr), static_cast<long long>(key)));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    deleteAttribute
 * Signature: (JJI)V
 */
JNIEXPORT void JNICALL Java_ca_logaritm_dezel_core_JavaScriptValueExternal_deleteAttribute__JJI(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jint key) {

	jobject value = (jobject) DLValueGetAttribute(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), key);

	if (value == NULL) {
		return;
	}

	env->DeleteGlobalRef(value);

	DLValueDeleteAttribute(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), key);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    deleteAttribute
 * Signature: (JI)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_deleteAttribute__JI(JNIEnv *env, jclass, jlong valuePtr, jint key) {

	jobject value = (jobject) DLValueDataGetAttribute(reinterpret_cast<DLValueDataRef>(valuePtr), key);

	if (value == NULL) {
		return;
	}

	env->DeleteGlobalRef(value);

	DLValueDataDeleteAttribute(reinterpret_cast<DLValueDataRef>(valuePtr), key);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setAssociatedObject
 * Signature: (JJLjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setAssociatedObject__JJLjava_lang_Object_2(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jobject object) {
	DLValueSetAssociatedObject(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), env->NewGlobalRef(object));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setAssociatedObject
 * Signature: (JLjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setAssociatedObject__JLjava_lang_Object_2(JNIEnv *env, jclass, jlong valuePtr, jobject object) {
	DLValueDataSetAssociatedObject(reinterpret_cast<DLValueDataRef>(valuePtr), env->NewGlobalRef(object));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    getAssociatedObject
 * Signature: (JJ)Ljava/lang/Object;
 */
jobject Java_ca_logaritm_dezel_core_JavaScriptValueExternal_getAssociatedObject__JJ(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jobject) DLValueGetAssociatedObject(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    getAssociatedObject
 * Signature: (J)Ljava/lang/Object;
 */
jobject Java_ca_logaritm_dezel_core_JavaScriptValueExternal_getAssociatedObject__J(JNIEnv *env, jclass, jlong valuePtr) {
	return (jobject) DLValueDataGetAssociatedObject(reinterpret_cast<DLValueDataRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    deleteAssociatedObject
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_deleteAssociatedObject__JJ(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {

	jobject value = (jobject) DLValueGetAssociatedObject(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr));

	if (value == NULL) {
		return;
	}

	env->DeleteGlobalRef(value);

	DLValueSetAssociatedObject(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), NULL);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    deleteAssociatedObject
 * Signature: (J)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_deleteAssociatedObject__J(JNIEnv *env, jclass, jlong valuePtr) {

	jobject value = (jobject) DLValueDataGetAssociatedObject(reinterpret_cast<DLValueDataRef>(valuePtr));

	if (value == NULL) {
		return;
	}

	env->DeleteGlobalRef(value);

	DLValueDataSetAssociatedObject(reinterpret_cast<DLValueDataRef>(valuePtr), NULL);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    setFinalizeHandler
 * Signature: (JJLjava/lang/Object;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptValueExternal_setFinalizeHandler(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jobject handler, jobject context) {
	JavaScriptFinalizeWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), handler, context);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    equals
 * Signature: (JJJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_equals__JJJ(JNIEnv *env, jclass, jlong contextPtr, jlong value1Ptr, jlong value2Ptr) {
	return (jboolean) DLValueEquals(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(value1Ptr), reinterpret_cast<JSValueRef>(value2Ptr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    equals
 * Signature: (JJLjava/lang/String;)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_equals__JJLjava_lang_String_2(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jstring valueStr) {
	JNI_STRING_CREATE(valueStr, value);
	bool result = DLValueEqualsString(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr), value);
	JNI_STRING_DELETE(valueStr, value);
	return (jboolean) result;
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    equals
 * Signature: (JJD)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_equals__JJD(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jdouble value) {
	return (jboolean) DLValueEqualsNumber(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr), value);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    equals
 * Signature: (JJZ)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_equals__JJZ(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr, jboolean value) {
	return (jboolean) DLValueEqualsBoolean(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr), value);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    isString
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_isString(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) DLValueIsString(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    isNumber
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_isNumber(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) DLValueIsNumber(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    isBoolean
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_isBoolean(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) DLValueIsBoolean(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    isFunction
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_isFunction(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) DLValueIsFunction(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    isObject
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_isObject(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) DLValueIsObject(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    isArray
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_isArray(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) DLValueIsArray(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    isUndefined
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_isUndefined(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) DLValueIsUndefined(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    isNull
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_isNull(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) DLValueIsNull(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    getType
 * Signature: (JJ)I
 */
jint Java_ca_logaritm_dezel_core_JavaScriptValueExternal_getType(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return DLValueGetType(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    toString
 * Signature: (JJ)Ljava/lang/String;
 */
jstring Java_ca_logaritm_dezel_core_JavaScriptValueExternal_toString(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return env->NewStringUTF(DLValueToString(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    toNumber
 * Signature: (JJ)D
 */
jdouble Java_ca_logaritm_dezel_core_JavaScriptValueExternal_toNumber(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jdouble) DLValueToNumber(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptValueExternal
 * Method:    toBoolean
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_JavaScriptValueExternal_toBoolean(JNIEnv *env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) DLValueToBoolean(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}