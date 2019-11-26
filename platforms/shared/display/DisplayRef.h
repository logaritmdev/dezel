#ifndef DisplayRef_h
#define DisplayRef_h

#include "DisplayBase.h"

#if __cplusplus
extern "C" {
#endif

/**
 * @function DisplayCreate
 * @since 0.7.0
 * @hidden
 */
DisplayRef DisplayCreate();

/**
 * @function DisplayDelete
 * @since 0.7.0
 * @hidden
 */
void DisplayDelete(DisplayRef display);

/**
 * @function DisplaySetStylesheet
 * @since 0.7.0
 * @hidden
 */
void DisplaySetStylesheet(DisplayRef display, StylesheetRef stylesheet);

/**
 * @function DisplaySetWindow
 * @since 0.7.0
 * @hidden
 */
void DisplaySetWindow(DisplayRef display, DisplayNodeRef window);

/**
 * @function DisplaySetScale
 * @since 0.7.0
 * @hidden
 */
void DisplaySetScale(DisplayRef display, double scale);

/**
 * @function DisplaySetViewportWidth
 * @since 0.7.0
 * @hidden
 */
void DisplaySetViewportWidth(DisplayRef display, double viewportWidth);

/**
 * @function DisplaySetViewportHeight
 * @since 0.7.0
 * @hidden
 */
void DisplaySetViewportHeight(DisplayRef display, double viewportHeight);

/**
 * @function DisplaySetPrepareCallback
 * @since 0.7.0
 * @hidden
 */
void DisplaySetPrepareCallback(DisplayRef display, DisplayCallback callback);

/**
 * @function DisplaySetResolveCallback
 * @since 0.7.0
 * @hidden
 */
void DisplaySetResolveCallback(DisplayRef display, DisplayCallback callback);

/**
 * @function DisplaySetData
 * @since 0.7.0
 * @hidden
 */
void DisplaySetData(DisplayRef display, void *data);

/**
 * @function DisplayGetData
 * @since 0.7.0
 * @hidden
 */
void* DisplayGetData(DisplayRef display);

/**
 * @function DisplayIsInvalid
 * @since 0.7.0
 * @hidden
 */
bool DisplayIsInvalid(DisplayRef display);

/**
 * @function DisplayGetData
 * @since 0.7.0
 * @hidden
 */
bool DisplayIsResolving(DisplayRef display);

/**
 * @function DisplayResolve
 * @since 0.7.0
 * @hidden
 */
void DisplayResolve(DisplayRef display);

#if __cplusplus
}
#endif

#endif
