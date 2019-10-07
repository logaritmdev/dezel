#ifndef AbsoluteLayoutResolver_h
#define AbsoluteLayoutResolver_h

#include <vector>

namespace Dezel {
	class Display;
	class DisplayNode;
}

namespace Dezel {
namespace Layout {

using std::vector;

class LayoutResolver;

class AbsoluteLayoutResolver {

private:

	DisplayNode* node;

	vector<DisplayNode*> nodes;

	bool hasInvalidSize(DisplayNode* node);
	bool hasInvalidOrigin(DisplayNode* node);

	double measureTop(DisplayNode* node);
	double measureLeft(DisplayNode* node);
	double measureRight(DisplayNode* node);
	double measureBottom(DisplayNode* node);
	double measureWidth(DisplayNode* node);
	double measureHeight(DisplayNode* node);

public:

	friend class LayoutResolver;

	AbsoluteLayoutResolver(DisplayNode* node);

	void append(DisplayNode* node) {
		this->nodes.push_back(node);
	}

	void measure(DisplayNode* node);
	void resolve();

};

}
} 

#endif
