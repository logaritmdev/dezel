#include "DisplayWalker.h"
#include "DisplayNode.h"

namespace Dezel {

DisplayWalker::DisplayWalker(DisplayNode* root)
{
	this->queue.push(root);
}

bool
DisplayWalker::next()
{
	if (this->queue.size() == 0) {
		return false;
	}

	this->consume();
	this->dequeue();

	auto children = this->node->getChildren();

	for (auto child : children) if (child->isVisible()) {
		this->enqueue(child);
	}

	return true;
}

}
