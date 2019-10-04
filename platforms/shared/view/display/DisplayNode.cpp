#include "DisplayNode.h"
#include "Display.h"
#include "DisplayNodeFrame.h"
#include "Resolver.h"

#include <math.h>
#include <iostream>
#include <algorithm>

namespace Dezel {

using std::min;
using std::max;
using std::string;

DisplayNode::DisplayNode()
{
	this->frame = new DisplayNodeFrame(this);
}

void
DisplayNode::setId(string id)
{
	this->id = id;
	// todo invalidate layout
}

void
DisplayNode::setType(DisplayNodeType type)
{
	this->type = type;
}

void
DisplayNode::setDisplay(Display* display)
{
	this->display = display;
}

void
DisplayNode::setVisible(bool visible)
{
	if (this->visible != visible) {
		this->visible = visible;
		this->frame->invalidateParent();
	}
}

void
DisplayNode::appendChild(DisplayNode* child)
{
	this->insertChild(child, static_cast<int>(this->children.size()));
}

void
DisplayNode::insertChild(DisplayNode* child, int index)
{
	auto it = find(
		this->children.begin(),
		this->children.end(),
		child
	);

	if (it != this->children.end()) {
		return;
	}

	this->children.insert(this->children.begin() + index, child);

	child->parent = this;

	this->frame->invalidateLayout();

	const auto w = this->frame->width.type;
	const auto h = this->frame->height.type;

	if (w == kDisplayNodeSizeTypeWrap ||
		h == kDisplayNodeSizeTypeWrap) {
		this->frame->invalidateSize();
		this->frame->invalidateOrigin();
		this->frame->invalidateParent();
	}
}

void
DisplayNode::removeChild(DisplayNode* child)
{
	auto it = find(
		this->children.begin(),
		this->children.end(),
		child
	);

	if (it == this->children.end()) {
		return;
	}

	this->children.erase(it);

	child->parent = NULL;

	this->frame->invalidateLayout();

	const auto w = this->frame->width.type;
	const auto h = this->frame->height.type;

	if (w == kDisplayNodeSizeTypeWrap ||
		h == kDisplayNodeSizeTypeWrap) {
		this->frame->invalidateSize(); 
		this->frame->invalidateOrigin();
		this->frame->invalidateParent();
	}
}

void
DisplayNode::setMeasureSizeCallback(DisplayNodeMeasureCallback callback)
{
	this->measureSizeCallback = callback;
}

void
DisplayNode::setResolveSizeCallback(DisplayNodeResolveCallback callback)
{
	this->resolveSizeCallback = callback;
}

void
DisplayNode::setResolveOriginCallback(DisplayNodeResolveCallback callback)
{
	this->resolveOriginCallback = callback;
}

void
DisplayNode::setResolveInnerSizeCallback(DisplayNodeResolveCallback callback)
{
	this->resolveInnerSizeCallback = callback;
}

void
DisplayNode::setResolveContentSizeCallback(DisplayNodeResolveCallback callback)
{
	this->resolveContentSizeCallback = callback;
}

void
DisplayNode::setResolveMarginCallback(DisplayNodeResolveCallback callback)
{
	this->resolveMarginCallback = callback;
}

void
DisplayNode::setResolveBorderCallback(DisplayNodeResolveCallback callback)
{
	this->resolveBorderCallback = callback;
}

void
DisplayNode::setResolvePaddingCallback(DisplayNodeResolveCallback callback)
{
	this->resolvePaddingCallback = callback;
}

void
DisplayNode::setLayoutBeganCallback(DisplayNodeLayoutCallback callback)
{
	this->layoutBeganCallback = callback;
}

void
DisplayNode::setLayoutEndedCallback(DisplayNodeLayoutCallback callback)
{
	this->layoutEndedCallback = callback;
}

void
DisplayNode::setInvalidateCallback(DisplayNodeInvalidateCallback callback)
{
	this->invalidateCallback = callback;
}

void
DisplayNode::resolve()
{
	if (this->display) {
		this->display->resolve();
	}
}

void
DisplayNode::resolveNode()
{
	if (this->invalid) {
		this->resolveStyle();
		this->resolveFrame();
		this->invalid = false;
	}
}

void
DisplayNode::resolveFrame()
{
	this->frame->resolve();
}

void
DisplayNode::resolveStyle()
{

}

void
DisplayNode::measure()
{
	// TODO
}

void
DisplayNode::invalidateFrame()
{
	if (this->invalid) {
		return;
	}

	this->invalid = true;

	if (this->invalidateCallback) {
		this->invalidateCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

void
DisplayNode::invalidateStyle()
{
	if (this->invalid) {
		return;
	}

	this->invalid = true;

	if (this->invalidateCallback) {
		this->invalidateCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

void
DisplayNode::measure(DisplayNodeMeasuredSize* size, double w, double h, double minw, double maxw, double minh, double maxh)
{
	if (this->measureSizeCallback) {
		this->measureSizeCallback(reinterpret_cast<DisplayNodeRef>(this), size, w, h, minw, maxw, minh, maxh);
	}
}

void
DisplayNode::didResolveSize()
{
	if (this->resolveSizeCallback) {
		this->resolveSizeCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

void
DisplayNode::didResolveOrigin()
{
	if (this->resolveOriginCallback) {
		this->resolveOriginCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

void
DisplayNode::didResolveInnerSize()
{
	if (this->resolveInnerSizeCallback) {
		this->resolveInnerSizeCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

void
DisplayNode::didResolveContentSize()
{
	if (this->resolveContentSizeCallback) {
		this->resolveContentSizeCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

void
DisplayNode::didResolveMargin()
{
	if (this->resolveMarginCallback) {
		this->resolveMarginCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

void
DisplayNode::didResolveBorder()
{
	if (this->resolveBorderCallback) {
		this->resolveBorderCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

void
DisplayNode::didResolvePadding()
{
	if (this->resolvePaddingCallback) {
		this->resolvePaddingCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

void
DisplayNode::layoutBegan()
{
	if (this->layoutBeganCallback) {
		this->layoutBeganCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

void
DisplayNode::layoutEnded()
{
	if (this->layoutEndedCallback) {
		this->layoutEndedCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

} 
