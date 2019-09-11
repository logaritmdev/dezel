#ifndef RelativeLayout_h
#define RelativeLayout_h

#include <vector>

namespace View {

using std::vector;

class Display;
class DisplayNode;
class Layout;
class RelativeLayout {

private:

	DisplayNode* node;

	double extentTop = 0;
	double extentLeft = 0;
	double extentRight = 0;
	double extentBottom = 0;

	bool hasInvalidSize(DisplayNode* node);
	bool hasInvalidOrigin(DisplayNode* node);

	double measureWidth(DisplayNode* node, double remaining);
	double measureHeight(DisplayNode* node, double remaining);

	double resolveAlignment(DisplayNode* node, double remaining);

	void expandNodesVertically(const vector<DisplayNode*> &nodes, double space, double weights);
	void expandNodesHorizontally(const vector<DisplayNode*> &nodes, double space, double weights);
	void shrinkNodesVertically(const vector<DisplayNode*> &nodes, double space, double weights);
	void shrinkNodesHorizontally(const vector<DisplayNode*> &nodes, double space, double weights);

public:

	friend class Layout;

	RelativeLayout(DisplayNode* node);

	void measure(DisplayNode* node, double &remainingW, double &remainingH, double &remainder);
	void resolve(DisplayNode* node, const vector<DisplayNode*> &nodes);

};

}

#endif
