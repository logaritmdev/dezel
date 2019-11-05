#ifndef DisplayNode_h
#define DisplayNode_h

#include "DisplayBase.h"
#include "DisplayNodeAnchor.h"
#include "DisplayNodeSize.h"
#include "DisplayNodeOrigin.h"
#include "DisplayNodeMargin.h"
#include "DisplayNodeBorder.h"
#include "DisplayNodePadding.h"
#include "DisplayNodeContentSize.h"
#include "DisplayNodeContentOrigin.h"
#include "StyleResolver.h"
#include "LayoutResolver.h"
#include "RelativeLayoutResolver.h"
#include "AbsoluteLayoutResolver.h"

#include <float.h>
#include <string>
#include <vector>
#include <set>

namespace Dezel {

using std::string;
using std::vector;

using Style::StyleResolver;
using Layout::LayoutResolver;

typedef enum {
	kDisplayNodeFlagNone   = 0,
	kDisplayNodeFlagOpaque = 1 << 0,
	kDisplayNodeFlagWindow = 1 << 1
} DisplayNodeFlag;

inline DisplayNodeFlag operator|(DisplayNodeFlag a, DisplayNodeFlag b)
{
	return static_cast<DisplayNodeFlag>(static_cast<int>(a) | static_cast<int>(b));
}

class Display;

class DisplayNode {

private:

	DisplayNodeFlag flags = kDisplayNodeFlagNone;

	Display* display = nullptr;

	DisplayNode* parent = nullptr;
	DisplayNode* master = nullptr;
    vector<DisplayNode*> children;
    vector<DisplayNode*> elements;

	string name = "";
	string type = "";

	vector<string> classes;
	vector<string> styles;
	vector<string> states;

	StyleResolver style;

	bool visible = true;

	DisplayNodeAnchor anchorTop;
	DisplayNodeAnchor anchorLeft;

	DisplayNodeOrigin top;
	DisplayNodeOrigin left;
	DisplayNodeOrigin right;
	DisplayNodeOrigin bottom;

	DisplayNodeSize width;
	DisplayNodeSize height;

	DisplayNodeContentDirection contentDirection = kDisplayNodeContentDirectionVertical;
	DisplayNodeContentAlignment contentAlignment = kDisplayNodeContentAlignmentStart;
	DisplayNodeContentDisposition contentDisposition = kDisplayNodeContentDispositionStart;

	DisplayNodeContentOrigin contentTop;
	DisplayNodeContentOrigin contentLeft;
	DisplayNodeContentSize contentWidth;
	DisplayNodeContentSize contentHeight;

    DisplayNodeBorder borderTop;
    DisplayNodeBorder borderLeft;
    DisplayNodeBorder borderRight;
	DisplayNodeBorder borderBottom;

	DisplayNodeMargin marginTop;
	DisplayNodeMargin marginLeft;
	DisplayNodeMargin marginRight;
	DisplayNodeMargin marginBottom;

	DisplayNodePadding paddingTop;
	DisplayNodePadding paddingLeft;
	DisplayNodePadding paddingRight;
	DisplayNodePadding paddingBottom;

    double expandFactor = 0;
	double shrinkFactor = 0;

	bool invalid = false;
   	bool invalidSize = false;
	bool invalidOrigin = false;
	bool invalidMargin = false;
	bool invalidBorder = false;
	bool invalidInnerSize = false;
	bool invalidContentSize = false;
	bool invalidContentOrigin = false;
	bool invalidPadding = false;
	bool invalidLayout = false;
	bool invalidStyle = false;

	DisplayNodeMeasureCallback measureSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveOriginCallback = nullptr;
	DisplayNodeResolveCallback resolveInnerSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveContentSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveMarginCallback = nullptr;
	DisplayNodeResolveCallback resolveBorderCallback = nullptr;
	DisplayNodeResolveCallback resolvePaddingCallback = nullptr;
	DisplayNodeResolveCallback resolveLayoutCallback = nullptr;

	LayoutResolver layout;

	bool resolving = false;
	bool resolvedSize = false;
	bool resolvedOrigin = false;

	DisplayNode* resolvedParent = nullptr;
	DisplayNode* resolvedWindow = nullptr;

	bool inheritedWrappedContentWidth = false;
	bool inheritedWrappedContentHeight = false;

	bool measuredWidthChanged = false;
	bool measuredHeightChanged = false;
	bool measuredInnerWidthChanged = false;
	bool measuredInnerHeightChanged = false;
	bool measuredContentWidthChanged = false;
	bool measuredContentHeightChanged = false;

    double measuredTop = 0;
	double measuredLeft = 0;
	double measuredRight = 0;
	double measuredBottom = 0;

