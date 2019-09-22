#ifndef Display_h
#define Display_h

#include "DisplayBase.h"

#include <string>

namespace View {

using std::string;

class DisplayNode;
class DisplayNodeFrame;

class Display {

private:

	DisplayNode* window = nullptr;

	double scale = 1;
	double viewportWidth = 0;
	double viewportHeight = 0;

	bool viewportWidthChanged = false;
	bool viewportHeightChanged = false;

	bool invalid = false;
	bool changed = false;
	bool resolving = false;

   	DisplayLayoutCallback layoutBeganCallback = nullptr;
    DisplayLayoutCallback layoutEndedCallback = nullptr;

	void layoutBegan();
	void layoutEnded();
	void resolveNode(DisplayNode* node);

public:

	void *data = nullptr;

	void setWindow(DisplayNode* window);
	void setScale(double scale);
	void setViewportWidth(double viewportWidth);
	void setViewportHeight(double viewportHeight);
	void setLayoutBeganCallback(DisplayLayoutCallback layoutBeganCallback);
	void setLayoutEndedCallback(DisplayLayoutCallback layoutEndedCallback);

	void loadStylesheet(string stylesheet);

	double getScale() {
		return this->scale;
	}

	double getViewportWidth() {
		return this->viewportWidth;
	}

	double getViewportHeight() {
		return this->viewportHeight;
	}

	bool hasViewportWidthChanged() {
		return this->viewportWidthChanged;
	}

	bool hasViewportHeightChanged() {
		return this->viewportHeightChanged;
	}

	bool isInvalid() {
		return this->invalid;
	}

	bool isResolving() {
		return this->resolving;
	}

	void invalidate();
	void resolve();
};

} 

#endif
