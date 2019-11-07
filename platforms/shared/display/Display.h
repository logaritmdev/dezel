#ifndef Display_h
#define Display_h

#include "DisplayBase.h"
#include "Stylesheet.h"

#include <string>
#include <queue>

using std::string;
using std::queue;

namespace Dezel {

namespace Layout {
	class LayoutResolver;
	class AbsoluteLayoutResolver;
	class RelativeLayoutResolver;
}

namespace Style {
	class StyleResolver;
	class Stylesheet;
}

using Layout::LayoutResolver;
using Layout::AbsoluteLayoutResolver;
using Layout::RelativeLayoutResolver;
using Style::StyleResolver;
using Style::Stylesheet;

class DisplayNode;
class DisplayNodeFrame;

class Display {

private:

	queue<DisplayNode*> walker;

	DisplayNode* window = nullptr;

	double scale = 1;
	double viewportWidth = 0;
	double viewportHeight = 0;

	bool viewportWidthChanged = false;
	bool viewportHeightChanged = false;

	Stylesheet* stylesheet = nullptr;

	bool invalid = false;
	bool updated = false;
	bool resolving = false;

	DisplayInvalidateCallback invalidateCallback = nullptr;
   	DisplayResolveCallback resolveCallback = nullptr;

	void didInvalidate();
	void didResolve();

public:

	friend class DisplayNode;
	friend class LayoutResolver;
	friend class AbsoluteLayoutResolver;
	friend class RelativeLayoutResolver;

	void *data = nullptr;

	void setWindow(DisplayNode* window);

	void setScale(double scale);
	void setViewportWidth(double viewportWidth);
	void setViewportHeight(double viewportHeight);

	void setStylesheet(Stylesheet* stylesheet);

	void setInvalidateCallback(DisplayInvalidateCallback callback) {
		this->invalidateCallback = callback;
	}

	void setResolveCallback(DisplayResolveCallback callback) {
		this->resolveCallback = callback;
	}

	double getScale() const {
		return this->scale;
	}

	double getViewportWidth() const {
		return this->viewportWidth;
	}

	double getViewportHeight() const {
		return this->viewportHeight;
	}

	Stylesheet* getStylesheet() const {
		return this->stylesheet;
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
