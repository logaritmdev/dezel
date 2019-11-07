#include "Descriptor.h"
#include "Selector.h"
#include "Fragment.h"
#include "Specifier.h"
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
	style->parent = this;
	this->setParentSelector(style);
	this->setParentFragment(style);
	this->styleDescriptors.push_back(style);
}

void
Descriptor::addStateDescriptor(Descriptor* state)
{
	state->parent = this;
	this->setParentSelector(state);
	this->setParentFragment(state);
	this->stateDescriptors.push_back(state);
}

bool
Descriptor::match(DisplayNode* node, Specifier& weight)
{
	auto root = node;
	auto rule = this->selector->getTail();

	if (rule == nullptr) {
		return false;
	}

	while (rule && node) {

		if (rule->match(node, weight) == false) {

			/*
			 * The rule didn't match the root node, the original node
			 * given to this function. In this case, we know the whole
			 * selector won't match.
			 */

			if (node == root) {
				return false;
			}

			/*
			 * The fragment didn't match the current node. Before trying with
			 * the parent node, we must check whether the node is the root
			 * of an opaque node.
			 */

			if (node->isOpaque() ||
				node->isWindow()) {
				return false;
			}

			/*
			 * When a fragment does not match, we try the rule again with the
			 * parent node.
			 */

			 node = node->getParent();

			 if (node == nullptr) {
				return false;
			 }

			 continue;
		}

		/*
		 * The current rule is a style or state modifier thus not actual node
		 * in the selector but some kind of modifier of the parent or ancestor
		 * fragment. When this happens we need to go to the next parent rule
		 * without going to the parent node.
		 */

		if (rule->isStyle() ||
			rule->isState()) {

			rule = rule->getParent();

			if (rule == nullptr) {
				return true;
			}

			continue;
		}

		/*
		 * The fragment matched. We can try to match the next rule if any or
		 * look into the parent descriptor if necessary.
		 */

		rule = rule->getParent();
		node = node->getParent();

		if (rule == nullptr) {
			return true;
		}

		if (node == nullptr) {
			return false;
		}

		continue;
	}

	return true;
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

	for (auto style : this->styleDescriptors) {
		output.append(style->toString(depth + 1));
	}

	for (auto state : this->stateDescriptors) {
		output.append(state->toString(depth + 1));
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
