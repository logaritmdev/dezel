#ifndef DisplayNodeWrapper_h
#define DisplayNodeWrapper_h

#include <jni.h>
#include "DisplayRef.h"
#include "DisplayNodeRef.h"

/**
 * @struct DisplayNodeWrapper
 * @since 0.7.0
 */
struct DisplayNodeWrapper {
	JNIEnv* env;
	jobject object;
};

/**
 * @typedef DisplayNodeWrapperRef
 * @since 0.7.0
 */
typedef struct DisplayNodeWrapper* DisplayNodeWrapperRef;

/**
 * @function DisplayNodeWrapperCreate
 * @since 0.7.0
 */
DisplayNodeWrapperRef DisplayNodeWrapperCreate(JNIEnv* env, jobject object, DisplayNodeRef node);

/**
 * @function DisplayNodeWrapperDelete
 * @since 0.7.0
 */
void DisplayNodeWrapperDelete(JNIEnv* env, DisplayNodeWrapperRef node);

#endif