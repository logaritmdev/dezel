#ifndef AbsoluteLayout_h
#define AbsoluteLayout_h

#include <vector>

namespace View {

using std::vector;

class Display;
class DisplayNode;
class Layout;
class AbsoluteLayout {

private:

	DisplayNode* node;

	bool hasInvalidSize(DisplayNode* node);
	bool hasInvalidOrigin(DisplayNode* node);

	double measureTop(DisplayNode* node);
	double measureLeft(DisplayNode* node);
	double measureRight(DisplayNode* node);
	double measureBottom(DisplayNode* node);
	double measureWidth(DisplayNode* node);
	double measureHeight(DisplayNode* node);

public:

	friend class Layout;

	AbsoluteLayout(DisplayNode* node);

	void measure(DisplayNode* node);
	void resolve(DisplayNode* node, const vector<DisplayNode*> &nodes);
};

} 

#endif
