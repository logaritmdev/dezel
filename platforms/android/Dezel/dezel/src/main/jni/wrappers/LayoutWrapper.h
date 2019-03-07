#ifndef CLASSIPRO_LAYOUTCONTEXTWRAPPER_H
#define CLASSIPRO_LAYOUTCONTEXTWRAPPER_H

#include <jni.h>
#include <DLLayout.h>

/**
 * @struct LayoutWrapper
 * @since 0.4.0
 */
struct LayoutWrapper {
	JNIEnv *env;
	jobject object;
};

/**
 * @typedef LayoutWrapperRef
 * @since 0.1.0
 */
typedef struct LayoutWrapper* LayoutWrapperRef;

/**
 * @function LayoutWrapperCreate
 * @since 0.4.0
 */
LayoutWrapperRef LayoutWrapperCreate(JNIEnv *env, jobject object, DLLayoutRef context);

#endif //CLASSIPRO_LAYOUTCONTEXTWRAPPER_H
