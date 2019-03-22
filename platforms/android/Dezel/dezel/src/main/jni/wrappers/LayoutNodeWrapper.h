#ifndef DLLAYOUTWRAPPER_H
#define DLLAYOUTWRAPPER_H

#include <jni.h>
#include <DLLayoutNode.h>

/**
 * @struct LayoutNodeWrapper
 * @since 0.1.0
 */
struct LayoutNodeWrapper {
	JNIEnv *env;
	jobject object;
};

/**
 * @typedef LayoutNodeWrapperRef
 * @since 0.1.0
 */
typedef struct LayoutNodeWrapper *LayoutNodeWrapperRef;

/**
 * @function JavaScriptGetterWrapperCreate
 * @since 0.1.0
 */
LayoutNodeWrapperRef LayoutNodeWrapperCreate(JNIEnv *env, jobject object, DLLayoutNodeRef node);

/**
 * @function LayoutNodeWrapperDelete
 * @since 0.6.0
 */
void LayoutNodeWrapperDelete(JNIEnv *env, LayoutNodeWrapperRef node);

#endif