	double measuredWidth = 0;
	double measuredHeight = 0;
    double measuredInnerWidth = 0;
    double measuredInnerHeight = 0;
    double measuredContentTop = 0;
    double measuredContentLeft = 0;
	double measuredContentWidth = 0;
	double measuredContentHeight = 0;
    double measuredBorderTop = 0;
    double measuredBorderLeft = 0;
    double measuredBorderRight = 0;
    double measuredBorderBottom = 0;
	double measuredMarginTop = 0;
	double measuredMarginLeft = 0;
	double measuredMarginRight = 0;
	double measuredMarginBottom = 0;
	double measuredPaddingTop = 0;
	double measuredPaddingLeft = 0;
	double measuredPaddingRight = 0;
	double measuredPaddingBottom = 0;

	double lastMeasuredWidth = 0;
	double lastMeasuredHeight = 0;

	void appendElement(DisplayNode* node);
	void removeElement(DisplayNode* node);

protected:

	bool hasInvalidSize();
	bool hasInvalidOrigin();
	bool hasInvalidInnerSize();
	bool hasInvalidContentSize();
	bool hasInvalidMargin();
	bool hasInvalidBorder();
	bool hasInvalidPadding();
	bool hasInvalidLayout();

	void invalidate();
	void invalidateInnerSize();
	void invalidateContentSize();
	void invalidateContentOrigin();
	void invalidateMargin();
	void invalidateBorder();
	void invalidatePadding();
	void invalidateParent();
	void invalidateStyle();

	bool inheritsWrappedWidth();
	bool inheritsWrappedHeight();

	void resolveEntity();
	void resolveStyle();
	void resolveFrame();
	void resolveMargin();
	void resolveBorder();
	void resolveInnerSize();
	void resolveContentSize();
	void resolvePadding();
	void resolveLayout();

	void resolveWrapper(double width, double height);

	bool hasNewParent() {
		return this->resolvedParent != this->parent;
	}

	double measureAnchorTop();
	double measureAnchorLeft();
	double measureBorderTop();
	double measureBorderLeft();
	double measureBorderRight();
	double measureBorderBottom();
	double measureMarginTop();
	double measureMarginLeft();
	double measureMarginRight();
	double measureMarginBottom();
	double measurePaddingTop();
	double measurePaddingLeft();
	double measurePaddingRight();
	double measurePaddingBottom();
	double measureInnerWidth();
	double measureInnerHeight();
	double measureContentWidth();
	double measureContentHeight();

	void measure(DisplayNodeMeasuredSize* size, double w, double h, double minw, double maxw, double minh, double maxh);

	void didInvalidate();
	void didResolveSize();
	void didResolveOrigin();
	void didResolveInnerSize();
	void didResolveContentSize();
	void didResolveMargin();
	void didResolveBorder();
	void didResolvePadding();
	void didResolveLayout();
	void didResolveStyle();

public:

	friend class Display;
	friend class Layout::LayoutResolver;
	friend class Layout::RelativeLayoutResolver;
	friend class Layout::AbsoluteLayoutResolver;

	void *data = nullptr;

	DisplayNode();

	void setDisplay(Display* display) {
		this->display = display;
	}

	void setWindow() {
		this->flags = this->flags | kDisplayNodeFlagWindow;
	}

	void setOpaque() {
		this->flags = this->flags | kDisplayNodeFlagOpaque;
	}

	void setName(string name);
	void setType(string type);
	void appendStyle(string style);
	void removeStyle(string style);
	void appendState(string state);
	void removeState(string state);

	void setVisible(bool visible);

	void setAnchorTop(DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length);
	void setAnchorLeft(DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length);

	void setTop(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length);
	void setLeft(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length);
	void setRight(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length);
	void setBottom(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length);

	void setMinTop(double min);
	void setMaxTop(double max);
	void setMinLeft(double min);
	void setMaxLeft(double max);
	void setMinRight(double min);
	void setMaxRight(double max);
	void setMinBottom(double min);
	void setMaxBottom(double max);

	void setWidth(DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length);
	void setHeight(DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length);

	void setMinWidth(double min);
	void setMaxWidth(double max);
	void setMinHeight(double min);
	void setMaxHeight(double max);

	void setContentDirection(DisplayNodeContentDirection direction);
	void setContentAlignment(DisplayNodeContentAlignment alignment);
	void setContentDisposition(DisplayNodeContentDisposition placement);

	void setContentTop(DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length);
	void setContentLeft(DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length);
	void setContentWidth(DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length);
	void setContentHeight(DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length);

	void setExpandFactor(double factor);
	void setShrinkFactor(double factor);

	void setBorderTop(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length);
	void setBorderLeft(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length);
	void setBorderRight(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length);
	void setBorderBottom(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length);

	void setMarginTop(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length);
	void setMarginLeft(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length);
	void setMarginRight(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length);
	void setMarginBottom(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length);

	void setMinMarginTop(double min);
	void setMaxMarginTop(double max);
	void setMinMarginLeft(double min);
	void setMaxMarginLeft(double max);
	void setMinMarginRight(double min);
	void setMaxMarginRight(double max);
	void setMinMarginBottom(double min);
	void setMaxMarginBottom(double max);

	void setPaddingTop(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length);
	void setPaddingLeft(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length);
	void setPaddingRight(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length);
	void setPaddingBottom(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length);

