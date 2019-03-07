#ifndef DLLayoutPrivate_h
#define DLLayoutPrivate_h

#include <math.h>
#include "DLLayoutNode.h"
#include "DLLayoutNodePrivate.h"

/**
 * Rounds a value to the right decimal based on the layout scale.
 * @define DL_ROUND
 */
#define DL_ROUND(SCALE, VALUE) \
	SCALE > 1 ? (round((VALUE) * SCALE) / SCALE) : round(VALUE);

/**
 * @struct OpaqueDLLayout
 * @since 0.1.0
 */
struct OpaqueDLLayout {

	DLLayoutNodeRef root = NULL;

	double scale = 1;
	double viewportWidth = 0;
	double viewportHeight = 0;

	bool viewportWidthUpdated = false;
	bool viewportHeightUpdated = false;

	bool invalid = false;
	bool changed = false;
	bool resolving = false;

	void *data = NULL;

   	DLLayoutBeganCallback layoutBeganCallback = NULL;
    DLLayoutEndedCallback layoutEndedCallback = NULL;
};

#endif
