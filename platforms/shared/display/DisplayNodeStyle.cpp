#include "DisplayNodeStyle.h"
#include "DisplayNode.h"
#include "InvalidOperationException.h"

#include <string>
#include <sstream>

namespace Dezel {

using std::string;
using std::stringstream;

DisplayNodeStyle::DisplayNodeStyle(DisplayNode* node) : styleResolver(node)
{
	this->node = node;
}

void
DisplayNodeStyle::invalidate()
{
	if (this->invalid) {
		return;
	}

	this->invalid = true;
}

void
DisplayNodeStyle::invalidateStyle()
{
	if (this->invalidStyle == false) {
		this->invalidStyle = true;
		this->invalidate();
	}
}

void
DisplayNodeStyle::invalidateState()
{
	if (this->invalidState == false) {
		this->invalidState = true;
		this->invalidate();
	}
}

void
DisplayNodeStyle::setClass(string klass)
{
	if (this->classes.size()) {
		throw InvalidOperationException("A display node class cannot be redefined");
	}

	string token;
	stringstream stream(klass);

	while (getline(stream, token, ' ')) {
		this->classes.push_back(token);
	}

	this->invalidate();
}

void
DisplayNodeStyle::appendStyle(string style)
{
	this->styles.push_back(style);
	this->invalidateStyle();
}

void
DisplayNodeStyle::removeStyle(string style)
{
	auto it = find(
		this->styles.begin(),
		this->styles.end(),
		style
	);

	if (it == this->styles.end()) {
		return;
	}

	this->styles.erase(it);

	this->invalidateStyle();
}

void
DisplayNodeStyle::appendState(string state)
{
	this->states.push_back(state);
	this->invalidateState();
}

void
DisplayNodeStyle::removeState(string state)
{
	auto it = find(
		this->states.begin(),
		this->states.end(),
		state
	);

	if (it == this->states.end()) {
		return;
	}

	this->states.erase(it);

	this->invalidateState();
}

void
DisplayNodeStyle::resolve()
{
	if (this->invalid == false) {
		return;
	}


	this->styleResolver.resolve();

	this->node->didResolveSize();

	this->invalid = false;
}

}
