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

	Display* display;

	DisplayNodeType type = kDisplayNodeTypeView;
	DisplayNodeFrame* frame;
	DisplayNodeStyle* style;
	
	string id = "";

	DisplayNode* parent = nullptr;
    vector<DisplayNode*> children;

	bool visible = true;
	bool invalid = false;

	DisplayNodeInvalidateCallback invalidateCallback = nullptr;
	DisplayNodeMeasureCallback measureSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveOriginCallback = nullptr;
	DisplayNodeResolveCallback resolveInnerSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveContentSizeCallback = nullptr;
	DisplayNodeResolveCallback resolveMarginCallback = nullptr;
	DisplayNodeResolveCallback resolveBorderCallback = nullptr;
	DisplayNodeResolveCallback resolvePaddingCallback = nullptr;
	DisplayNodeLayoutCallback layoutBeganCallback = nullptr;
	DisplayNodeLayoutCallback layoutEndedCallback = nullptr;

	void invalidateFrame();
	void invalidateStyle();
	void resolveNode();
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

	void measure(DisplayNodeMeasuredSize* size, double w, double h, double minw, double maxw, double minh, double maxh);

	void layoutBegan();
	void layoutEnded();

public:

	friend class Display;
	friend class DisplayNodeFrame;
	friend class Layout::LayoutResolver;
	friend class Layout::RelativeLayoutResolver;
	friend class Layout::AbsoluteLayoutResolver;

	void *data = NULL;

	DisplayNode();

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

	void setContentLocation(DisplayNodeContentLocation location) {
		this->frame->setContentLocation(location);
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

	double getMeasuredTop() {
		return this->frame->measuredTop;
	}

	double getMeasuredLeft() {
		return this->frame->measuredLeft;
	}

	double getMeasuredRight() {
		return this->frame->measuredRight;
	}

	double getMeasuredBottom() {
		return this->frame->measuredBottom;
	}

	double getMeasuredWidth() {
		return this->frame->measuredWidth;
	}

	double getMeasuredHeight() {
		return this->frame->measuredHeight;
	}

	double getMeasuredInnerWidth() {
		return this->frame->measuredInnerWidth;
	}

	double getMeasuredInnerHeight() {
		return this->frame->measuredInnerHeight;
	}

	double getMeasuredContentWidth() {
		return this->frame->measuredContentWidth;
	}

	double getMeasuredContentHeight() {
		return this->frame->measuredContentHeight;
	}

	double getMeasuredMarginTop() {
		return this->frame->measuredMarginTop;
	}

	double getMeasuredBorderTop() {
		return this->frame->measuredBorderTop;
	}

	double getMeasuredBorderLeft() {
		return this->frame->measuredBorderLeft;
	}

	double getMeasuredBorderRight() {
		return this->frame->measuredBorderRight;
	}

	double getMeasuredBorderBottom() {
		return this->frame->measuredBorderBottom;
	}

	double getMeasuredMarginLeft() {
		return this->frame->measuredMarginLeft;
	}

	double getMeasuredMarginRight() {
		return this->frame->measuredMarginRight;
	}

	double getMeasuredMarginBottom() {
		return this->frame->measuredMarginBottom;
	}

	double getMeasuredPaddingTop() {
		return this->frame->measuredPaddingTop;
	}

	double getMeasuredPaddingLeft() {
		return this->frame->measuredPaddingLeft;
	}

	double getMeasuredPaddingRight() {
		return this->frame->measuredPaddingRight;
	}

	double getMeasuredPaddingBottom() {
		return this->frame->measuredPaddingBottom;
	}

	void setId(string id);
	void setType(DisplayNodeType type);
	void setDisplay(Display* display);
	void setVisible(bool visible);

	void appendChild(DisplayNode* child);
	void insertChild(DisplayNode* child, int index);
	void removeChild(DisplayNode* child);

	void resolve();
	void measure();

	void setInvalidateCallback(DisplayNodeInvalidateCallback callback);
	void setMeasureSizeCallback(DisplayNodeMeasureCallback callback);
	void setResolveSizeCallback(DisplayNodeResolveCallback callback);
	void setResolveOriginCallback(DisplayNodeResolveCallback callback);
	void setResolveInnerSizeCallback(DisplayNodeResolveCallback callback);
	void setResolveContentSizeCallback(DisplayNodeResolveCallback callback);
	void setResolveMarginCallback(DisplayNodeResolveCallback callback);
	void setResolveBorderCallback(DisplayNodeResolveCallback callback);
	void setResolvePaddingCallback(DisplayNodeResolveCallback callback);
	void setLayoutBeganCallback(DisplayNodeLayoutCallback callback);
	void setLayoutEndedCallback(DisplayNodeLayoutCallback callback);

};

} 

#endif
