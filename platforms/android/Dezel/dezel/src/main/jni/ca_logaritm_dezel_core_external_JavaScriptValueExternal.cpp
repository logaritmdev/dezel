#include <JavaScriptContext.h>
#include <JavaScriptValue.h>
#include "wrappers/JavaScriptFunctionWrapper.h"
#include "wrappers/JavaScriptGetterWrapper.h"
#include "wrappers/JavaScriptSetterWrapper.h"
#include "wrappers/JavaScriptFinalizeWrapper.h"
#include "wrappers/JavaScriptValueForEachWrapper.h"
#include "wrappers/JavaScriptValueForOwnWrapper.h"
#include "ca_logaritm_dezel_core_external_JavaScriptValueExternal.h"
#include "jni_module_core.h"

static void
JavaScriptValueForEachCallback(JSContextRef context, JSValueRef value, int index, void* data)
{
	JavaScriptValueForEachWrapperRef wrapper = reinterpret_cast<JavaScriptValueForEachWrapperRef>(data);
	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->callback,
		JavaScriptValueForEachWrapperExecute,
		reinterpret_cast<jint>(index),
		reinterpret_cast<jlong>(JavaScriptValueGetPropertyAtIndex(context, (JSObjectRef) value, (unsigned int) index))
	)
}

static void
JavaScriptValueForOwnCallback(JSContextRef context, JSValueRef value, const char* name, void* data)
{
	JavaScriptValueForOwnWrapperRef wrapper = reinterpret_cast<JavaScriptValueForOwnWrapperRef>(data);
	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->callback,
		JavaScriptValueForOwnWrapperExecute,
		wrapper->env->NewStringUTF(name),
		reinterpret_cast<jlong>(JavaScriptValueGetProperty(context, (JSObjectRef) value, name))
	)
}

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    createNull
 * Signature: (J)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_createNull(JNIEnv* env, jclass, jlong contextPtr) {
	return reinterpret_cast<jlong>(JavaScriptValueCreateNull(reinterpret_cast<JSContextRef>(contextPtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    createUndefined
 * Signature: (J)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_createUndefined(JNIEnv* env, jclass, jlong contextPtr) {
	return reinterpret_cast<jlong>(JavaScriptValueCreateUndefined(reinterpret_cast<JSContextRef>(contextPtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    createString
 * Signature: (JLjava/lang/String;)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_createString(JNIEnv* env, jclass, jlong contextPtr, jstring valueStr) {
	JNI_STRING_CREATE(valueStr, value);
	JSValueRef result = JavaScriptValueCreateString(reinterpret_cast<JSContextRef>(contextPtr), value);
	JNI_STRING_DELETE(valueStr, value);
	return reinterpret_cast<jlong>(result);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    createNumber
 * Signature: (JD)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_createNumber(JNIEnv* env, jclass, jlong contextPtr, jdouble value) {
	return reinterpret_cast<jlong>(JavaScriptValueCreateNumber(reinterpret_cast<JSContextRef>(contextPtr), value));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    createBoolean
 * Signature: (JZ)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_createBoolean(JNIEnv* env, jclass, jlong contextPtr, jboolean value) {
	return reinterpret_cast<jlong>(JavaScriptValueCreateBoolean(reinterpret_cast<JSContextRef>(contextPtr), value));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    createSymbol
 * Signature: (JLjava/lang/String;)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_createSymbol(JNIEnv* env, jclass, jlong contextPtr, jstring valueStr) {
	JNI_STRING_CREATE(valueStr, value);
	auto symbol = JavaScriptValueCreateSymbol(reinterpret_cast<JSContextRef>(contextPtr), value);
	JNI_STRING_DELETE(valueStr, value);
	return reinterpret_cast<jlong>(symbol);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    createEmtpyObject
 * Signature: (J)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_createEmtpyObject(JNIEnv* env, jclass, jlong contextPtr) {
	return reinterpret_cast<jlong>(JavaScriptValueCreateEmptyObject(reinterpret_cast<JSContextRef>(contextPtr), nullptr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    createEmptyArray
 * Signature: (J)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_createEmptyArray(JNIEnv* env, jclass, jlong contextPtr) {
	return reinterpret_cast<jlong>(JavaScriptValueCreateEmptyArray(reinterpret_cast<JSContextRef>(contextPtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    createFunction
 * Signature: (JLjava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_createFunction(JNIEnv* env, jclass, jlong contextPtr, jobject callback, jstring nameStr, jobject context) {

	if (nameStr == nullptr) {
		return reinterpret_cast<jlong>(JavaScriptFunctionWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), callback, nullptr, context)->function);
	}

	JNI_STRING_CREATE(nameStr, name);
	JSValueRef result = JavaScriptFunctionWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), callback, name, context)->function;
	JNI_STRING_DELETE(nameStr, name);

	return reinterpret_cast<jlong>(result);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    protect
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_protect(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	JavaScriptValueProtect(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    unprotect
 * Signature: (JJ)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_unprotect(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	JavaScriptValueUnprotect(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    call
 * Signature: (JJJ[JILjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_call(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jlong objectPtr, jlongArray valuesPtr, jint argc, jobject result) {

	JNI_LONG_ARRAY_CONVERT(argv, valuesPtr, argc, JSValueRef);

	JSValueRef value = JavaScriptValueCall(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), reinterpret_cast<JSObjectRef>(objectPtr), static_cast<unsigned int>(argc), argv);

	JNI_CHECK_EXCEPTION(env)

	if (result) {
		JNI_CALL_VOID_METHOD(env, result, JavaScriptValueReset, reinterpret_cast<jlong>(value), true, true);
	}
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    callMethod
 * Signature: (JJLjava/lang/String;[JILjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_callMethod(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jstring methodStr, jlongArray valuesPtr, jint argc, jobject result) {

	JNI_LONG_ARRAY_CONVERT(argv, valuesPtr, argc, JSValueRef);

	JNI_STRING_CREATE(methodStr, method);
	JSValueRef value = JavaScriptValueCallMethod(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), method, static_cast<unsigned int>(argc), argv);
	JNI_STRING_DELETE(methodStr, method);

	JNI_CHECK_EXCEPTION(env)

	if (result) {
		JNI_CALL_VOID_METHOD(env, result, JavaScriptValueReset, reinterpret_cast<jlong>(value), true, true);
	}
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    construct
 * Signature: (JJ[JILjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_construct(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jlongArray valuesPtr, jint argc, jobject result) {

	JNI_LONG_ARRAY_CONVERT(argv, valuesPtr, argc, JSValueRef);

	JSValueRef value = JavaScriptValueConstruct(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), static_cast<unsigned int>(argc), argv);

	JNI_CHECK_EXCEPTION(env)

	if (result) {
		JNI_CALL_VOID_METHOD(env, result, JavaScriptValueReset, reinterpret_cast<jlong>(value), true, true);
	}
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    defineProperty
 * Signature: (JJLjava/lang/String;JLjava/lang/Object;Ljava/lang/Object;ZZZLjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_defineProperty(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr, jlong value, jobject getter, jobject setter, jboolean writable, jboolean enumerable, jboolean configurable, jobject context) {

	if (value) {
		JNI_STRING_CREATE(propertyStr, property);
		JavaScriptValueDefineProperty(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, nullptr, nullptr, reinterpret_cast<JSValueRef>(value), writable, configurable, enumerable);
		JNI_STRING_DELETE(propertyStr, property);
		return;
	}

	JSObjectRef get = nullptr;
	JSObjectRef set = nullptr;

	if (getter) get = JavaScriptGetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), getter, nullptr, context)->function;
	if (setter) set = JavaScriptSetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), setter, nullptr, context)->function;

	JNI_STRING_CREATE(propertyStr, property);
	JavaScriptValueDefineProperty(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, get, set, nullptr, writable, enumerable, configurable);
	JNI_STRING_DELETE(propertyStr, property);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setProperty
 * Signature: (JJLjava/lang/String;J)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setProperty__JJLjava_lang_String_2J(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr, jlong value) {
	JNI_STRING_CREATE(propertyStr, property);
	JavaScriptValueSetProperty(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, value ? reinterpret_cast<JSValueRef>(value) : nullptr);
	JNI_STRING_DELETE(propertyStr, property);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setProperty
 * Signature: (JJLjava/lang/String;Ljava/lang/String;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setProperty__JJLjava_lang_String_2Ljava_lang_String_2(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr, jstring valueStr) {
	JNI_STRING_CREATE(valueStr, value);
	JNI_STRING_CREATE(propertyStr, property);
	JavaScriptValueSetPropertyWithString(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, value);
	JNI_STRING_DELETE(propertyStr, property);
	JNI_STRING_DELETE(valueStr, value);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setProperty
 * Signature: (JJLjava/lang/String;D)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setProperty__JJLjava_lang_String_2D(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr, jdouble value) {
	JNI_STRING_CREATE(propertyStr, property);
	JavaScriptValueSetPropertyWithNumber(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, value);
	JNI_STRING_DELETE(propertyStr, property);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setProperty
 * Signature: (JJLjava/lang/String;Z)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setProperty__JJLjava_lang_String_2Z(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr, jboolean value) {
	JNI_STRING_CREATE(propertyStr, property);
	JavaScriptValueSetPropertyWithBoolean(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property, value);
	JNI_STRING_DELETE(propertyStr, property);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    getProperty
 * Signature: (JJLjava/lang/String;)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_getProperty(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jstring propertyStr) {
	JNI_STRING_CREATE(propertyStr, property);
	JSValueRef result = JavaScriptValueGetProperty(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), property);
	JNI_STRING_DELETE(propertyStr, property);
	return reinterpret_cast<jlong>(result);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setPropertyAtIndex
 * Signature: (JJIJ)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setPropertyAtIndex__JJIJ(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jint index, jlong value) {
	JavaScriptValueSetPropertyAtIndex(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (unsigned int) index, reinterpret_cast<JSValueRef>(value));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setPropertyAtIndex
 * Signature: (JJILjava/lang/String;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setPropertyAtIndex__JJILjava_lang_String_2(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jint index, jstring valueStr) {
	JNI_STRING_CREATE(valueStr, value);
	JavaScriptValueSetPropertyAtIndexWithString(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (unsigned int) index, value);
	JNI_STRING_DELETE(valueStr, value);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setPropertyAtIndex
 * Signature: (JJID)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setPropertyAtIndex__JJID(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jint index, jdouble value) {
	JavaScriptValueSetPropertyAtIndexWithNumber(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (unsigned int) index, value);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setPropertyAtIndex
 * Signature: (JJIZ)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setPropertyAtIndex__JJIZ(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jint index, jboolean value) {
	JavaScriptValueSetPropertyAtIndexWithBoolean(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (unsigned int) index, value);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    getPropertyAtIndex
 * Signature: (JJI)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_getPropertyAtIndex(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jint index) {
	return reinterpret_cast<jlong>(JavaScriptValueGetPropertyAtIndex(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (unsigned int) index));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setPropertyWithSymbol
 * Signature: (JJJJ)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setPropertyWithSymbol(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jlong symbolPtr, jlong propertyValuePtr) {
	JavaScriptValueSetPropertyWithSymbol(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), reinterpret_cast<JSValueRef>(symbolPtr), reinterpret_cast<JSValueRef>(propertyValuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    getPropertyWithSymbol
 * Signature: (JJJ)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_getPropertyWithSymbol(JNIEnv* emv, jclass, jlong contextPtr, jlong valuePtr, jlong symbolPtr) {
	return reinterpret_cast<jlong>(JavaScriptValueGetPropertyWithSymbol(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), reinterpret_cast<JSValueRef>(symbolPtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    forEach
 * Signature: (JJLjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_forEach(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jobject handler) {
	auto wrapper = JavaScriptValueForEachWrapperCreate(env, handler);
	JavaScriptValueForEach(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr), &JavaScriptValueForEachCallback, wrapper);
	JavaScriptValueForEachWrapperDelete(env, wrapper);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    forOwn
 * Signature: (JJLjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_forOwn(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jobject handler) {
	auto wrapper = JavaScriptValueForOwnWrapperCreate(env, handler);
	JavaScriptValueForOwn(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr), &JavaScriptValueForOwnCallback, wrapper);
	JavaScriptValueForOwnWrapperDelete(env, wrapper);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setPrototype
 * Signature: (JJJ)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setPrototype(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jlong prototypePtr) {
	JavaScriptValueSetPrototype(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), (JSValueRef) prototypePtr);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    getPrototype
 * Signature: (JJ)J
 */
jlong Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_getPrototype(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return reinterpret_cast<jlong>(JavaScriptValueGetPrototype(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setAttribute
 * Signature: (JJILjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setAttribute__JJILjava_lang_Object_2(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jint key, jobject value) {
	JavaScriptValueSetAttribute(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), static_cast<long long>(key), value ? env->NewGlobalRef(value) : nullptr);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setAttribute
 * Signature: (JILjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setAttribute__JILjava_lang_Object_2(JNIEnv* env, jclass, jlong valuePtr, jint key, jobject value) {
	JavaScriptValueDataSetAttribute(reinterpret_cast<JavaScriptValueDataRef>(valuePtr), static_cast<long long>(key), value ? env->NewGlobalRef(value) : nullptr);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    getAttribute
 * Signature: (JJI)Ljava/lang/Object;
 */
jobject Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_getAttribute__JJI(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jint key) {
	return reinterpret_cast<jobject>(JavaScriptValueGetAttribute(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), static_cast<long long>(key)));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    getAttribute
 * Signature: (JI)Ljava/lang/Object;
 */
jobject Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_getAttribute__JI(JNIEnv* env, jclass, jlong valuePtr, jint key) {
	return reinterpret_cast<jobject>(JavaScriptValueDataGetAttribute(reinterpret_cast<JavaScriptValueDataRef>(valuePtr), static_cast<long long>(key)));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    delAttribute
 * Signature: (JJI)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_delAttribute__JJI(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jint key) {
	env->DeleteGlobalRef(reinterpret_cast<jobject>(JavaScriptValueGetAttribute(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), static_cast<long long>(key))));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    delAttribute
 * Signature: (JI)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_delAttribute__JI(JNIEnv* env, jclass, jlong valuePtr, jint key) {
	env->DeleteGlobalRef(reinterpret_cast<jobject>(JavaScriptValueDataGetAttribute(reinterpret_cast<JavaScriptValueDataRef>(valuePtr), static_cast<long long>(key))));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setAssociatedObject
 * Signature: (JJLjava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setAssociatedObject(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jobject object) {
	JavaScriptValueSetAssociatedObject(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), object ? env->NewGlobalRef(object) : nullptr);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    getAssociatedObject
 * Signature: (JJ)Ljava/lang/Object;
 */
jobject Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_getAssociatedObject__JJ(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return reinterpret_cast<jobject>(JavaScriptValueGetAssociatedObject(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    getAssociatedObject
 * Signature: (J)Ljava/lang/Object;
 */
jobject Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_getAssociatedObject__J(JNIEnv* env, jclass, jlong valuePtr) {
	return reinterpret_cast<jobject>(JavaScriptValueDataGetAssociatedObject(reinterpret_cast<JavaScriptValueDataRef>(valuePtr)));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    delAssociatedObject
 * Signature: (JJ)V
 */
JNIEXPORT void JNICALL Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_delAssociatedObject(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	env->DeleteGlobalRef(reinterpret_cast<jobject>(JavaScriptValueGetAssociatedObject(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr))));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    setFinalizeHandler
 * Signature: (JJLjava/lang/Object;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_setFinalizeHandler(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jobject handler, jobject context) {
	JavaScriptFinalizeWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(valuePtr), handler, context);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    equals
 * Signature: (JJJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_equals__JJJ(JNIEnv* env, jclass, jlong contextPtr, jlong value1Ptr, jlong value2Ptr) {
	return (jboolean) JavaScriptValueEquals(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(value1Ptr), reinterpret_cast<JSValueRef>(value2Ptr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    equals
 * Signature: (JJLjava/lang/String;)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_equals__JJLjava_lang_String_2(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jstring valueStr) {
	JNI_STRING_CREATE(valueStr, value);
	bool result = JavaScriptValueEqualsString(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr), value);
	JNI_STRING_DELETE(valueStr, value);
	return (jboolean) result;
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    equals
 * Signature: (JJD)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_equals__JJD(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jdouble value) {
	return (jboolean) JavaScriptValueEqualsNumber(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr), value);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    equals
 * Signature: (JJZ)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_equals__JJZ(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr, jboolean value) {
	return (jboolean) JavaScriptValueEqualsBoolean(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr), value);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    isString
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_isString(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) JavaScriptValueIsString(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    isNumber
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_isNumber(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) JavaScriptValueIsNumber(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    isBoolean
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_isBoolean(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) JavaScriptValueIsBoolean(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    isFunction
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_isFunction(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) JavaScriptValueIsFunction(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    isObject
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_isObject(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) JavaScriptValueIsObject(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    isArray
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_isArray(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) JavaScriptValueIsArray(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    isUndefined
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_isUndefined(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) JavaScriptValueIsUndefined(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    isNull
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_isNull(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) JavaScriptValueIsNull(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    getType
 * Signature: (JJ)I
 */
jint Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_getType(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return JavaScriptValueGetType(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    toString
 * Signature: (JJ)Ljava/lang/String;
 */
jstring Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_toString(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	auto ptr = JavaScriptValueToString(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
	auto str = env->NewStringUTF(ptr);
	delete ptr;
	return str;
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    toNumber
 * Signature: (JJ)D
 */
jdouble Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_toNumber(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jdouble) JavaScriptValueToNumber(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptValueExternal
 * Method:    toBoolean
 * Signature: (JJ)Z
 */
jboolean Java_ca_logaritm_dezel_core_external_JavaScriptValueExternal_toBoolean(JNIEnv* env, jclass, jlong contextPtr, jlong valuePtr) {
	return (jboolean) JavaScriptValueToBoolean(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSValueRef>(valuePtr));
}

#ifdef __cplusplus
}
#endif