#include "Display.h"
#include "DisplayNode.h"

#include <queue>
#include <iostream>

namespace View {

using std::cout;
using std::cerr;

void
Display::setWindow(DisplayNode* window)
{
	this->window = window;
	this->window->setType(kDisplayNodeTypeWindow);
}

void
Display::setScale(double value) {
	this->scale = value;
}

void
Display::setViewportWidth(double value) {

	if (this->viewportWidth == value) {
		return;
	}

	this->viewportWidth = value;
	this->viewportWidthChanged = true;

	this->invalidate();
}

void
Display::setViewportHeight(double value) {

	if (this->viewportHeight == value) {
		return;
	}

	this->viewportHeight = value;
	this->viewportHeightChanged = true;

	this->invalidate();
}

void
Display::setLayoutBeganCallback(DisplayLayoutCallback layoutBeganCallback) {
	this->layoutBeganCallback = layoutBeganCallback;
}

void
Display::setLayoutEndedCallback(DisplayLayoutCallback layoutEndedCallback) {
	this->layoutEndedCallback = layoutEndedCallback;
}

void
Display::layoutBegan() {
	if (this->layoutBeganCallback) {
		this->layoutBeganCallback(reinterpret_cast<DisplayRef>(this));
	}
}

void
Display::layoutEnded() {
	if (this->layoutEndedCallback) {
		this->layoutEndedCallback(reinterpret_cast<DisplayRef>(this));
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
	if (this->resolving) {
		return;
	}

	this->resolving = true;

	if (this->invalid) {
		this->resolveNode(this->window);
	}

	this->resolving = false;
}

void
Display::resolveNode(DisplayNode* node)
{
	if (node->visible == false) {
		return;
	}

	node->resolveNode();

	for (auto child : node->children) {
		this->resolveNode(child);
	}
}

}
