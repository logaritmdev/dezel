#ifndef DisplayNodeStyle_h
#define DisplayNodeStyle_h

#include "DisplayBase.h"
#include "StyleResolver.h"

#include <string>
#include <vector>

namespace Dezel {

using std::string;
using std::vector;

using Style::StyleResolver;

class DisplayNode;

class DisplayNodeStyle {

private:

	DisplayNode* node;

	vector<string> classes;
	vector<string> styles;
	vector<string> states;

	bool invalid = false;
	bool invalidStyle = false;
	bool invalidState = false;

	StyleResolver styleResolver;

	void invalidate();
	void invalidateStyle();
	void invalidateState();

public:

	DisplayNodeStyle(DisplayNode* node);

	void setClass(string klass);
	void appendStyle(string style);
	void removeStyle(string style);
	void appendState(string state);
	void removeState(string state);

	void resolve();

};

}

#endif
