#include <DLContext.h>
#include <DLValue.h>
#include "wrappers/JavaScriptClassFunctionWrapper.h"
#include "wrappers/JavaScriptClassConstructorWrapper.h"
#include "wrappers/JavaScriptClassGetterWrapper.h"
#include "wrappers/JavaScriptClassSetterWrapper.h"
#include "ca_logaritm_dezel_core_JavaScriptClassBuilderExternal.h"

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptClassBuilderExternal
 * Method:    createConstructor
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptClassBuilderExternal_createConstructor(JNIEnv *env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject ctx) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	DLValueDefineConstructor(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), JavaScriptClassConstructorWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, ctx)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptClassBuilderExternal
 * Method:    createFunction
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptClassBuilderExternal_createFunction(JNIEnv *env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	DLValueDefineFunction(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassFunctionWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptClassBuilderExternal
 * Method:    createGetter
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptClassBuilderExternal_createGetter(JNIEnv *env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	DLValueDefinePropertyGetter(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassGetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

/*
 * Class:     ca_logaritm_dezel_core_JavaScriptClassBuilderExternal
 * Method:    createSetter
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_JavaScriptClassBuilderExternal_createSetter(JNIEnv *env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	DLValueDefinePropertySetter(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassSetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}