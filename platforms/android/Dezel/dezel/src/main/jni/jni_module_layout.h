#ifndef JNIModuleLayout_h
#define JNIModuleLayout_h

#include <jni.h>
#include "jni_init.h"

extern jclass LayoutClass;
extern jclass LayoutClass;
extern jclass SizeFClass;

extern jmethodID LayoutDispatchLayoutBeganEvent;
extern jmethodID LayoutDispatchLayoutEndedEvent;

extern jmethodID LayoutPrepareCallback;
extern jmethodID LayoutMeasureCallback;
extern jmethodID LayoutResolveSizeCallback;
extern jmethodID LayoutResolvePositionCallback;
extern jmethodID LayoutResolveMarginCallback;
extern jmethodID LayoutResolveBorderCallback;
extern jmethodID LayoutResolveInnerSizeCallback;
extern jmethodID LayoutResolveContentSizeCallback;
extern jmethodID LayoutResolvePaddingCallback;
extern jmethodID LayoutLayoutBeganCallback;
extern jmethodID LayoutLayoutEndedCallback;
extern jmethodID LayoutInvalidateCallback;

extern jmethodID SizeFGetWidth;
extern jmethodID SizeFGetHeight;

/**
 * Initializes JNI related variables.
 * @function JNI_OnLoad_layout
 * @since 0.1.0
 */
void JNI_OnLoad_layout(JNIEnv* env);

#endif