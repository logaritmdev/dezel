#include <JavaScriptContext.h>
#include <JavaScriptValue.h>
#include "wrappers/JavaScriptClassFunctionWrapper.h"
#include "wrappers/JavaScriptClassGetterWrapper.h"
#include "wrappers/JavaScriptClassSetterWrapper.h"
#include "ca_logaritm_dezel_core_external_JavaScriptObjectBuilderExternal.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptObjectBuilderExternal
 * Method:    createFunction
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptObjectBuilderExternal_createFunction(JNIEnv* env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	JavaScriptValueDefineFunction(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassFunctionWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptObjectBuilderExternal
 * Method:    createGetter
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptObjectBuilderExternal_createGetter(JNIEnv* env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	JavaScriptValueDefinePropertyGetter(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassGetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

/*
 * Class:     ca_logaritm_dezel_core_external_JavaScriptObjectBuilderExternal
 * Method:    createSetter
 * Signature: (JJLjava/lang/String;Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)V
 */
void Java_ca_logaritm_dezel_core_external_JavaScriptObjectBuilderExternal_createSetter(JNIEnv* env, jclass, jlong contextPtr, jlong objectPtr, jstring nameStr, jstring fqmnStr, jclass cls, jobject context) {
	JNI_STRING_CREATE(nameStr, name);
	JNI_STRING_CREATE(fqmnStr, fqmn);
	JavaScriptValueDefinePropertySetter(reinterpret_cast<JSContextRef>(contextPtr), reinterpret_cast<JSObjectRef>(objectPtr), name, JavaScriptClassSetterWrapperCreate(env, reinterpret_cast<JSContextRef>(contextPtr), name, fqmn, cls, context)->function);
	JNI_STRING_DELETE(nameStr, name);
	JNI_STRING_DELETE(fqmnStr, fqmn);
}

#ifdef __cplusplus
}
#endif