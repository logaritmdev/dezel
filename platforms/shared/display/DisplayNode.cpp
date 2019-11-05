#include "DisplayNode.h"
#include "Display.h"
#include "DisplayNodeFrame.h"
#include "LayoutResolver.h"
#include "InvalidStructureException.h"
#include "InvalidOperationException.h"

#include <math.h>
#include <iostream>
#include <algorithm>
#include <string>
#include <sstream>

namespace Dezel {

using std::min;
using std::max;
using std::string;
using std::stringstream;

DisplayNode::DisplayNode()
{
	this->frame = new DisplayNodeFrame(this);
	this->style = new DisplayNodeStyle(this);
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
	if (child->parent) {
		throw new InvalidStructureException("Cannot insert a child from another tree.");
	}

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
	if (child->parent == nullptr) {
		throw new InvalidStructureException("Cannot remove a child.");
	}

	auto it = find(
		this->children.begin(),
		this->children.end(),
		child
	);

	if (it == this->children.end()) {
		return;
	}

	child->entity->removeElement(child);

	child->parent = nullptr;
	child->entity = nullptr;

	this->children.erase(it);

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
DisplayNode::appendElement(DisplayNode* node)
{
	this->elements.push_back(node);
}

void
DisplayNode::removeElement(DisplayNode* node)
{
	auto it = find(
		this->elements.begin(),
		this->elements.end(),
		node
	);

	if (it == this->elements.end()) {
		return;
	}

	this->elements.erase(it);
}

void
DisplayNode::invalidateSize()
{
	this->frame->invalidateSize();
}

void
DisplayNode::invalidateOrigin()
{
	this->frame->invalidateOrigin();
}

void
DisplayNode::invalidateLayout()
{
	this->frame->invalidateLayout();
}

void
DisplayNode::resolve()
{
	if (this->display) {
		this->display->resolve();
	}
}

void
DisplayNode::resolveEntity()
{
	if (this->entity) {
		return;
	}

	DisplayNode* entity = this;

	if (this->type == kDisplayNodeTypeNode) {

		while (true) {

			entity = entity->parent;

			if (entity) {

				if (entity->type == kDisplayNodeTypeRoot ||
					entity->type == kDisplayNodeTypeEntity) {
					break;
				}

				continue;
			}

			throw new InvalidStructureException("Display tree is missing a root entity");
		}
	}

	entity->appendElement(this);

	this->entity = entity;
}

void
DisplayNode::resolveFrame()
{
	this->frame->resolve();
}

void
DisplayNode::resolveStyle()
{
	this->style->resolve();
}

void
DisplayNode::measure()
{
	this->frame->measure();
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
DisplayNode::didResolveLayout()
{
	if (this->resolveLayoutCallback) {
		this->resolveLayoutCallback(reinterpret_cast<DisplayNodeRef>(this));
	}
}

void
DisplayNode::didResolveStyle()
{
	// TODO
}

} 
