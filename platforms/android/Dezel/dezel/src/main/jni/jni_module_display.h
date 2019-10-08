#ifndef JNIModuleView_h
#define JNIModuleView_h

#include <jni.h>
#include "jni_init.h"

extern jclass DisplayClass;
extern jclass DisplayNodeClass;
extern jclass SizeFClass2;

extern jmethodID DisplayLayoutBeganMethod;
extern jmethodID DisplayLayoutEndedMethod;

extern jmethodID DisplayNodeInvalidateMethod;
extern jmethodID DisplayNodeMeasureSizeMethod;
extern jmethodID DisplayNodeResolveSizeMethod;
extern jmethodID DisplayNodeResolveOriginMethod;
extern jmethodID DisplayNodeResolveInnerSizeMethod;
extern jmethodID DisplayNodeResolveContentSizeMethod;
extern jmethodID DisplayNodeResolveMarginMethod;
extern jmethodID DisplayNodeResolveBorderMethod;
extern jmethodID DisplayNodeResolvePaddingMethod;
extern jmethodID DisplayNodeLayoutBeganMethod;
extern jmethodID DisplayNodeLayoutEndedMethod;

extern jmethodID SizeFGetWidthMethod;
extern jmethodID SizeFGetHeightMethod;

/**
 * Initializes JNI related variables.
 * @function JNIDisplayModule
 * @since 0.7.0
 */
void JNIDisplayModule(JNIEnv* env);

#endif