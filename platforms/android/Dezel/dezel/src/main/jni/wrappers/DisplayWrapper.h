#ifndef DisplayWrapper_h
#define DisplayWrapper_h

#include <jni.h>
#include "DisplayRef.h"
#include "DisplayNodeRef.h"

/**
 * @struct DisplayWrapper
 * @since 0.7.0
 */
struct DisplayWrapper {
	JNIEnv* env;
	jobject object;
};

/**
 * @typedef DisplayWrapperRef
 * @since 0.7.0
 */
typedef struct DisplayWrapper* DisplayWrapperRef;

/**
 * @function DisplayWrapperCreate
 * @since 0.7.0
 */
DisplayWrapperRef DisplayWrapperCreate(JNIEnv* env, jobject object, DisplayRef context);

/**
 * @function DisplayWrapperDelete
 * @since 0.7.0
 */
void DisplayWrapperDelete(JNIEnv* env, DisplayWrapperRef wrapper);

#endif
