#ifndef DisplayNode_h
#define DisplayNode_h

#include "DisplayBase.h"
#include "DisplayNodeFrame.h"
#include "DisplayNodeStyle.h"

#include <float.h>
#include <string>
#include <vector>

namespace Dezel {

using std::string;
using std::vector;

namespace Layout {
	class LayoutResolver;
	class RelativeLayoutResolver;
	class AbsoluteLayoutResolver;
}

class Display;
class DisplayNode {

private:

	DisplayNodeType type = kDisplayNodeTypeNode;

	DisplayNodeFrame* frame;
	DisplayNodeStyle* style;

	Display* display = nullptr;
	DisplayNode* parent = nullptr;
	DisplayNode* entity = nullptr;

    vector<DisplayNode*> children;
    vector<DisplayNode*> elements;

	string name = "";

	bool visible = true;
	bool invalid = false;

	DisplayNodeMeasureCallback measureSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveOriginCallback = nullptr;
	DisplayNodeResolveCallback resolveInnerSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveContentSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveMarginCallback = nullptr;
	DisplayNodeResolveCallback resolveBorderCallback = nullptr;
	DisplayNodeResolveCallback resolvePaddingCallback = nullptr;
	DisplayNodeResolveCallback resolveLayoutCallback = nullptr;

	void appendElement(DisplayNode* node);
	void removeElement(DisplayNode* node);

	void resolveEntity();
	void resolveFrame();
	void resolveStyle();

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

	void measure(DisplayNodeMeasuredSize* size, double w, double h, double minw, double maxw, double minh, double maxh);

public:

	friend class Display;
	friend class DisplayNodeFrame;
	friend class DisplayNodeStyle;
	friend class Layout::LayoutResolver;
	friend class Layout::RelativeLayoutResolver;
	friend class Layout::AbsoluteLayoutResolver;

	void *data = nullptr;

	DisplayNode();

	void setDisplay(Display* display) {
		this->display = display;
	}

	void setType(DisplayNodeType type) {
		this->type = type;
	}

	void setName(string name) {
		this->name = name;
	}

	void setClass(string klass) {
		this->style->setClass(klass);
	}

	void appendStyle(string style) {
		this->style->appendStyle(style);
	}

	void removeStyle(string style) {
		this->style->removeStyle(style);
	}

	void appendState(string state) {
		this->style->appendState(state);
	}

	void removeState(string state) {
		this->style->removeState(state);
	}

	void setAnchorTop(DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length) {
		this->frame->setAnchorTop(type, unit, length);
	}

	void setAnchorLeft(DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length) {
		this->frame->setAnchorLeft(type, unit, length);
	}

	void setTop(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length) {
		this->frame->setTop(type, unit, length);
	}

	void setMinTop(double min) {
		this->frame->setMinTop(min);
	}

	void setMaxTop(double max) {
		this->frame->setMaxTop(max);
	}

	void setLeft(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length) {
		this->frame->setLeft(type, unit, length);
	}

	void setMinLeft(double min) {
		this->frame->setMinLeft(min);
	}

	void setMaxLeft(double max) {
		this->frame->setMaxLeft(max);
	}

	void setRight(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length) {
		this->frame->setRight(type, unit, length);
	}

	void setMinRight(double min) {
		this->frame->setMinRight(min);
	}

	void setMaxRight(double max) {
		this->frame->setMaxRight(max);
	}

	void setBottom(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length) {
		this->frame->setBottom(type, unit, length);
	}

	void setMinBottom(double min) {
		this->frame->setMinBottom(min);
	}

	void setMaxBottom(double max) {
		this->frame->setMaxBottom(max);
	}

	void setWidth(DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length) {
		this->frame->setWidth(type, unit, length);
	}

	void setMinWidth(double min) {
		this->frame->setMinWidth(min);
	}

	void setMaxWidth(double max) {
		this->frame->setMaxWidth(max);
	}

	void setHeight(DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length) {
		this->frame->setHeight(type, unit, length);
	}

	void setMinHeight(double min) {
		this->frame->setMinHeight(min);
	}

	void setMaxHeight(double max) {
		this->frame->setMaxHeight(max);
	}

	void setContentDirection(DisplayNodeContentDirection direction) {
		this->frame->setContentDirection(direction);
	}

	void setContentAlignment(DisplayNodeContentAlignment alignment) {
		this->frame->setContentAlignment(alignment);
	}

	void setContentDisposition(DisplayNodeContentDisposition location) {
		this->frame->setContentDisposition(location);
	}

	void setContentTop(DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length) {
		this->frame->setContentTop(type, unit, length);
	}

	void setContentLeft(DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length) {
		this->frame->setContentLeft(type, unit, length);
	}

	void setContentWidth(DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length) {
		this->frame->setContentWidth(type, unit, length);
	}

	void setContentHeight(DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length) {
		this->frame->setContentHeight(type, unit, length);
	}

	void setExpandFactor(double factor) {
		this->frame->setExpandFactor(factor);
	}

	void setShrinkFactor(double factor) {
		this->frame->setShrinkFactor(factor);
	}

	void setBorderTop(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length) {
		this->frame->setBorderTop(type, unit, length);
	}

	void setBorderLeft(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length) {
		this->frame->setBorderLeft(type, unit, length);
	}

