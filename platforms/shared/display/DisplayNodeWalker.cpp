#include "DisplayNodeWalker.h"
#include "DisplayNode.h"

namespace Dezel {

DisplayNodeWalker::DisplayNodeWalker(DisplayNode* root)
{
	this->queue.push(root);
}

bool
DisplayNodeWalker::next()
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
