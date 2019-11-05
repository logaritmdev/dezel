#include "Display.h"
#include "DisplayNode.h"

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

void
Display::loadStylesheet(string input)
{
	Style::TokenizerStream stream(input);
	Style::Tokenizer tokenizer(stream);
	Style::Stylesheet* stylesheet = new Style::Stylesheet();
	Style::Parser parser(stylesheet, &tokenizer);
}

void
Display::setWindow(DisplayNode* window) {
	this->window = window;
	this->window->setWindow();
	this->window->setOpaque();
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
Display::invalidate()
{
	if (this->invalid == false) {
		this->invalid = true;
		this->didInvalidate();
	}
}

void
Display::resolve()
{
	if (this->invalid == false) {
		return;
	}

	if (this->resolving) {
		return;
	}

	this->resolving = true;

	queue<DisplayNode*> queue;

	queue.push(this->window);

	while (queue.size() > 0) {

		auto node = queue.front();

		node->resolve();

		queue.pop();

		for (auto child : node->children) {
			if (child->visible) {
				queue.push(child);
			}
		}
	}

	this->resolving = false;
	this->viewportWidthChanged = false;
	this->viewportHeightChanged = false;

	this->invalid = false;

	this->didResolve();
}

void
Display::didInvalidate()
{
	if (this->invalidateCallback) {
		this->invalidateCallback(reinterpret_cast<DisplayRef>(this));
	}
}

void
Display::didResolve()
{
	if (this->resolveCallback) {
		this->resolveCallback(reinterpret_cast<DisplayRef>(this));
	}
}

}