	void setBorderRight(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length) {
		this->frame->setBorderRight(type, unit, length);
	}

	void setBorderBottom(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length) {
		this->frame->setBorderBottom(type, unit, length);
	}

	void setMarginTop(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length) {
		this->frame->setMarginTop(type, unit, length);
	}

	void setMarginLeft(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length) {
		this->frame->setMarginLeft(type, unit, length);
	}

	void setMarginRight(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length) {
		this->frame->setMarginRight(type, unit, length);
	}

	void setMarginBottom(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length) {
		this->frame->setMarginBottom(type, unit, length);
	}

	void setMinMarginTop(double min) {
		this->frame->setMinMarginTop(min);
	}

	void setMaxMarginTop(double max) {
		this->frame->setMaxMarginTop(max);
	}

	void setMinMarginLeft(double min) {
		this->frame->setMinMarginLeft(min);
	}

	void setMaxMarginLeft(double max) {
		this->frame->setMaxMarginLeft(max);
	}

	void setMinMarginRight(double min) {
		this->frame->setMinMarginRight(min);
	}

	void setMaxMarginRight(double max) {
		this->frame->setMaxMarginRight(max);
	}

	void setMinMarginBottom(double min) {
		this->frame->setMinMarginBottom(min);
	}

	void setMaxMarginBottom(double max) {
		this->frame->setMaxMarginBottom(max);
	}

	void setPaddingTop(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length) {
		this->frame->setPaddingTop(type, unit, length);
	}

	void setPaddingLeft(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length) {
		this->frame->setPaddingLeft(type, unit, length);
	}

	void setPaddingRight(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length) {
		this->frame->setPaddingRight(type, unit, length);
	}

	void setPaddingBottom(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length) {
		this->frame->setPaddingBottom(type, unit, length);
	}

	void setMinPaddingTop(double min) {
		this->frame->setMinPaddingTop(min);
	}

	void setMaxPaddingTop(double max) {
		this->frame->setMaxPaddingTop(max);
	}

	void setMinPaddingLeft(double min) {
		this->frame->setMinPaddingLeft(min);
	}

	void setMaxPaddingLeft(double max) {
		this->frame->setMaxPaddingLeft(max);
	}

	void setMinPaddingRight(double min) {
		this->frame->setMinPaddingRight(min);
	}

	void setMaxPaddingRight(double max) {
		this->frame->setMaxPaddingRight(max);
	}

	void setMinPaddingBottom(double min) {
		this->frame->setMinPaddingBottom(min);
	}

	void setMaxPaddingBottom(double max) {
		this->frame->setMaxPaddingBottom(max);
	}

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

	bool fillsParentWidth() {
		return this->frame->isFillingParentWidth();
	}

	bool fillsParentHeight() {
		return this->frame->isFillingParentHeight();
	}

	bool wrapsContentWidth() {
		return this->frame->isWrappingContentWidth();
	}

	bool wrapsContentHeight() {
		return this->frame->isWrappingContentHeight();
	}

	double getMeasuredTop() const {
		return this->frame->measuredTop;
	}

	double getMeasuredLeft() const {
		return this->frame->measuredLeft;
	}

	double getMeasuredRight() const {
		return this->frame->measuredRight;
	}

	double getMeasuredBottom() const {
		return this->frame->measuredBottom;
	}

	double getMeasuredWidth() const {
		return this->frame->measuredWidth;
	}

	double getMeasuredHeight() const {
		return this->frame->measuredHeight;
	}

	double getMeasuredInnerWidth() const {
		return this->frame->measuredInnerWidth;
	}

	double getMeasuredInnerHeight() const {
		return this->frame->measuredInnerHeight;
	}

	double getMeasuredContentWidth() const {
		return this->frame->measuredContentWidth;
	}

	double getMeasuredContentHeight() const {
		return this->frame->measuredContentHeight;
	}

	double getMeasuredMarginTop() const {
		return this->frame->measuredMarginTop;
	}

	double getMeasuredBorderTop() const {
		return this->frame->measuredBorderTop;
	}

	double getMeasuredBorderLeft() const {
		return this->frame->measuredBorderLeft;
	}

	double getMeasuredBorderRight() const {
		return this->frame->measuredBorderRight;
	}

	double getMeasuredBorderBottom() const {
		return this->frame->measuredBorderBottom;
	}

	double getMeasuredMarginLeft() const {
		return this->frame->measuredMarginLeft;
	}

	double getMeasuredMarginRight() const {
		return this->frame->measuredMarginRight;
	}

	double getMeasuredMarginBottom() const {
		return this->frame->measuredMarginBottom;
	}

	double getMeasuredPaddingTop() const {
		return this->frame->measuredPaddingTop;
	}

	double getMeasuredPaddingLeft() const {
		return this->frame->measuredPaddingLeft;
	}

	double getMeasuredPaddingRight() const {
		return this->frame->measuredPaddingRight;
	}

	double getMeasuredPaddingBottom() const {
		return this->frame->measuredPaddingBottom;
	}

	void appendChild(DisplayNode* child);
	void insertChild(DisplayNode* child, int index);
	void removeChild(DisplayNode* child);

	void setVisible(bool visible);

	void invalidateSize();
	void invalidateOrigin();
	void invalidateLayout();

	void measure();
	void resolve();

};

} 

#endif
