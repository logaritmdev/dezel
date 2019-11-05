#ifndef Display_h
#define Display_h

#include "DisplayBase.h"

#include <string>

using std::string;

namespace Dezel {

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
	bool resolving = false;

	DisplayInvalidateCallback invalidateCallback = nullptr;
   	DisplayResolveCallback resolveCallback = nullptr;

	void didInvalidate();
	void didResolve();

public:

	void *data = nullptr;

	void setInvalidateCallback(DisplayInvalidateCallback callback) {
		this->invalidateCallback = callback;
	}

	void setResolveCallback(DisplayResolveCallback callback) {
		this->resolveCallback = callback;
	}

	void setWindow(DisplayNode* window);

	void setScale(double scale);
	void setViewportWidth(double viewportWidth);
	void setViewportHeight(double viewportHeight);

	void loadStylesheet(string stylesheet);

	double getScale() const {
		return this->scale;
	}

	double getViewportWidth() const {
		return this->viewportWidth;
	}

	double getViewportHeight() const {
		return this->viewportHeight;
	}

	bool hasViewportWidthChanged() const {
		return this->viewportWidthChanged;
	}

	bool hasViewportHeightChanged() const {
		return this->viewportHeightChanged;
	}

	bool isInvalid() const {
		return this->invalid;
	}

	bool isResolving() const {
		return this->resolving;
	}

	void invalidate();
	void resolve();
};

} 

#endif
