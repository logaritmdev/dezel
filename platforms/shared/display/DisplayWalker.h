#ifndef DisplayWalker_h
#define DisplayWalker_h

#include <queue>

namespace Dezel {

using std::queue;

class Display;
class DisplayNode;

class DisplayWalker {

private:

	queue<DisplayNode*> queue;

	DisplayNode* node;

	void consume() {
		this->node = this->queue.front();
	}

	void dequeue() {
		this->queue.pop();
	}

	void enqueue(DisplayNode* node) {
		this->queue.push(node);
	}

public:

	DisplayWalker(DisplayNode* root);

	DisplayNode* getNode() const {
		return this->node;
	}

	bool next();

};

}

#endif
