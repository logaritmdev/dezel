#ifndef DLContextPrivate_h
#define DLContextPrivate_h

#include "DLContext.h"

/**
 * @struct DLExceptionHandlerData
 * @since 0.1.0
 */
struct DLExceptionHandlerData {
	DLExceptionHandler handler;
};

/**
 * @typedef DLExceptionHandlerDataRef
 * @since 0.1.0
 */
typedef struct DLExceptionHandlerData* DLExceptionHandlerDataRef;

#endif
