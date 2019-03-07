
#include "DLLayout.h"
#include "DLLayoutPrivate.h"
#include "DLLayoutNode.h"
#include "DLLayoutNodePrivate.h"
#include "DLAbsoluteLayout.h"
#include "DLRelativeLayout.h"

DLLayoutRef
DLLayoutCreate()
{
	return new OpaqueDLLayout;
}

void
DLLayoutDelete(DLLayoutRef layout)
{
	delete layout;
}

bool
DLLayoutIsInvalid(DLLayoutRef layout)
{
	return layout->invalid;
}

bool
DLLayoutIsResolving(DLLayoutRef layout)
{
	return layout->resolving;
}

void
DLLayoutSetRoot(DLLayoutRef layout, DLLayoutNodeRef root)
{
	layout->root = root;
	layout->root->root = true;
}

void
DLLayoutSetViewportWidth(DLLayoutRef layout, double width)
{
	if (layout->viewportWidth == width) {
		return;
	}

	layout->viewportWidth = width;
	layout->viewportWidthUpdated = true;

	if (layout->root) {
		DLLayoutNodeInvalidateLayout(layout->root);
	}
}

void
DLLayoutSetViewportHeight(DLLayoutRef layout, double height)
{
	if (layout->viewportHeight == height) {
		return;
	}

	layout->viewportHeight = height;
	layout->viewportHeightUpdated = true;

	if (layout->root) {
		DLLayoutNodeInvalidateLayout(layout->root);
	}
}

void
DLLayoutSetScale(DLLayoutRef layout, double scale)
{
	layout->scale = scale;
}

double
DLLayoutGetScale(DLLayoutRef layout)
{
	return layout->scale;
}

void
DLLayoutSetData(DLLayoutRef layout, void *data)
{
	layout->data = data;
}

void *
DLLayoutGetData(DLLayoutRef layout)
{
	return layout->data;
}

void
DLLayoutSetLayoutBeganCallback(DLLayoutRef layout, DLLayoutBeganCallback callback)
{
	layout->layoutBeganCallback = callback;
}

void
DLLayoutSetLayoutEndedCallback(DLLayoutRef layout, DLLayoutEndedCallback callback)
{
	layout->layoutEndedCallback = callback;
}
