#ifndef DLSTYLEWRAPPER_H
#define DLSTYLEWRAPPER_H

#include <jni.h>
#include <DLStylerNode.h>

/**
 * @struct StylerNodeWrapper
 * @since 0.1.0
 */
struct StylerNodeWrapper {
	JNIEnv *env;
	jobject object;
};

/**
 * @typedef StylerNodeWrapperRef
 * @since 0.1.0
 */
typedef struct StylerNodeWrapper *StylerNodeWrapperRef;

/**
 * @function StylesNodeWrapperCreate
 * @since 0.1.0
 */
StylerNodeWrapperRef StylesNodeWrapperCreate(JNIEnv *env, jobject object, DLStylerNodeRef node);

#endif