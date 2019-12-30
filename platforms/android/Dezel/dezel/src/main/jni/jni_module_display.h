#ifndef JNIModuleView_h
#define JNIModuleView_h

#include <jni.h>
#include "jni_init.h"

extern jclass SizeFClass2;
extern jclass DisplayClass;
extern jclass DisplayNodeClass;
extern jclass ParseErrorClass;

extern jmethodID DisplayPrepareMethod;
extern jmethodID DisplayResolveMethod;

extern jmethodID DisplayNodeInvalidateMethod;
extern jmethodID DisplayNodeResolveSizeMethod;
extern jmethodID DisplayNodeResolveOriginMethod;
extern jmethodID DisplayNodeResolveInnerSizeMethod;
extern jmethodID DisplayNodeResolveContentSizeMethod;
extern jmethodID DisplayNodeResolveMarginMethod;
extern jmethodID DisplayNodeResolveBorderMethod;
extern jmethodID DisplayNodeResolvePaddingMethod;
extern jmethodID DisplayNodePrepareLayoutMethod;
extern jmethodID DisplayNodeResolveLayoutMethod;
extern jmethodID DisplayNodeMeasureMethod;
extern jmethodID DisplayNodeUpdateMethod;

extern jmethodID SizeFGetWidthMethod;
extern jmethodID SizeFGetHeightMethod;

extern jmethodID ParseErrorConstructor;

/**
 * Initializes JNI related variables.
 * @function JNIDisplayModule
 * @since 0.7.0
 */
void JNIDisplayModule(JNIEnv* env);

#endif