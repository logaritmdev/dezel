#ifndef DLLayout_h
#define DLLayout_h

#include "DLLayoutNode.h"

#ifdef DEZEL_ANDROID
#include <android/log.h>
#define LOGV(...) __android_log_print(ANDROID_LOG_VERBOSE, "DEZEL", __VA_ARGS__)
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG  , "DEZEL", __VA_ARGS__)
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO   , "DEZEL", __VA_ARGS__)
#define LOGW(...) __android_log_print(ANDROID_LOG_WARN   , "DEZEL", __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR  , "DEZEL", __VA_ARGS__)
#else
#import <JavaScriptCore/JavaScriptCore.h>
#endif

/**
 * A reference to a layout object.
 * @typedef DLLayoutRef
 * @since 0.4.0
 */
typedef struct OpaqueDLLayout* DLLayoutRef;

/**
 * A reference to a node object.
 * @typedef DLLayoutNodeRef
 * @since 0.4.0
 */
typedef struct OpaqueDLLayoutNode* DLLayoutNodeRef;

/**
 * The callback when the global layout begins.
 * @typedef DLLayoutBeganCallback
 * @since 0.4.0
 */
typedef void (*DLLayoutBeganCallback)(DLLayoutRef layout);

/**
 * The callback layout when the global layout finishes.
 * @typedef DLLayoutEndedCallback
 * @since 0.4.0
 */
typedef void (*DLLayoutEndedCallback)(DLLayoutRef layout);

#if __cplusplus
extern "C" {
#endif

/**
 * Creates a new layout.
 * @function DLLayoutCreate
 * @since 0.4.0
 */
DLLayoutRef DLLayoutCreate();

/**
 * Releases a layout.
 * @function DLLayoutDelete
 * @since 0.4.0
 */
void DLLayoutDelete(DLLayoutRef layout);

/**
 * Returns whether the layout is invalid.
 * @function DLLayoutIsInvalid
 * @since 0.4.0
 */
bool DLLayoutIsInvalid(DLLayoutRef layout);

/**
 * Returns whether the layout is resolving.
 * @function DLLayoutIsResolving
 * @since 0.4.0
 */
bool DLLayoutIsResolving(DLLayoutRef layout);

/**
 * Assigns the layout's root node.
 * @function DLLayoutSetRoot
 * @since 0.4.0
 */
void DLLayoutSetRoot(DLLayoutRef layout, DLLayoutNodeRef window);

/**
 * Assigns the layout's viewport width.
 * @function DLLayoutSetViewportWidth
 * @since 0.4.0
 */
void DLLayoutSetViewportWidth(DLLayoutRef layout, double width);

/**
 * Assigns the layout's viewport height.
 * @function DLLayoutSetViewportWidth
 * @since 0.4.0
 */
void DLLayoutSetViewportHeight(DLLayoutRef layout, double height);

/**
 * Assigns the scale factor of the layout.
 * @function DLLayoutSetScale
 * @since 0.4.0
 */
void DLLayoutSetScale(DLLayoutRef layout, double scale);

/**
 * Returns the scale factor of the layout.
 * @function DLLayoutGetScale
 * @since 0.4.0
 */
double DLLayoutGetScale(DLLayoutRef layout);

/**
 * Assigns the layout's user data.
 * @function DLLayoutSetData
 * @since 0.4.0
 */
void DLLayoutSetData(DLLayoutRef layout, void *data);

/**
 * Returns the layout's user data.
 * @function DLLayoutGetData
 * @since 0.4.0
 */
void *DLLayoutGetData(DLLayoutRef layout);

/**
 * Assigns the callback that is called once the layout starts resolving.
 * @function DLLayoutSetLayoutBeganCallback
 * @since 0.4.0
 */
void DLLayoutSetLayoutBeganCallback(DLLayoutRef layout, DLLayoutBeganCallback callback);

/**
 * Assigns the callback that is called once the layout finishes resolving.
 * @function DLLayoutSetLayoutEndedCallback
 * @since 0.4.0
 */
void DLLayoutSetLayoutEndedCallback(DLLayoutRef layout, DLLayoutEndedCallback callback);

#if __cplusplus
}
#endif
#endif
