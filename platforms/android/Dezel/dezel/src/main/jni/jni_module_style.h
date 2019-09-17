#ifndef JNIModuleStyle_h
#define JNIModuleStyle_h

#include <jni.h>
#include "jni_init.h"

extern jclass StyleClass;

extern jmethodID StyleApplyCallback;
extern jmethodID StyleFetchCallback;
extern jmethodID StyleInvalidateCallback;

/**
 * Initializes JNI related variables.
 * @function JNI_OnLoad_style
 * @since 0.1.0
 */
void JNI_OnLoad_style(JNIEnv* env);

#endif
