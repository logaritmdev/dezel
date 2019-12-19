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
#include "LayoutResolver.h"
#include "RelativeLayoutResolver.h"
#include "AbsoluteLayoutResolver.h"
#include "PropertyList.h"
#include "Property.h"
#include "Match.h"

#include <iostream>
#include <float.h>
#include <string>
#include <vector>
#include <set>

namespace Dezel {

namespace Style {
	class Descriptor;
	class Selector;
	class Fragment;
	class Property;
	class PropertyList;
}

using std::string;
using std::vector;

using Layout::LayoutResolver;
using Layout::AbsoluteLayoutResolver;
using Layout::RelativeLayoutResolver;

using Style::Descriptor;
using Style::Selector;
using Style::Fragment;
using Style::PropertyList;
using Style::Property;
using Style::Match;

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

	DisplayNode* window = nullptr;
	DisplayNode* parent = nullptr;
    vector<DisplayNode*> children;

	string name = "";
	string type = "";

	vector<string> types;
	vector<string> styles;
	vector<string> states;

	bool visible = true;

	DisplayNodeAnchor anchorTop;
	DisplayNodeAnchor anchorLeft;

	DisplayNodeOrigin top;
	DisplayNodeOrigin left;
	DisplayNodeOrigin right;
	DisplayNodeOrigin bottom;

	DisplayNodeSize width;
	DisplayNodeSize height;

	ContentDirection contentDirection = kContentDirectionVertical;
	ContentAlignment contentAlignment = kContentAlignmentStart;
	ContentDisposition contentDisposition = kContentDispositionStart;

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
	bool invalidTraits = false;
	bool invalidStyleTraits = false;
	bool invalidStateTraits = false;

	PropertyList properties;

	DisplayNodeCallback invalidateCallback = nullptr;
	DisplayNodeCallback resolveSizeCallback = nullptr;
	DisplayNodeCallback resolveOriginCallback = nullptr;
	DisplayNodeCallback resolveInnerSizeCallback = nullptr;
	DisplayNodeCallback resolveContentSizeCallback = nullptr;
	DisplayNodeCallback resolveMarginCallback = nullptr;
	DisplayNodeCallback resolveBorderCallback = nullptr;
	DisplayNodeCallback resolvePaddingCallback = nullptr;
	DisplayNodeCallback prepareLayoutCallback = nullptr;
	DisplayNodeCallback resolveLayoutCallback = nullptr;
	DisplayNodeMeasureCallback measureCallback = nullptr;
	DisplayNodeUpdateCallback updateCallback = nullptr;

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

	void explode(string type);

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
	void invalidateTraits();
	void invalidateStyleTraits();
	void invalidateStateTraits();

	bool inheritsWrappedWidth();
	bool inheritsWrappedHeight();

	void resolveTraits();
	void resolveLayout();
	void resolveMargin();
	void resolveBorder();
	void resolveInnerSize();
	void resolveContentSize();
	void resolvePadding();
	void resolveWrapper(double width, double height);

	void performLayout();

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

	void reset();

	bool hasNewParent() {
		return this->resolvedParent != this->parent;
	}

	void didInvalidate() {
		if (this->invalidateCallback) {
			this->invalidateCallback(reinterpret_cast<DisplayNodeRef>(this));
		}
	}

	void didResolveSize() {
		if (this->resolveSizeCallback) {
			this->resolveSizeCallback(reinterpret_cast<DisplayNodeRef>(this));
		}
	}

	void didResolveOrigin() {
		if (this->resolveOriginCallback) {
			this->resolveOriginCallback(reinterpret_cast<DisplayNodeRef>(this));
		}
	}

	void didResolveInnerSize() {
		if (this->resolveInnerSizeCallback) {
			this->resolveInnerSizeCallback(reinterpret_cast<DisplayNodeRef>(this));
		}
	}

	void didResolveContentSize() {
		if (this->resolveContentSizeCallback) {
			this->resolveContentSizeCallback(reinterpret_cast<DisplayNodeRef>(this));
		}
	}

	void didResolveMargin() {
		if (this->resolveMarginCallback) {
			this->resolveMarginCallback(reinterpret_cast<DisplayNodeRef>(this));
		}
	}

