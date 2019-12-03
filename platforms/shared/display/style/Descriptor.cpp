#include "Descriptor.h"
#include "Selector.h"
#include "Fragment.h"
#include "Importance.h"
#include "DisplayNode.h"

#include <iostream>

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Private API
//------------------------------------------------------------------------------

void
Descriptor::setParentSelector(Descriptor* descriptor)
{
	descriptor->selector->parent = this->selector;
}

void
Descriptor::setParentFragment(Descriptor* descriptor)
{
	descriptor->selector->head->parent = this->selector->tail;
}

bool
Descriptor::matchNode(DisplayNode* node, Importance& importance)
{
	return this->selector->getTail()->match(node, importance);
}

bool
Descriptor::matchPath(DisplayNode* node, Importance& importance)
{
	auto test = this->selector->getTail();

	if (test->hasStyle() ||
		test->hasState()) {

		test = test->getParent();

	} else {

		test = test->getParent();
		node = node->getParent();

	}

	if (test == nullptr) {
		return true;
	}

	while (node) {

		bool match = test->match(node, importance);

		if (match == false) {

			/*
			 * The selector fragment didn't match the current node. Before
			 * trying with the parent node, we must check whether the node is
			 * the root of an opaque node.
			 */

			if (node->isOpaque() ||
				node->isWindow()) {
				break;
			}

			/*
			 * Try the same selector fragment with the parent node.
			 */

			 node = node->getParent();

			 continue;
		}

		if (test->hasStyle() ||
			test->hasState()) {

			test = test->getParent();

		} else {

			test = test->getParent();
			node = node->getParent();

		}

		if (test == nullptr) {
			return true;
		}
	}

	return false;
}

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

void
Descriptor::addChildDescriptor(Descriptor* child)
{
	child->parent = this;
	this->setParentSelector(child);
	this->setParentFragment(child);
	this->childDescriptors.push_back(child);
}

void
Descriptor::addStyleDescriptor(Descriptor* style)
{
	this->addChildDescriptor(style);
	this->styleDescriptors.push_back(style);
}

void
Descriptor::addStateDescriptor(Descriptor* state)
{
	this->addChildDescriptor(state);
	this->stateDescriptors.push_back(state);
}

bool
Descriptor::match(DisplayNode* node, Importance& importance)
{
	return (
		this->matchNode(node, importance) &&
		this->matchPath(node, importance)
	);
}

string
Descriptor::toString(int depth) {

	string output;

	output.append(depth * 2, ' ');
	output.append(this->selector->toString());

	output.append(" ");
	output.append("{");
	output.append("\n");

	for (auto property : this->properties) {
		output.append(property->toString(depth + 1));
		output.append(";");
		output.append("\n");
	}

	for (auto child : this->childDescriptors) {
		output.append(child->toString(depth + 1));
	}

	output.append(depth * 2, ' ');
	output.append("}");
	output.append("\n");

	return output;
}

}
}
