#ifndef DisplayRef_h
#define DisplayRef_h

#include "DisplayBase.h"

#if __cplusplus
extern "C" {
#endif

/**
 * Creates a display.
 * @function DisplayCreate;
 * @since 0.7.0
 */
DisplayRef DisplayCreate();

/**
 * Releases a display.
 * @function DisplayDelete
 * @since 0.7.0
 */
void DisplayDelete(DisplayRef display);

/**
 * Indicates whether the display is invalid.
 * @function DisplayIsInvalid
 * @since 0.7.0
 */
bool DisplayIsInvalid(DisplayRef display);

/**
 * Indicates whether the display is resolving.
 * @function DisplayGetData
 * @since 0.7.0
 */
bool DisplayIsResolving(DisplayRef display);

/**
 * Assigns the display's window.
 * @function DisplaySetWindow
 * @since 0.4.0
 */
void DisplaySetWindow(DisplayRef display, DisplayNodeRef window);

/**
 * Assigns the display's scale.
 * @function DisplaySetScale
 * @since 0.7.0
 */
void DisplaySetScale(DisplayRef display, double scale);

/**
 * Assigns the display's viewport width.
 * @function DisplaySetViewportWidth
 * @since 0.7.0
 */
void DisplaySetViewportWidth(DisplayRef display, double viewportWidth);

/**
 * Assigns the display's viewport height.
 * @function DisplaySetViewportHeight
 * @since 0.7.0
 */
void DisplaySetViewportHeight(DisplayRef display, double viewportHeight);

/**
 * Assigns the display's layout began callback.
 * @function DisplaySetLayoutBeganCallback
 * @since 0.7.0
 */
void DisplaySetInvalidateCallback(DisplayRef display, DisplayResolveCallback callback);

/**
 * Assigns the display's layout ended callback.
 * @function DisplaySetLayoutEndedCallback
 * @since 0.7.0
 */
void DisplaySetResolveCallback(DisplayRef display, DisplayResolveCallback callback);

/**
 * Assigns the display's data.
 * @function DisplaySetData
 * @since 0.7.0
 */
void DisplaySetData(DisplayRef display, void *data);

/**
 * Returns the display's data.
 * @function DisplayGetData
 * @since 0.7.0
 */
void *DisplayGetData(DisplayRef display);

#if __cplusplus
}
#endif

#endif