	void setMinPaddingTop(double min);
	void setMaxPaddingTop(double max);
	void setMinPaddingLeft(double min);
	void setMaxPaddingLeft(double max);
	void setMinPaddingRight(double min);
	void setMaxPaddingRight(double max);
	void setMinPaddingBottom(double min);
	void setMaxPaddingBottom(double max);

	void setMeasureSizeCallback(DisplayNodeMeasureCallback callback) {
		this->measureSizeCallback = callback;
	}

	void setResolveSizeCallback(DisplayNodeResolveCallback callback) {
		this->resolveSizeCallback = callback;
	}

	void setResolveOriginCallback(DisplayNodeResolveCallback callback) {
		this->resolveOriginCallback = callback;
	}

	void setResolveInnerSizeCallback(DisplayNodeResolveCallback callback) {
		this->resolveInnerSizeCallback = callback;
	}

	void setResolveContentSizeCallback(DisplayNodeResolveCallback callback) {
		this->resolveContentSizeCallback = callback;
	}

	void setResolveMarginCallback(DisplayNodeResolveCallback callback) {
		this->resolveMarginCallback = callback;
	}

	void setResolveBorderCallback(DisplayNodeResolveCallback callback) {
		this->resolveBorderCallback = callback;
	}

	void setResolvePaddingCallback(DisplayNodeResolveCallback callback) {
		this->resolvePaddingCallback = callback;
	}

	void setResolveLayoutCallback(DisplayNodeResolveCallback callback) {
		this->resolveLayoutCallback = callback;
	}

	double getMeasuredTop() const {
		return this->measuredTop;
	}

	double getMeasuredLeft() const {
		return this->measuredLeft;
	}

	double getMeasuredRight() const {
		return this->measuredRight;
	}

	double getMeasuredBottom() const {
		return this->measuredBottom;
	}

	double getMeasuredWidth() const {
		return this->measuredWidth;
	}

	double getMeasuredHeight() const {
		return this->measuredHeight;
	}

	double getMeasuredInnerWidth() const {
		return this->measuredInnerWidth;
	}

	double getMeasuredInnerHeight() const {
		return this->measuredInnerHeight;
	}

	double getMeasuredContentWidth() const {
		return this->measuredContentWidth;
	}

	double getMeasuredContentHeight() const {
		return this->measuredContentHeight;
	}

	double getMeasuredMarginTop() const {
		return this->measuredMarginTop;
	}

	double getMeasuredBorderTop() const {
		return this->measuredBorderTop;
	}

	double getMeasuredBorderLeft() const {
		return this->measuredBorderLeft;
	}

	double getMeasuredBorderRight() const {
		return this->measuredBorderRight;
	}

	double getMeasuredBorderBottom() const {
		return this->measuredBorderBottom;
	}

	double getMeasuredMarginLeft() const {
		return this->measuredMarginLeft;
	}

	double getMeasuredMarginRight() const {
		return this->measuredMarginRight;
	}

	double getMeasuredMarginBottom() const {
		return this->measuredMarginBottom;
	}

	double getMeasuredPaddingTop() const {
		return this->measuredPaddingTop;
	}

	double getMeasuredPaddingLeft() const {
		return this->measuredPaddingLeft;
	}

	double getMeasuredPaddingRight() const {
		return this->measuredPaddingRight;
	}

	double getMeasuredPaddingBottom() const {
		return this->measuredPaddingBottom;
	}

	void appendChild(DisplayNode* child);
	void insertChild(DisplayNode* child, int index);
	void removeChild(DisplayNode* child);

	bool isOpaque() const {
		return this->flags & kDisplayNodeFlagOpaque;
	}

	bool isWindow() const {
		return this->flags & kDisplayNodeFlagWindow;
	}

	bool isRelative() const {
		return (
			this->top.type == kDisplayNodeOriginTypeAuto &&
			this->left.type == kDisplayNodeOriginTypeAuto &&
			this->right.type == kDisplayNodeOriginTypeAuto &&
			this->bottom.type == kDisplayNodeOriginTypeAuto
		);
	}

	bool isAbsolute() const {
		return (
			this->top.type == kDisplayNodeOriginTypeLength ||
			this->left.type == kDisplayNodeOriginTypeLength ||
			this->right.type == kDisplayNodeOriginTypeLength ||
			this->bottom.type == kDisplayNodeOriginTypeLength
		);
	}

	bool isFillingParentWidth() const {
		return this->width.type == kDisplayNodeSizeTypeFill;
	}

	bool isFillingParentHeight() const {
		return this->height.type == kDisplayNodeSizeTypeFill;
	}

	bool isWrappingContentWidth() const {
		return this->width.type == kDisplayNodeSizeTypeWrap;
	}

	bool isWrappingContentHeight() const {
		return this->height.type == kDisplayNodeSizeTypeWrap;
	}

	void invalidateSize();
	void invalidateOrigin();
	void invalidateLayout();

	void measure();
	void resolve();

};

} 

#endif