	void didResolveBorder() {
		if (this->resolveBorderCallback) {
			this->resolveBorderCallback(reinterpret_cast<DisplayNodeRef>(this));
		}
	}

	void didResolvePadding() {
		if (this->resolvePaddingCallback) {
			this->resolvePaddingCallback(reinterpret_cast<DisplayNodeRef>(this));
		}
	}

	void didPrepareLayout() {
		if (this->prepareLayoutCallback) {
			this->prepareLayoutCallback(reinterpret_cast<DisplayNodeRef>(this));
		}
	}

	void didResolveLayout() {
		if (this->resolveLayoutCallback) {
			this->resolveLayoutCallback(reinterpret_cast<DisplayNodeRef>(this));
		}
	}

	void measure(MeasuredSize* size, double w, double h, double minw, double maxw, double minh, double maxh) {
		if (this->measureCallback) {
			this->measureCallback(reinterpret_cast<DisplayNodeRef>(this), size, w, h, minw, maxw, minh, maxh);
		}
	}

	void update(string name, Property* property) {
		if (this->updateCallback) {
			this->updateCallback(
				reinterpret_cast<DisplayNodeRef>(this),
				reinterpret_cast<PropertyRef>(property),
				name.c_str()
			);
		}
	}

public:

	friend class Display;
	friend class LayoutResolver;
	friend class RelativeLayoutResolver;
	friend class AbsoluteLayoutResolver;

	void *data = nullptr;

	DisplayNode();
	DisplayNode(Display* display);
	DisplayNode(Display* display, string type);

	void setDisplay(Display* display) {
		this->display = display;
	}

	void setWindow() {
		this->flags = this->flags | kDisplayNodeFlagWindow;
	}

	void setOpaque() {
		this->flags = this->flags | kDisplayNodeFlagOpaque;
	}

	DisplayNode* getParent() const {
		return this->parent;
	}

	const vector<DisplayNode*>& getChildren() const {
		return this->children;
	}

	void setName(string name);
	void setType(string type);
	void appendStyle(string style);
	void removeStyle(string style);
	void appendState(string state);
	void removeState(string state);

	bool hasStyle(string style) {
		return find(
			this->styles.begin(),
			this->styles.end(),
			style
		) != this->styles.end();
	}

	bool hasState(string state) {
		return find(
			this->states.begin(),
			this->states.end(),
			state
		) != this->states.end();
	}

	const string& getName() const {
		return this->name;
	}

	const string& getType() const {
		return this->type;
	}

	const vector<string>& getTypes() const {
		return this->types;
	}

	const vector<string>& getStyles() const {
		return this->styles;
	}

	const vector<string>& getStates() const {
		return this->states;
	}

	void setVisible(bool visible);

	void setAnchorTop(AnchorType type, AnchorUnit unit, double length);
	void setAnchorLeft(AnchorType type, AnchorUnit unit, double length);

	void setTop(OriginType type, OriginUnit unit, double length);
	void setLeft(OriginType type, OriginUnit unit, double length);
	void setRight(OriginType type, OriginUnit unit, double length);
	void setBottom(OriginType type, OriginUnit unit, double length);

	void setMinTop(double min);
	void setMaxTop(double max);
	void setMinLeft(double min);
	void setMaxLeft(double max);
	void setMinRight(double min);
	void setMaxRight(double max);
	void setMinBottom(double min);
	void setMaxBottom(double max);

	void setWidth(SizeType type, SizeUnit unit, double length);
	void setHeight(SizeType type, SizeUnit unit, double length);

	void setMinWidth(double min);
	void setMaxWidth(double max);
	void setMinHeight(double min);
	void setMaxHeight(double max);

	void setContentDirection(ContentDirection direction);
	void setContentAlignment(ContentAlignment alignment);
	void setContentDisposition(ContentDisposition placement);

	void setContentTop(ContentOriginType type, ContentOriginUnit unit, double length);
	void setContentLeft(ContentOriginType type, ContentOriginUnit unit, double length);
	void setContentWidth(ContentSizeType type, ContentSizeUnit unit, double length);
	void setContentHeight(ContentSizeType type, ContentSizeUnit unit, double length);

	void setExpandFactor(double factor);
	void setShrinkFactor(double factor);

