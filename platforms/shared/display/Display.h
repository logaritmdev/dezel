#ifndef Display_h
#define Display_h

#include "DisplayBase.h"

#include <string>

using std::string;

namespace Dezel {

namespace Layout {
	class LayoutResolver;
	class AbsoluteLayoutResolver;
	class RelativeLayoutResolver;
}

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

	friend class DisplayNode;
	friend class Layout::LayoutResolver;
	friend class Layout::AbsoluteLayoutResolver;
	friend class Layout::RelativeLayoutResolver;

	void *data = nullptr;

	void setWindow(DisplayNode* window);

	void setScale(double scale) {
		this->scale = scale;
	}

	void setViewportWidth(double viewportWidth);
	void setViewportHeight(double viewportHeight);

	void setInvalidateCallback(DisplayInvalidateCallback callback) {
		this->invalidateCallback = callback;
	}

	void setResolveCallback(DisplayResolveCallback callback) {
		this->resolveCallback = callback;
	}

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

	bool hasNewViewportWidth() const {
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
