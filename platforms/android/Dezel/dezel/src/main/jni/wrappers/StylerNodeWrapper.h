#ifndef StylerNodeWrapper_h
#define StylerNodeWrapper_h

#include <jni.h>
#include <DLStylerNode.h>

/**
 * @struct StylerNodeWrapper
 * @since 0.1.0
 */
struct StylerNodeWrapper {
	JNIEnv* env;
	jobject object;
};

/**
 * @typedef StylerNodeWrapperRef
 * @since 0.1.0
 */
typedef struct StylerNodeWrapper *StylerNodeWrapperRef;

/**
 * @function StylerNodeWrapperCreate
 * @since 0.1.0
 */
StylerNodeWrapperRef StylerNodeWrapperCreate(JNIEnv* env, jobject object, DLStylerNodeRef node);

/**
 * @function StylerNodeWrapperDelete
 * @since 0.6.0
 */
void StylerNodeWrapperDelete(JNIEnv* env, StylerNodeWrapperRef wrapper);

#endif