	void setBorderTop(BorderType type, BorderUnit unit, double length);
	void setBorderLeft(BorderType type, BorderUnit unit, double length);
	void setBorderRight(BorderType type, BorderUnit unit, double length);
	void setBorderBottom(BorderType type, BorderUnit unit, double length);

	void setMarginTop(MarginType type, MarginUnit unit, double length);
	void setMarginLeft(MarginType type, MarginUnit unit, double length);
	void setMarginRight(MarginType type, MarginUnit unit, double length);
	void setMarginBottom(MarginType type, MarginUnit unit, double length);

	void setMinMarginTop(double min);
	void setMaxMarginTop(double max);
	void setMinMarginLeft(double min);
	void setMaxMarginLeft(double max);
	void setMinMarginRight(double min);
	void setMaxMarginRight(double max);
	void setMinMarginBottom(double min);
	void setMaxMarginBottom(double max);

	void setPaddingTop(PaddingType type, PaddingUnit unit, double length);
	void setPaddingLeft(PaddingType type, PaddingUnit unit, double length);
	void setPaddingRight(PaddingType type, PaddingUnit unit, double length);
	void setPaddingBottom(PaddingType type, PaddingUnit unit, double length);

	void setMinPaddingTop(double min);
	void setMaxPaddingTop(double max);
	void setMinPaddingLeft(double min);
	void setMaxPaddingLeft(double max);
	void setMinPaddingRight(double min);
	void setMaxPaddingRight(double max);
	void setMinPaddingBottom(double min);
	void setMaxPaddingBottom(double max);

	void setInvalidateCallback(DisplayNodeCallback callback) {
		this->invalidateCallback = callback;
	}

	void setResolveSizeCallback(DisplayNodeCallback callback) {
		this->resolveSizeCallback = callback;
	}

	void setResolveOriginCallback(DisplayNodeCallback callback) {
		this->resolveOriginCallback = callback;
	}

	void setResolveInnerSizeCallback(DisplayNodeCallback callback) {
		this->resolveInnerSizeCallback = callback;
	}

	void setResolveContentSizeCallback(DisplayNodeCallback callback) {
		this->resolveContentSizeCallback = callback;
	}

	void setResolveMarginCallback(DisplayNodeCallback callback) {
		this->resolveMarginCallback = callback;
	}

	void setResolveBorderCallback(DisplayNodeCallback callback) {
		this->resolveBorderCallback = callback;
	}

	void setResolvePaddingCallback(DisplayNodeCallback callback) {
		this->resolvePaddingCallback = callback;
	}

	void setPrepareLayoutCallback(DisplayNodeCallback callback) {
		this->prepareLayoutCallback = callback;
	}

	void setResolveLayoutCallback(DisplayNodeCallback callback) {
		this->resolveLayoutCallback = callback;
	}

	void setMeasureCallback(DisplayNodeMeasureCallback callback) {
		this->measureCallback = callback;
	}

	void setUpdateCallback(DisplayNodeUpdateCallback callback) {
		this->updateCallback = callback;
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

	bool isVisible() const {
		return this->visible;
	}

	bool isOpaque() const {
		return this->flags & kDisplayNodeFlagOpaque;
	}

	bool isWindow() const {
		return this->flags & kDisplayNodeFlagWindow;
	}

	bool isRelative() const {
		return (
			this->top.type == kOriginTypeAuto &&
			this->left.type == kOriginTypeAuto &&
			this->right.type == kOriginTypeAuto &&
			this->bottom.type == kOriginTypeAuto
		);
	}

	bool isAbsolute() const {
		return (
			this->top.type == kOriginTypeLength ||
			this->left.type == kOriginTypeLength ||
			this->right.type == kOriginTypeLength ||
			this->bottom.type == kOriginTypeLength
		);
	}

	bool isFillingParentWidth() const {
		return this->width.type == kSizeTypeFill;
	}

	bool isFillingParentHeight() const {
		return this->height.type == kSizeTypeFill;
	}

	bool isWrappingContentWidth() const {
		return this->width.type == kSizeTypeWrap;
	}

	bool isWrappingContentHeight() const {
		return this->height.type == kSizeTypeWrap;
	}

	void invalidateSize();
	void invalidateOrigin();
	void invalidateLayout();
	
	void measure();
	void resolve();

	string toString();

};

} 

#endif
