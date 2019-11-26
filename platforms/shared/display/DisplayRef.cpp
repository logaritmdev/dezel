#include "DisplayRef.h"
#include "Display.h"
#include "Stylesheet.h"

using Dezel::DisplayNode;
using Dezel::Display;
using Dezel::Style::Stylesheet;

DisplayRef
DisplayCreate()
{
	return reinterpret_cast<DisplayRef>(new Display());
}

void
DisplayDelete(DisplayRef display)
{
	delete reinterpret_cast<Display*>(display);
}

void
DisplaySetStylesheet(DisplayRef display, StylesheetRef stylesheet)
{
	reinterpret_cast<Display*>(display)->setStylesheet(reinterpret_cast<Stylesheet*>(stylesheet));
}

void
DisplaySetWindow(DisplayRef display, DisplayNodeRef window)
{
	reinterpret_cast<Display*>(display)->setWindow(reinterpret_cast<DisplayNode*>(window));
}

void
DisplaySetScale(DisplayRef display, double scale)
{
	reinterpret_cast<Display*>(display)->setScale(scale);
}

void
DisplaySetViewportWidth(DisplayRef display, double viewportWidth)
{
	reinterpret_cast<Display*>(display)->setViewportWidth(viewportWidth);
}

void
DisplaySetViewportHeight(DisplayRef display, double viewportHeight)
{
	reinterpret_cast<Display*>(display)->setViewportHeight(viewportHeight);
}

void
DisplaySetPrepareCallback(DisplayRef display, DisplayCallback callback)
{
	reinterpret_cast<Display*>(display)->setPrepareCallback(callback);
}

void
DisplaySetResolveCallback(DisplayRef display, DisplayCallback callback)
{
	reinterpret_cast<Display*>(display)->setResolveCallback(callback);
}

void
DisplaySetData(DisplayRef display, void *data)
{
	reinterpret_cast<Display*>(display)->data = data;
}

void*
DisplayGetData(DisplayRef display)
{
	return reinterpret_cast<Display*>(display)->data;
}

bool
DisplayIsInvalid(DisplayRef display)
{
	return reinterpret_cast<Display*>(display)->isInvalid();
}

bool
DisplayIsResolving(DisplayRef display)
{
	return reinterpret_cast<Display*>(display)->isResolving();
}

void
DisplayResolve(DisplayRef display)
{
	return reinterpret_cast<Display*>(display)->resolve();
}
