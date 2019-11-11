#include "Display.h"
#include "DisplayNode.h"
#include "DisplayWalker.h"
#include "Parser.h"
#include "Stylesheet.h"
#include "Tokenizer.h"
#include "TokenizerStream.h"

#include <queue>
#include <string>
#include <iostream>

using std::queue;
using std::string;

namespace Dezel {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

void
Display::setWindow(DisplayNode* window) {
	this->window = window;
	this->window->setWindow();
	this->window->setOpaque();
	this->invalidate();
}

void
Display::setScale(double value)
{
	if (this->scale != value) {
		this->scale = value;
		this->invalidate();
	}
}

void
Display::setViewportWidth(double value)
{
	if (this->viewportWidth != value) {
		this->viewportWidth = value;
		this->viewportWidthChanged = true;
		this->invalidate();
	}
}

void
Display::setViewportHeight(double value)
{
	if (this->viewportHeight != value) {
		this->viewportHeight = value;
		this->viewportHeightChanged = true;
		this->invalidate();
	}
}

void
Display::setStylesheet(Stylesheet* stylesheet)
{
	if (this->stylesheet != stylesheet) {
		this->stylesheet = stylesheet;
		this->invalidate();
	}
}

void
Display::invalidate()
{
	this->invalid = true;
}

void
Display::resolve()
{
	if (this->window == nullptr) {
		return;
	}

	if (this->invalid == false) {
		return;
	}

	if (this->resolving) {
		return;
	}

	this->resolving = true;

	this->didPrepare();

	DisplayWalker walker(this->window);

	while (walker.next()) {
		walker.getNode()->resolve();
	}

	this->didResolve();

	this->resolving = false;

	this->viewportWidthChanged = false;
	this->viewportHeightChanged = false;

	this->invalid = false;
}

}
