#include <JavaScriptContext.h>
#include <JavaScriptValue.h>
#include "wrappers/JavaScriptClassFunctionWrapper.h"
#include "wrappers/JavaScriptClassConstructorWrapper.h"
#include "wrappers/JavaScriptClassGetterWrapper.h"
#include "wrappers/JavaScriptClassSetterWrapper.h"
#include "wrappers/JavaScriptClassStaticFunctionWrapper.h"
#include "wrappers/JavaScriptClassStaticGetterWrapper.h"
#include "wrappers/JavaScriptClassStaticSetterWrapper.h"
#include "ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal
 * Method:    createConstructor
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal_createConstructor(JNIEnv* env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject ctx) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	JavaScriptValueDefineConstructor(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), JavaScriptClassConstructorWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, ctx)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal
 * Method:    createFunction
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal_createFunction(JNIEnv* env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	JavaScriptValueDefineFunction(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassFunctionWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal
 * Method:    createGetter
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal_createGetter(JNIEnv* env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	JavaScriptValueDefinePropertyGetter(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassGetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal
 * Method:    createSetter
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal_createSetter(JNIEnv* env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	JavaScriptValueDefinePropertySetter(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassSetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal
 * Method:    createStaticFunction
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal_createStaticFunction(JNIEnv* env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	JavaScriptValueDefineFunction(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassStaticFunctionWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal
 * Method:    createStaticGetter
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal_createStaticGetter(JNIEnv* env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	JavaScriptValueDefinePropertyGetter(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassStaticGetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal
 * Method:    createStaticSetter
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptClassBuilderExternal_createStaticSetter(JNIEnv* env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	JavaScriptValueDefinePropertySetter(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassStaticSetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

#ifdef __cplusplus
}
#endif