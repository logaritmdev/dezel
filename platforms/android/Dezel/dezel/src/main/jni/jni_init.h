#ifndef JNIINIT_H
#define JNIINIT_H

#include <jni.h>
#include <android/log.h>

#define LOGV(...) __android_log_print(ANDROID_LOG_VERBOSE, "DEZEL", __VA_ARGS__)
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG  , "DEZEL", __VA_ARGS__)
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO   , "DEZEL", __VA_ARGS__)
#define LOGW(...) __android_log_print(ANDROID_LOG_WARN   , "DEZEL", __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR  , "DEZEL", __VA_ARGS__)

/**
 * Checks and trigger an exception if needed.
 * @macro JNI_CHECK_EXCEPTION
 * @since 0.1.0
 */
#define JNI_CHECK_EXCEPTION(ENV) \
	if (ENV->ExceptionCheck()) ENV->ExceptionDescribe();

/**
 * Calls a JNI method.
 * @macro JNI_CALL_VOID_METHOD
 * @since 0.1.0
 */
#define JNI_CALL_VOID_METHOD(ENV, OBJECT, METHOD, ...) \
	ENV->CallVoidMethod(OBJECT, METHOD, ##__VA_ARGS__); \
	JNI_CHECK_EXCEPTION(ENV);

/**
 * Calls a JNI method.
 * @macro JNI_CALL_BOOL_METHOD
 * @since 0.3.0
 */
#define JNI_CALL_BOOL_METHOD(RES, ENV, OBJECT, METHOD, ...) \
	jboolean RES = ENV->CallBooleanMethod(OBJECT, METHOD, ##__VA_ARGS__); \
	JNI_CHECK_EXCEPTION(ENV);

/**
 * Calls a JNI method.
 * @macro JNI_CALL_LONG_METHOD
 * @since 0.1.0
 */
#define JNI_CALL_LONG_METHOD(RES, ENV, OBJECT, METHOD, ...) \
	jlong RES = ENV->CallLongMethod(OBJECT, METHOD, ##__VA_ARGS__); \
	JNI_CHECK_EXCEPTION(ENV);

/**
 * Creates a long array filled with values
 * @macro JNI_LONG_ARRAY_CREATE
 * @since 0.1.0
 */
#define JNI_LONG_ARRAY_CREATE(ENV, DST, SRC, LEN) \
	jlongArray DST = ENV->NewLongArray(LEN); \
	ENV->SetLongArrayRegion(DST, 0, LEN, SRC);

/**
 * Releases a long array.
 * @macro JNI_LONG_ARRAY_DELETE
 * @since 0.1.0
 */
#define JNI_LONG_ARRAY_DELETE(ENV, DST) \
	ENV->DeleteLocalRef(DST);

/**
 * Converts a long array to an array of the specified type.
 * @macro JNI_LONG_ARRAY_CONVERT
 * @since 0.1.0
 */
#define JNI_LONG_ARRAY_CONVERT(DST, SRC, LEN, TYPE) \
	TYPE DST[LEN]; if (LEN) { \
		jlong *ARR = env->GetLongArrayElements(SRC, NULL); \
		for (int i = 0; i < LEN; i++) DST[i] = (TYPE) ARR[i]; \
		env->ReleaseLongArrayElements(SRC, ARR, 0); \
	}

/**
 * Creates a C string from a JNI string.
 * @macro JNI_STRING_CREATE
 * @since 0.1.0
 */
#define JNI_STRING_CREATE(SRC, DST) \
	const char *DST = env->GetStringUTFChars(SRC, NULL);

/**
 * Deletes a C string
 * @macro JNI_STRING_DELETE
 * @since 0.1.0
 */
#define JNI_STRING_DELETE(SRC, DST) \
	env->ReleaseStringUTFChars(SRC, DST);

/**
 * @function JNIGetClass
 * @since 0.1.0
 * @hidden
 */
jclass JNIGetClass(JNIEnv *env, const char *name);

/**
 * @function JNIGetField
 * @since 0.1.0
 * @hidden
 */
jfieldID JNIGetField(JNIEnv *env, jclass klass, const char *name, const char *sign);

/**
 * @function JNIGetMethod
 * @since 0.1.0
 * @hidden
 */
jmethodID JNIGetMethod(JNIEnv *env, jclass klass, const char *name, const char *sign);

#endif
