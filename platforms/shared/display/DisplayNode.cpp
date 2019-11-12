#include "DisplayNode.h"
#include "Display.h"
#include "DisplayNode.h"
#include "LayoutResolver.h"
#include "Descriptor.h"
#include "PropertyList.h"
#include "Selector.h"
#include "Fragment.h"
#include "Matcher.h"
#include "Match.h"
#include "Trait.h"
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
using std::stringstream;

using Layout::clamp;
using Layout::round;
using Layout::scale;

using Style::PropertyList;
using Style::Matcher;
using Style::Match;
using Style::Trait;
using Style::kTraitAll;
using Style::kTraitName;
using Style::kTraitType;
using Style::kTraitStyle;
using Style::kTraitState;

static bool importance(const Match& a, const Match& b) {

	if (a.importance == b.importance) {
		return (
			a.getDescriptor()->getSelector()->getOffset() < b.getDescriptor()->getSelector()->getOffset()
		);
	}

	return a.importance < b.importance;
}

DisplayNode::DisplayNode() : layout(this)
{

}

DisplayNode::DisplayNode(Display* display) : layout(this)
{
	this->display = display;
}

DisplayNode::DisplayNode(Display* display, string type) : DisplayNode(display)
{
	this->setType(type);
}

//------------------------------------------------------------------------------
// MARK: Private API
//------------------------------------------------------------------------------

void
DisplayNode::explode(string type)
{
	string token;
	stringstream stream(type);

	while (getline(stream, token, ' ')) {
		this->types.push_back(token);
	}
}

void // TODO Find proper name
DisplayNode::appendEntity(DisplayNode* node)
{
	auto it = find(
		this->entities.begin(),
		this->entities.end(),
		node
	);

	if (it != this->entities.end()) {
		return;
	}

	this->entities.push_back(node);
}

void
DisplayNode::removeEntity(DisplayNode* node)
{
	auto it = find(
		this->entities.begin(),
		this->entities.end(),
		node
	);

	if (it == this->entities.end()) {
		return;
	}

	this->entities.erase(it);
}

//------------------------------------------------------------------------------
// MARK: Protected API
//------------------------------------------------------------------------------

bool
DisplayNode::hasInvalidSize()
{
	return this->invalidSize;
}

bool
DisplayNode::hasInvalidOrigin()
{
	return this->invalidOrigin;
}

bool
DisplayNode::hasInvalidMargin()
{
	if (this->invalidMargin) {
		return true;
	}

	if (this->marginTop.unit == kDisplayNodeMarginUnitPX &&
		this->marginLeft.unit == kDisplayNodeMarginUnitPX &&
		this->marginRight.unit == kDisplayNodeMarginUnitPX &&
		this->marginBottom.unit == kDisplayNodeMarginUnitPX) {
		return false;
	}

	if (this->parent->measuredInnerWidthChanged) {
		if (this->marginLeft.unit == kDisplayNodeMarginUnitPC ||
			this->marginRight.unit == kDisplayNodeMarginUnitPC) {
			return true;
		}
	}

	if (this->parent->measuredInnerHeightChanged) {
		if (this->marginTop.unit == kDisplayNodeMarginUnitPC ||
			this->marginBottom.unit == kDisplayNodeMarginUnitPC) {
			return true;
		}
	}

	if (this->parent->measuredInnerWidthChanged) {
		if (this->marginTop.unit == kDisplayNodeMarginUnitPW ||
			this->marginLeft.unit == kDisplayNodeMarginUnitPW ||
			this->marginRight.unit == kDisplayNodeMarginUnitPW ||
			this->marginBottom.unit == kDisplayNodeMarginUnitPW) {
			return true;
		}
	}

	if (this->parent->measuredInnerHeightChanged) {
		if (this->marginTop.unit == kDisplayNodeMarginUnitPH ||
			this->marginLeft.unit == kDisplayNodeMarginUnitPH ||
			this->marginRight.unit == kDisplayNodeMarginUnitPH ||
			this->marginBottom.unit == kDisplayNodeMarginUnitPH) {
			return true;
		}
	}

	if (this->parent->measuredContentWidthChanged) {
		if (this->marginTop.unit == kDisplayNodeMarginUnitCW ||
			this->marginLeft.unit == kDisplayNodeMarginUnitCW ||
			this->marginRight.unit == kDisplayNodeMarginUnitCW ||
			this->marginBottom.unit == kDisplayNodeMarginUnitCW) {
			return true;
		}
	}

	if (this->parent->measuredContentHeightChanged) {
		if (this->marginTop.unit == kDisplayNodeMarginUnitCH ||
			this->marginLeft.unit == kDisplayNodeMarginUnitCH ||
			this->marginRight.unit == kDisplayNodeMarginUnitCH ||
			this->marginBottom.unit == kDisplayNodeMarginUnitCH) {
			return true;
		}
	}

	if (this->display->viewportWidthChanged) {
		if (this->marginTop.unit == kDisplayNodeMarginUnitVW ||
			this->marginLeft.unit == kDisplayNodeMarginUnitVW ||
			this->marginRight.unit == kDisplayNodeMarginUnitVW ||
			this->marginBottom.unit == kDisplayNodeMarginUnitVW) {
			return true;
		}
	}

	if (this->display->viewportHeightChanged) {
		if (this->marginTop.unit == kDisplayNodeMarginUnitVH ||
			this->marginLeft.unit == kDisplayNodeMarginUnitVH ||
			this->marginRight.unit == kDisplayNodeMarginUnitVH ||
			this->marginBottom.unit == kDisplayNodeMarginUnitVH) {
			return true;
		}
	}

	return false;
}

bool
DisplayNode::hasInvalidBorder()
{
	if (this->invalidBorder) {
		return true;
	}

	if (this->borderTop.unit == kDisplayNodeBorderUnitPX &&
		this->borderLeft.unit == kDisplayNodeBorderUnitPX &&
		this->borderRight.unit == kDisplayNodeBorderUnitPX &&
		this->borderBottom.unit == kDisplayNodeBorderUnitPX) {
		return false;
	}

	if (this->measuredWidthChanged) {
		if (this->borderLeft.unit == kDisplayNodeBorderUnitPC ||
			this->borderRight.unit == kDisplayNodeBorderUnitPC) {
			return true;
		}
	}

	if (this->measuredHeightChanged) {
		if (this->borderTop.unit == kDisplayNodeBorderUnitPC ||
			this->borderBottom.unit == kDisplayNodeBorderUnitPC) {
			return true;
		}
	}

	if (this->parent->measuredInnerWidthChanged) {
		if (this->borderTop.unit == kDisplayNodeBorderUnitPW ||
			this->borderLeft.unit == kDisplayNodeBorderUnitPW ||
			this->borderRight.unit == kDisplayNodeBorderUnitPW ||
			this->borderBottom.unit == kDisplayNodeBorderUnitPW) {
			return true;
		}
	}

	if (this->parent->measuredInnerHeightChanged) {
		if (this->borderTop.unit == kDisplayNodeBorderUnitPH ||
			this->borderLeft.unit == kDisplayNodeBorderUnitPH ||
			this->borderRight.unit == kDisplayNodeBorderUnitPH ||
			this->borderBottom.unit == kDisplayNodeBorderUnitPH) {
			return true;
		}
	}

	if (this->parent->measuredContentWidthChanged) {
		if (this->borderTop.unit == kDisplayNodeBorderUnitCW ||
			this->borderLeft.unit == kDisplayNodeBorderUnitCW ||
			this->borderRight.unit == kDisplayNodeBorderUnitCW ||
			this->borderBottom.unit == kDisplayNodeBorderUnitCW) {
			return true;
		}
	}

	if (this->parent->measuredContentHeightChanged) {
		if (this->borderTop.unit == kDisplayNodeBorderUnitCH ||
			this->borderLeft.unit == kDisplayNodeBorderUnitCH ||
			this->borderRight.unit == kDisplayNodeBorderUnitCH ||
			this->borderBottom.unit == kDisplayNodeBorderUnitCH) {
			return true;
		}
	}

	if (this->display->viewportWidthChanged) {
		if (this->borderTop.unit == kDisplayNodeBorderUnitVW ||
			this->borderLeft.unit == kDisplayNodeBorderUnitVW ||
			this->borderRight.unit == kDisplayNodeBorderUnitVW ||
			this->borderBottom.unit == kDisplayNodeBorderUnitVW) {
			return true;
		}
	}

	if (this->display->viewportHeightChanged) {
		if (this->borderTop.unit == kDisplayNodeBorderUnitVH ||
			this->borderLeft.unit == kDisplayNodeBorderUnitVW ||
			this->borderRight.unit == kDisplayNodeBorderUnitVW ||
			this->borderBottom.unit == kDisplayNodeBorderUnitVW) {
			return true;
		}
	}

	return false;
}

bool
DisplayNode::hasInvalidInnerSize()
{
	return this->invalidInnerSize;
}

bool
DisplayNode::hasInvalidContentSize()
{
	if (this->invalidContentSize) {
		return true;
	}

	if (this->contentWidth.type == kDisplayNodeContentSizeTypeAuto &&
		this->contentHeight.type == kDisplayNodeContentSizeTypeAuto) {
		return false;
	}

	if (this->contentWidth.unit == kDisplayNodeContentSizeUnitPX &&
		this->contentHeight.unit == kDisplayNodeContentSizeUnitPX) {
		return false;
	}

	if (this->measuredInnerWidthChanged &&
		this->contentWidth.unit == kDisplayNodeContentSizeUnitPC) {
		return true;
	}

	if (this->measuredInnerHeightChanged &&
		this->contentHeight.unit == kDisplayNodeContentSizeUnitPC) {
		return true;
	}

	if (this->parent->measuredInnerWidthChanged) {
		if (this->contentWidth.unit == kDisplayNodeContentSizeUnitPW ||
			this->contentHeight.unit == kDisplayNodeContentSizeUnitPW) {
			return true;
		}
	}

	if (this->parent->measuredInnerHeightChanged) {
		if (this->contentWidth.unit == kDisplayNodeContentSizeUnitPH ||
			this->contentHeight.unit == kDisplayNodeContentSizeUnitPH) {
			return true;
		}
	}

	if (this->parent->measuredContentWidthChanged) {
		if (this->contentWidth.unit == kDisplayNodeContentSizeUnitCW ||
			this->contentHeight.unit == kDisplayNodeContentSizeUnitCW) {
			return true;
		}
	}

	if (this->parent->measuredContentHeightChanged) {
		if (this->contentWidth.unit == kDisplayNodeContentSizeUnitCH ||
			this->contentHeight.unit == kDisplayNodeContentSizeUnitCH) {
			return true;
		}
	}

	if (this->display->viewportWidthChanged) {
		if (this->contentWidth.unit == kDisplayNodeContentSizeUnitVW ||
			this->contentHeight.unit == kDisplayNodeContentSizeUnitVW) {
			return true;
		}
	}

	if (this->display->viewportHeightChanged) {
		if (this->contentWidth.unit == kDisplayNodeContentSizeUnitVH ||
			this->contentHeight.unit == kDisplayNodeContentSizeUnitVH) {
			return true;
		}
	}

	return false;
}

bool
DisplayNode::hasInvalidPadding()
{
	if (this->invalidPadding) {
		return true;
	}

	if (this->paddingTop.unit == kDisplayNodePaddingUnitPX &&
		this->paddingLeft.unit == kDisplayNodePaddingUnitPX &&
		this->paddingRight.unit == kDisplayNodePaddingUnitPX &&
		this->paddingBottom.unit == kDisplayNodePaddingUnitPX) {
		return false;
	}

	if (this->measuredInnerWidthChanged) {
		if (this->paddingLeft.unit == kDisplayNodePaddingUnitPC ||
			this->paddingRight.unit == kDisplayNodePaddingUnitPC) {
			return true;
		}
	}

	if (this->measuredInnerHeightChanged) {
		if (this->paddingTop.unit == kDisplayNodePaddingUnitPC ||
			this->paddingBottom.unit == kDisplayNodePaddingUnitPC) {
			return true;
		}
	}

	if (this->parent->measuredInnerWidthChanged) {
		if (this->paddingTop.unit == kDisplayNodePaddingUnitPW ||
			this->paddingLeft.unit == kDisplayNodePaddingUnitPW ||
			this->paddingRight.unit == kDisplayNodePaddingUnitPW ||
			this->paddingBottom.unit == kDisplayNodePaddingUnitPW) {
			return true;
		}
	}

	if (this->parent->measuredInnerHeightChanged) {
		if (this->paddingTop.unit == kDisplayNodePaddingUnitPH ||
			this->paddingLeft.unit == kDisplayNodePaddingUnitPH ||
			this->paddingRight.unit == kDisplayNodePaddingUnitPH ||
			this->paddingBottom.unit == kDisplayNodePaddingUnitPH) {
			return true;
		}
	}

	if (this->parent->measuredContentWidthChanged) {
		if (this->paddingTop.unit == kDisplayNodePaddingUnitCW ||
			this->paddingLeft.unit == kDisplayNodePaddingUnitCW ||
			this->paddingRight.unit == kDisplayNodePaddingUnitCW ||
			this->paddingBottom.unit == kDisplayNodePaddingUnitCW) {
			return true;
		}
	}

	if (this->parent->measuredContentHeightChanged) {
		if (this->paddingTop.unit == kDisplayNodePaddingUnitCH ||
			this->paddingLeft.unit == kDisplayNodePaddingUnitCH ||
			this->paddingRight.unit == kDisplayNodePaddingUnitCH ||
			this->paddingBottom.unit == kDisplayNodePaddingUnitCH) {
			return true;
		}
	}

	if (this->display->viewportWidthChanged) {
		if (this->paddingTop.unit == kDisplayNodePaddingUnitVW ||
			this->paddingLeft.unit == kDisplayNodePaddingUnitVW ||
			this->paddingRight.unit == kDisplayNodePaddingUnitVW ||
			this->paddingBottom.unit == kDisplayNodePaddingUnitVW) {
			return true;
		}
	}

	if (this->display->viewportHeightChanged) {
		if (this->paddingTop.unit == kDisplayNodePaddingUnitVH ||
			this->paddingLeft.unit == kDisplayNodePaddingUnitVH ||
			this->paddingRight.unit == kDisplayNodePaddingUnitVH ||
			this->paddingBottom.unit == kDisplayNodePaddingUnitVH) {
			return true;
		}
	}

	return false;
}

bool
DisplayNode::hasInvalidLayout()
{
	return this->invalidLayout;
}

void
DisplayNode::invalidate()
{
	if (this->display == nullptr) {
		throw InvalidOperationException("Cannot invalidate a node who's display is null.");
	}

	if (this->invalid == false) {
		this->invalid = true;
		this->display->invalidate();
	}
}

void
DisplayNode::invalidateSize()
{
	if (this->invalidSize) {
		return;
	}

	this->invalidSize = true;

	if (this->isWindow()) {
		this->invalidateLayout();
		return;
	}

	this->invalidateParent();
}

void
DisplayNode::invalidateOrigin()
{
	if (this->invalidOrigin == false) {
		this->invalidOrigin = true;
		this->invalidateParent();
	}
}

void
DisplayNode::invalidateInnerSize()
{
	if (this->invalidInnerSize == false) {
		this->invalidInnerSize = true;
		this->invalidate();
	}
}

void
DisplayNode::invalidateContentSize()
{
	if (this->invalidContentSize == false) {
		this->invalidContentSize = true;
		this->invalidate();
	}
}

void
DisplayNode::invalidateContentOrigin()
{
	if (this->invalidContentOrigin == false) {
		this->invalidContentOrigin = true;
		this->invalidate();
	}
}

void
DisplayNode::invalidateMargin()
{
	if (this->invalidMargin == false) {
		this->invalidMargin = true;
		this->invalidate();
	}
}

void
DisplayNode::invalidateBorder()
{
	if (this->invalidBorder == false) {
		this->invalidBorder = true;
		this->invalidate();
	}
}

void
DisplayNode::invalidatePadding()
{
	if (this->invalidPadding == false) {
		this->invalidPadding = true;
		this->invalidate();
	}
}

void
DisplayNode::invalidateLayout()
{
	if (this->invalidLayout == false) {
		this->invalidLayout = true;
		this->invalidate();
	}
}

void
DisplayNode::invalidateParent()
{
	auto parent = this->parent;

	if (parent == nullptr ||
		parent->invalidLayout) {
		return;
	}

	parent->invalidateLayout();

	/*
	 * This view might be within a wrapped view which itself can be inside another
	 * wrapper view. We need to find the highest parent of a wrap chain and invalidate
	 * this one.
	 */

	const auto parentW = parent->width;
	const auto parentH = parent->height;

	if (parentW.type == kDisplayNodeSizeTypeWrap ||
		parentH.type == kDisplayNodeSizeTypeWrap) {

		parent->invalidateSize();
		parent->invalidateOrigin();

		vector<DisplayNode*> path;
		DisplayNode* last = nullptr;
		DisplayNode* node = parent;

		while (node != nullptr) {

			node = parent;

			if (node) {

				const auto w = width;
				const auto h = height;

				if (w.type != kDisplayNodeSizeTypeWrap && h.type != kDisplayNodeSizeTypeWrap &&
					w.type != kDisplayNodeSizeTypeFill && h.type != kDisplayNodeSizeTypeFill) {
					break;
				}

				this->invalidateSize();
				this->invalidateOrigin();
				this->invalidateLayout();

				if (w.type == kDisplayNodeSizeTypeWrap ||
					h.type == kDisplayNodeSizeTypeWrap) {
					last = node;
				}
			}
		}

		if (last &&
			last->parent) {
			last->parent->invalidateLayout();
		}
	}
}

void
DisplayNode::invalidateTraits(Trait trait)
{
	if (this->traits & trait) {
		return;
	}

	if (this->forceResolveStyle && trait & kTraitStyle) this->forceResolveStyle = false;
	if (this->forceResolveState && trait & kTraitState) this->forceResolveState = false;

	this->traits = this->traits | trait;

	if (this->invalidTraits == false) {
		this->invalidTraits = true;
		this->invalidate();
	}
}

bool
DisplayNode::inheritsWrappedWidth()
{
	if (this->isWindow()) {
		return false;
	}

	const auto l = this->left.type;
	const auto r = this->right.type;
	const auto w = this->width.type;

	if (l == kDisplayNodeOriginTypeLength &&
		r == kDisplayNodeOriginTypeLength) {
		return false;
	}

	if (w == kDisplayNodeSizeTypeWrap) {
		return true;
	}

	if (w == kDisplayNodeSizeTypeFill) {

		auto node = this->parent;

		while (node) {

			if (width.type == kDisplayNodeSizeTypeFill) {
				node = node->parent;
				continue;
			}

			if (width.type == kDisplayNodeSizeTypeWrap) {
				return true;
			}

			return false;
		}
	}

	return false;
}

bool
DisplayNode::inheritsWrappedHeight()
{
	if (this->isWindow()) {
		return false;
	}

	const auto t = this->top.type;
	const auto b = this->bottom.type;
	const auto h = this->height.type;

	if (t == kDisplayNodeOriginTypeLength &&
		b == kDisplayNodeOriginTypeLength) {
		return false;
	}

	if (h == kDisplayNodeSizeTypeWrap) {
		return true;
	}

	if (h == kDisplayNodeSizeTypeFill) {

		auto node = this->parent;

		while (node) {

			if (height.type == kDisplayNodeSizeTypeFill) {
				node = node->parent;
				continue;
			}

			if (height.type == kDisplayNodeSizeTypeWrap) {
				return true;
			}

			return false;
		}
	}

	return false;
}

void
DisplayNode::resolveHolder()
{
	if (this->holder) {
		return;
	}

	DisplayNode* holder = this;

	if (this->isOpaque() == false &&
		this->isWindow() == false) {

		while (true) {

			holder = holder->parent;

			if (holder) {

				if (holder->isOpaque() ||
					holder->isWindow()) {
					break;
				}

				continue;
			}

			throw new InvalidStructureException("Display tree is missing a window");
		}
	}

	holder->appendEntity(this);

	this->holder = holder;
}

void
DisplayNode::resolveTraits()
{
	if (this->display->stylesheet == nullptr) {
		return;
	}

	if (this->invalidTraits == false &&
		this->forceResolveStyle == false &&
		this->forceResolveState == false) {
		return;
	}

	if (this->invalidTraits) {

		Matcher matcher;

		if (this->traits & kTraitName ||
			this->traits & kTraitType) {
			this->matchedTypes.clear();
			matcher.match(this, this->matchedTypes, this->display->stylesheet->getTypeDescriptors());
		}

		if (this->traits & kTraitStyle) {
			this->matchedStyles.clear();
			matcher.match(this, this->matchedStates, this->display->stylesheet->getStyleDescriptors());
		}

		if (this->traits & kTraitState) {
			this->matchedStates.clear();
			matcher.match(this, this->matchedStates, this->display->stylesheet->getStateDescriptors());
		}

		auto reserve = (
			this->matchedTypes.size() +
			this->matchedStyles.size() +
			this->matchedStates.size()
		);

		vector<Match> matches;
		matches.reserve(reserve);
		matches.insert(matches.end(), this->matchedTypes.begin(), this->matchedTypes.end());
		matches.insert(matches.end(), this->matchedStyles.begin(), this->matchedStyles.end());
		matches.insert(matches.end(), this->matchedStates.begin(), this->matchedStates.end());

		sort(
			matches.begin(),
			matches.end(),
			importance
		);

		PropertyList properties;

		for (auto match : matches) {
			properties.merge(match.getDescriptor()->getProperties());
		}

		vector<Property*> insert;
		vector<Property*> update;
		vector<Property*> remove;

		insert.reserve(max(this->properties.size(), properties.size()));
		update.reserve(max(this->properties.size(), properties.size()));
		remove.reserve(max(this->properties.size(), properties.size()));

		this->properties.diffs(
			properties,
			insert,
			update,
			remove
		);

		for (auto property : remove) this->update(property->getName(), nullptr);
		for (auto property : update) this->update(property->getName(), property);
		for (auto property : insert) this->update(property->getName(), property);

		this->properties = properties;
	}

	/*
	 * This node was given a style or a state that might affect children
	 * down the line. When this happens we set a flag indicating that
	 * even if the node is not invalid, it must
	 */

	if (this->invalidTraits & kTraitStyle ||
		this->invalidTraits & kTraitState) {

		for (auto child : this->entities) {

			if (this->invalidTraits & kTraitStyle) {
				child->forceResolveStyle = true;
			}

			if (this->invalidTraits & kTraitState) {
				child->forceResolveState = true;
			}
		}
	}

	/*
	TODO
	Déterminer si le style / state a été appliqué et résolvé
	Mettre les flags
	 */

	this->traits = kTraitAll;
	this->invalidTraits = false;
	this->forceResolveStyle = false;
	this->forceResolveState = false;
}

void
DisplayNode::resolveLayout()
{
	/*
	 * Resolving a node means computing its border, padding inner size,
	 * content size and layout. At the moment this method is called the
	 * node has been given a measured size and an origin by the layout
	 * pass from its parent.
	 */

	this->measuredInnerWidthChanged = false;
	this->measuredInnerHeightChanged = false;
	this->measuredContentWidthChanged = false;
	this->measuredContentHeightChanged = false;

	if (this->isWindow()) {

		if (this->invalidSize) {

			this->measuredWidthChanged = false;
			this->measuredHeightChanged = false;

			/*
			 * This is the root node, simply apply its width and height
			 * and call it a day.
			 */

			if (this->width.type != kDisplayNodeSizeTypeLength ||
				this->width.unit != kDisplayNodeSizeUnitPX) {
				throw InvalidOperationException("The root node size must be specified in pixels.");
			}

			if (this->height.type != kDisplayNodeSizeTypeLength ||
				this->height.unit != kDisplayNodeSizeUnitPX) {
				throw InvalidOperationException("The root node size must be specified in pixels.");
			}

			const auto measuredW = this->width.length;
			const auto measuredH = this->height.length;

			if (this->measuredWidth != measuredW) {
				this->measuredWidth = measuredW;
				this->measuredWidthChanged = true;
				this->invalidateInnerSize();
			}

			if (this->measuredHeight != measuredH) {
				this->measuredHeight = measuredH;
				this->measuredHeightChanged = true;
				this->invalidateInnerSize();
			}

			if (this->measuredWidthChanged ||
				this->measuredHeightChanged) {
				this->didResolveSize();
			}

			this->invalidSize = false;
		}
	}

	/*
	 * Each of the following starts by checking if a resolve operation is
	 * required or not. There may be a better way to do this, but at this point
	 * this is the best way I've found to handle sizes that needs to be
	 * invalidated when wither the parent or the viewport size changes.
	 */

	this->resolveBorder();
	this->resolveInnerSize();
	this->resolveContentSize();
	this->resolvePadding();

	this->performLayout();
}

void
DisplayNode::resolveMargin()
{
	if (this->hasInvalidMargin() == false) {
		return;
	}

	const auto marginT = this->measureMarginTop();
	const auto marginL = this->measureMarginLeft();
	const auto marginR = this->measureMarginRight();
	const auto marginB = this->measureMarginBottom();

	if (marginT != this->measuredMarginTop ||
		marginL != this->measuredMarginLeft ||
		marginR != this->measuredMarginRight ||
		marginB != this->measuredMarginBottom) {

		this->measuredMarginTop = marginT;
		this->measuredMarginLeft = marginL;
		this->measuredMarginRight = marginR;
		this->measuredMarginBottom = marginB;

		this->invalidateOrigin();

		this->didResolveMargin();
	}

	this->invalidMargin = false;
}

void
DisplayNode::resolveBorder()
{
	if (this->hasInvalidBorder() == false) {
		return;
	}

	const auto borderT = this->measureBorderTop();
	const auto borderL = this->measureBorderLeft();
	const auto borderR = this->measureBorderRight();
	const auto borderB = this->measureBorderBottom();

	if (borderT != this->measuredBorderTop ||
		borderL != this->measuredBorderLeft ||
		borderR != this->measuredBorderRight ||
		borderB != this->measuredBorderBottom) {

		this->measuredBorderTop = borderT;
		this->measuredBorderLeft = borderL;
		this->measuredBorderRight = borderR;
		this->measuredBorderBottom = borderB;

		this->invalidateInnerSize();

		this->didResolveBorder();
	}

	this->invalidBorder = false;
}

void
DisplayNode::resolveInnerSize()
{
	if (this->hasInvalidInnerSize() == false) {
		return;
	}

	const auto innerW = this->measureInnerWidth();
	const auto innerH = this->measureInnerHeight();

	if (innerW != this->measuredInnerWidth ||
		innerH != this->measuredInnerHeight) {

		if (this->measuredInnerWidth != innerW) {
			this->measuredInnerWidth = innerW;
			this->measuredInnerWidthChanged = true;
		}

		if (this->measuredInnerHeight != innerH) {
			this->measuredInnerHeight = innerH;
			this->measuredInnerHeightChanged = true;
		}

		this->invalidateContentSize();

		this->didResolveInnerSize();
	}

	this->invalidInnerSize = false;
}

void
DisplayNode::resolveContentSize()
{
	if (this->hasInvalidContentSize() == false) {
		return;
	}

	const auto contentW = this->measureContentWidth();
	const auto contentH = this->measureContentHeight();

	if (contentW != this->measuredContentWidth ||
		contentH != this->measuredContentHeight) {

		if (this->measuredContentWidth != contentW) {
			this->measuredContentWidth = contentW;
			this->measuredContentWidthChanged = true;
		}

		if (this->measuredContentHeight != contentH) {
			this->measuredContentHeight = contentH;
			this->measuredContentHeightChanged = true;
		}

		this->invalidateLayout();

		this->didResolveContentSize();
	}

	this->invalidContentSize = false;
}

void
DisplayNode::resolvePadding()
{
	if (this->hasInvalidPadding() == false) {
		return;
	}

	const auto paddingT = this->measurePaddingTop();
	const auto paddingL = this->measurePaddingLeft();
	const auto paddingR = this->measurePaddingRight();
	const auto paddingB = this->measurePaddingBottom();

	if (paddingT != this->measuredPaddingTop ||
		paddingL != this->measuredPaddingLeft ||
		paddingR != this->measuredPaddingRight ||
		paddingB != this->measuredPaddingBottom) {

		this->measuredPaddingTop = paddingT;
		this->measuredPaddingLeft = paddingL;
		this->measuredPaddingRight = paddingR;
		this->measuredPaddingBottom = paddingB;

		this->invalidateLayout();

		this->didResolvePadding();
	}

	this->invalidPadding = false;
}

void
DisplayNode::resolveWrapper(double w, double h)
{
	this->resolveTraits();

	if (this->resolvedSize) {

		/*
		 * Once a node has been measured, unless its size is explicity invalid
		 * or its views has changed, there are no reason to measured it
		 * again.
		 */

		if (this->invalidSize == false &&
			this->invalidLayout == false) {
			return;
		}
	}

	const bool wrapW = this->inheritedWrappedContentWidth;
	const bool wrapH = this->inheritedWrappedContentHeight;

	auto measuredW = this->measuredWidth;
	auto measuredH = this->measuredHeight;

	if (wrapW) w = 0;
	if (wrapH) h = 0;

	this->measuredWidth = w;
	this->measuredHeight = h;

	/*
	 * When a wrapped node is measured we give the node a chance to returns
	 * its intrinsic size first. This is useful for views such as text that
	 * needs their size to fit the text content.
	 */

	DisplayNodeMeasuredSize size;
	size.width = -1;
	size.height = -1;

	this->measure(
		&size, w, h,
		this->width.min,
		this->width.max,
		this->height.min,
		this->height.max
	);

	bool hasIntrinsicW = size.width > -1;
	bool hasIntrinsicH = size.height > -1;

	if (wrapW && hasIntrinsicW) this->measuredWidth = size.width;
	if (wrapH && hasIntrinsicH) this->measuredHeight = size.height;

	if (hasIntrinsicW == false ||
		hasIntrinsicH == false) {

		/*
		 * At this point the node size is determined by its content, padding
		 * and border. We set the padding to 0 because it might have been
		 * incorrectly resolved previously, for instance when using relative
		 * to size units.
		 */

		this->measuredPaddingTop = 0;
		this->measuredPaddingLeft = 0;
		this->measuredPaddingRight = 0;
		this->measuredPaddingBottom = 0;

		const auto contentAlignment = this->contentAlignment;
		const auto contentDisposition = this->contentDisposition;

		this->contentAlignment = kDisplayNodeContentAlignmentStart;
		this->contentDisposition = kDisplayNodeContentDispositionStart;

		this->performLayout();

		this->contentAlignment = contentAlignment;
		this->contentDisposition = contentDisposition;

		if (wrapW) w = this->layout.getExtentRight() - this->layout.getExtentLeft();
		if (wrapH) h = this->layout.getExtentBottom() - this->layout.getExtentTop();

		this->measuredWidth = w;
		this->measuredHeight = h;
	}

	/*
	 * The padding and border can be expressed as a relative measure of the
	 * view. In the case of a wrapped node, the padding and border size will be
	 * based on the node size.
	 */

	if (this->measuredWidth != measuredW) {
		this->measuredWidthChanged = true;
		this->invalidateInnerSize();
	}

	if (this->measuredHeight != measuredH) {
		this->measuredHeightChanged = true;
		this->invalidateInnerSize();
	}

	this->resolveInnerSize();
	this->resolveContentSize();
	this->resolveBorder();
	this->resolvePadding();

	const auto borderT = this->measuredBorderTop;
	const auto borderL = this->measuredBorderLeft;
	const auto borderR = this->measuredBorderRight;
	const auto borderB = this->measuredBorderBottom;

	const auto paddingT = this->measuredPaddingTop;
	const auto paddingL = this->measuredPaddingLeft;
	const auto paddingR = this->measuredPaddingRight;
	const auto paddingB = this->measuredPaddingBottom;

	if (paddingT || paddingL ||
		paddingR || paddingB) {

		/*
		 * A second layout pass is needed to apply padding which could not be
		 * calculated earlier, because of relative measures.
		 */

		this->invalidateLayout();
	}

	this->measuredWidth += borderL + borderR + paddingL + paddingR;
	this->measuredHeight += borderT + borderB + paddingT + paddingB;

	const auto scale = this->display->scale;

	measuredW = this->measuredWidth;
	measuredH = this->measuredHeight;

	this->measuredWidth = round(this->measuredWidth, scale);
	this->measuredHeight = round(this->measuredHeight, scale);

	this->measuredWidth = clamp(
		this->measuredWidth,
		this->width.min,
		this->width.max
	);

	this->measuredHeight = clamp(
		this->measuredHeight,
		this->height.min,
		this->height.max
	);

	if (this->measuredWidth != measuredW ||
		this->measuredHeight != measuredH) {

		/*
		 * The node size has been limited to a certain size, this invalidates
		 * the inner and content size as well as the layout.
		 */

		this->invalidateInnerSize();
		this->invalidateLayout();

		this->resolveInnerSize();
		this->resolveContentSize();
	}

	/*
	 * The following members, when set to true might allow the border and
	 * padding to be resolved again. Since these are resolved here, there is
	 * no reason to allow them to be resolved again.
	 */

	this->measuredWidthChanged = false;
	this->measuredHeightChanged = false;
	this->measuredInnerWidthChanged = false;
	this->measuredInnerHeightChanged = false;
	this->measuredContentWidthChanged = false;
	this->measuredContentHeightChanged = false;
}

void
DisplayNode::performLayout()
{
	if (this->invalidLayout == false) {
		return;
	}

	this->layout.prepare();
	this->layout.resolve();

	this->invalidLayout = false;
}

double
DisplayNode::measureAnchorTop()
{
	double value = 0;

	if (this->anchorTop.type == kDisplayNodeAnchorTypeLength) {

		value = this->anchorTop.length;

		switch (this->anchorTop.unit) {
			case kDisplayNodeAnchorUnitPC: value = scale(value, this->measuredHeight); break;
			default: break;
		}
	}

	return round(value, this->display->scale);
}

double
DisplayNode::measureAnchorLeft()
{
	double value = 0;

	if (this->anchorLeft.type == kDisplayNodeAnchorTypeLength) {

		value = this->anchorLeft.length;

		switch (this->anchorLeft.unit) {
			case kDisplayNodeAnchorUnitPC: value = scale(value, this->measuredWidth); break;
			default: break;
		}
	}

	return round(value, this->display->scale);
}

double
DisplayNode::measureBorderTop()
{
	const auto type = this->borderTop.type;
	const auto unit = this->borderTop.unit;

	double value = this->borderTop.length;

	if (type == kDisplayNodeBorderTypeLength) {

		switch (unit) {

			case kDisplayNodeBorderUnitPC: value = scale(value, this->measuredHeight); break;
			case kDisplayNodeBorderUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodeBorderUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodeBorderUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodeBorderUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodeBorderUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodeBorderUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->borderTop.min,
		this->borderTop.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measureBorderLeft()
{
	const auto type = this->borderLeft.type;
	const auto unit = this->borderLeft.unit;

	double value = this->borderLeft.length;

	if (type == kDisplayNodeBorderTypeLength) {

		switch (unit) {

			case kDisplayNodeBorderUnitPC: value = scale(value, this->measuredWidth); break;
			case kDisplayNodeBorderUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodeBorderUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodeBorderUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodeBorderUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodeBorderUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodeBorderUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->borderLeft.min,
		this->borderLeft.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measureBorderRight()
{
	const auto type = this->borderRight.type;
	const auto unit = this->borderRight.unit;

	double value = this->borderRight.length;

	if (type == kDisplayNodeBorderTypeLength) {

		switch (unit) {

			case kDisplayNodeBorderUnitPC: value = scale(value, this->measuredWidth); break;
			case kDisplayNodeBorderUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodeBorderUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodeBorderUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodeBorderUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodeBorderUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodeBorderUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->borderRight.min,
		this->borderRight.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measureBorderBottom()
{
	const auto type = this->borderBottom.type;
	const auto unit = this->borderBottom.unit;

	double value = this->borderBottom.length;

	if (type == kDisplayNodeBorderTypeLength) {

		switch (unit) {

			case kDisplayNodeBorderUnitPC: value = scale(value, this->measuredHeight); break;
			case kDisplayNodeBorderUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodeBorderUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodeBorderUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodeBorderUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodeBorderUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodeBorderUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->borderBottom.min,
		this->borderBottom.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measureMarginTop()
{
	const auto type = this->marginTop.type;
	const auto unit = this->marginTop.unit;

	double value = this->marginTop.length;

	if (type == kDisplayNodeMarginTypeLength) {

		switch (unit) {

			case kDisplayNodeMarginUnitPC: value = scale(value, this->parent->measuredContentHeight); break;
			case kDisplayNodeMarginUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodeMarginUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodeMarginUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodeMarginUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodeMarginUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodeMarginUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->marginTop.min,
		this->marginTop.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measureMarginLeft()
{
	const auto type = this->marginLeft.type;
	const auto unit = this->marginLeft.unit;

	double value = this->marginLeft.length;

	if (type == kDisplayNodeMarginTypeLength) {

		switch (unit) {

			case kDisplayNodeMarginUnitPC: value = scale(value, this->parent->measuredContentWidth); break;
			case kDisplayNodeMarginUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodeMarginUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodeMarginUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodeMarginUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodeMarginUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodeMarginUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->marginLeft.min,
		this->marginLeft.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measureMarginRight()
{
	const auto type = this->marginRight.type;
	const auto unit = this->marginRight.unit;

	double value = this->marginRight.length;

	if (type == kDisplayNodeMarginTypeLength) {

		switch (unit) {

			case kDisplayNodeMarginUnitPC: value = scale(value, this->parent->measuredContentWidth); break;
			case kDisplayNodeMarginUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodeMarginUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodeMarginUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodeMarginUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodeMarginUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodeMarginUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->marginRight.min,
		this->marginRight.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measureMarginBottom()
{
	const auto type = this->marginBottom.type;
	const auto unit = this->marginBottom.unit;

	double value = this->marginBottom.length;

	if (type == kDisplayNodeMarginTypeLength) {

		switch (unit) {

			case kDisplayNodeMarginUnitPC: value = scale(value, this->parent->measuredContentHeight); break;
			case kDisplayNodeMarginUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodeMarginUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodeMarginUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodeMarginUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodeMarginUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodeMarginUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->marginBottom.min,
		this->marginBottom.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measurePaddingTop()
{
	const auto type = this->paddingTop.type;
	const auto unit = this->paddingTop.unit;

	double value = this->paddingTop.length;

	if (type == kDisplayNodePaddingTypeLength) {

		switch (unit) {

			case kDisplayNodePaddingUnitPC: value = scale(value, this->measuredInnerHeight); break;
			case kDisplayNodePaddingUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodePaddingUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodePaddingUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodePaddingUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodePaddingUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodePaddingUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->paddingTop.min,
		this->paddingTop.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measurePaddingLeft()
{
	const auto type = this->paddingLeft.type;
	const auto unit = this->paddingLeft.unit;

	double value = this->paddingLeft.length;

	if (type == kDisplayNodePaddingTypeLength) {

		switch (unit) {

			case kDisplayNodePaddingUnitPC: value = scale(value, this->measuredInnerWidth); break;
			case kDisplayNodePaddingUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodePaddingUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodePaddingUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodePaddingUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodePaddingUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodePaddingUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->paddingLeft.min,
		this->paddingLeft.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measurePaddingRight()
{
	const auto type = this->paddingRight.type;
	const auto unit = this->paddingRight.unit;

	double value = this->paddingRight.length;

	if (type == kDisplayNodePaddingTypeLength) {

		switch (unit) {

			case kDisplayNodePaddingUnitPC: value = scale(value, this->measuredInnerWidth); break;
			case kDisplayNodePaddingUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodePaddingUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodePaddingUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodePaddingUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodePaddingUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodePaddingUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->paddingRight.min,
		this->paddingRight.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measurePaddingBottom()
{
	const auto type = this->paddingBottom.type;
	const auto unit = this->paddingBottom.unit;

	double value = this->paddingBottom.length;

	if (type == kDisplayNodePaddingTypeLength) {

		switch (unit) {

			case kDisplayNodePaddingUnitPC: value = scale(value, this->measuredInnerHeight); break;
			case kDisplayNodePaddingUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodePaddingUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodePaddingUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodePaddingUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodePaddingUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodePaddingUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}
	}

	value = clamp(
		value,
		this->paddingBottom.min,
		this->paddingBottom.max
	);

	return round(value, this->display->scale);
}

double
DisplayNode::measureInnerWidth()
{
	/*
	 * note: there is no need here to round the values as they are
	 * rounded already
	 */

	return this->measuredWidth - this->measuredBorderLeft - this->measuredBorderRight;
}

double
DisplayNode::measureInnerHeight()
{
	/*
	 * note: there is no need here to round the values as they are
	 * rounded already
	 */

	return this->measuredHeight - this->measuredBorderTop - this->measuredBorderBottom;
}

double
DisplayNode::measureContentWidth()
{
	const auto type = this->contentWidth.type;
	const auto unit = this->contentWidth.unit;

	double value = this->contentWidth.length;

	if (type == kDisplayNodeContentSizeTypeAuto) {

		value = this->measuredInnerWidth;

	} else {

		switch (unit) {

			case kDisplayNodeContentSizeUnitPC: value = scale(value, this->measuredInnerWidth); break;
			case kDisplayNodeContentSizeUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodeContentSizeUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodeContentSizeUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodeContentSizeUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodeContentSizeUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodeContentSizeUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}

		value = max(value, this->measuredInnerWidth);
	}

	return round(value, this->display->scale);
}

double
DisplayNode::measureContentHeight()
{
	const auto type = this->contentHeight.type;
	const auto unit = this->contentHeight.unit;

	double value = this->contentHeight.length;

	if (type == kDisplayNodeContentSizeTypeAuto) {

		value = this->measuredInnerHeight;

	} else {

		switch (unit) {

			case kDisplayNodeContentSizeUnitPC: value = scale(value, this->measuredInnerHeight); break;
			case kDisplayNodeContentSizeUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kDisplayNodeContentSizeUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kDisplayNodeContentSizeUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kDisplayNodeContentSizeUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kDisplayNodeContentSizeUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kDisplayNodeContentSizeUnitVH: value = scale(value, this->display->viewportHeight); break;
			default: break;

		}

		value = max(value, this->measuredInnerHeight);
	}

	return round(value, this->display->scale);
}

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

void
DisplayNode::setName(string name)
{
	if (this->name != name) {
		this->name = name;
		this->invalidateTraits(Style::kTraitName);
	}
}

void
DisplayNode::setType(string type)
{
	if (this->type != type) {
		this->type = type;
		this->explode(type);
		this->invalidateTraits(Style::kTraitType);
	}

}

void
DisplayNode::appendStyle(string style)
{
	auto it = find(
		this->styles.begin(),
		this->styles.end(),
		style
	);

	if (it != this->styles.end()) {
		return;
	}

	this->styles.push_back(style);

	this->invalidateTraits(Style::kTraitStyle);
}

void
DisplayNode::removeStyle(string style)
{
	auto it = find(
		this->styles.begin(),
		this->styles.end(),
		style
	);

	if (it == this->styles.end()) {
		return;
	}

	this->styles.erase(it);

	this->invalidateTraits(Style::kTraitStyle);
}

void
DisplayNode::appendState(string state)
{
	auto it = find(
		this->states.begin(),
		this->states.end(),
		state
	);

	if (it != this->states.end()) {
		return;
	}

	this->states.push_back(state);

	this->invalidateTraits(Style::kTraitState);
}

void
DisplayNode::removeState(string state)
{
	auto it = find(
		this->states.begin(),
		this->states.end(),
		state
	);

	if (it == this->states.end()) {
		return;
	}

	this->states.erase(it);

	this->invalidateTraits(Style::kTraitState);
}

void
DisplayNode::setVisible(bool visible)
{
	if (this->visible != visible) {
		this->visible = visible;
		this->invalidateParent();
	}
}

void
DisplayNode::setAnchorTop(DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length)
{
	if (this->anchorTop.equals(type, unit, length)) {
		return;
	}

	this->anchorTop.type = type;
	this->anchorTop.unit = unit;
	this->anchorTop.length = length;

	this->invalidateOrigin();
}

void
DisplayNode::setAnchorLeft(DisplayNodeAnchorType type, DisplayNodeAnchorUnit unit, double length)
{
	if (this->anchorLeft.equals(type, unit, length)) {
		return;
	}

	this->anchorLeft.type = type;
	this->anchorLeft.unit = unit;
	this->anchorLeft.length = length;

	this->invalidateOrigin();
}

void
DisplayNode::setTop(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
{
	if (this->top.equals(type, unit, length)) {
		return;
	}

	this->top.type = type;
	this->top.unit = unit;
	this->top.length = length;

	this->invalidateOrigin();
}

void
DisplayNode::setMinTop(double min)
{
	if (this->top.min != min) {
		this->top.min = min;
		this->invalidateOrigin();
	}
}

void
DisplayNode::setMaxTop(double max)
{
	if (this->top.max != max) {
		this->top.max = max;
		this->invalidateOrigin();
	}
}

void
DisplayNode::setLeft(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
{
	if (this->left.equals(type, unit, length)) {
		return;
	}

	this->left.type = type;
	this->left.unit = unit;
	this->left.length = length;

	this->invalidateOrigin();
}

void
DisplayNode::setMinLeft(double min)
{
	if (this->left.min != min) {
		this->left.min = min;
		this->invalidateOrigin();
	}
}

void
DisplayNode::setMaxLeft(double max)
{
	if (this->left.max != max) {
		this->left.max = max;
		this->invalidateOrigin();
	}
}

void
DisplayNode::setRight(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
{
	if (this->right.equals(type, unit, length)) {
		return;
	}

	this->right.type = type;
	this->right.unit = unit;
	this->right.length = length;

	this->invalidateOrigin();
}

void
DisplayNode::setMinRight(double min)
{
	if (this->right.min != min) {
		this->right.min = min;
		this->invalidateOrigin();
	}
}

void
DisplayNode::setMaxRight(double max)
{
	if (this->right.max != max) {
		this->right.max = max;
		this->invalidateOrigin();
	}
}

void
DisplayNode::setBottom(DisplayNodeOriginType type, DisplayNodeOriginUnit unit, double length)
{
	if (this->bottom.equals(type, unit, length)) {
		return;
	}

	this->bottom.type = type;
	this->bottom.unit = unit;
	this->bottom.length = length;

	this->invalidateOrigin();
}

void
DisplayNode::setMinBottom(double min)
{
	if (this->bottom.min != min) {
		this->bottom.min = min;
		this->invalidateOrigin();
	}
}

void
DisplayNode::setMaxBottom(double max)
{
	if (this->bottom.max != max) {
		this->bottom.max = max;
		this->invalidateOrigin();
	}
}

void
DisplayNode::setWidth(DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->width.equals(type, unit, length)) {
		return;
	}

	this->width.type = type;
	this->width.unit = unit;
	this->width.length = length;

	this->invalidateSize();
}

void
DisplayNode::setMinWidth(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->width.min != min) {
		this->width.min = min;
		this->invalidateSize();
	}
}

void
DisplayNode::setMaxWidth(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->width.max != max) {
		this->width.max = max;
		this->invalidateSize();
	}
}

void
DisplayNode::setHeight(DisplayNodeSizeType type, DisplayNodeSizeUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->height.equals(type, unit, length)) {
		return;
	}

	this->height.type = type;
	this->height.unit = unit;
	this->height.length = length;

	this->invalidateSize();
}

void
DisplayNode::setMinHeight(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->height.min != min) {
		this->height.min = min;
		this->invalidateSize();
	}
}

void
DisplayNode::setMaxHeight(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->height.max != max) {
		this->height.max = max;
		this->invalidateSize();
	}
}

void
DisplayNode::setContentDirection(DisplayNodeContentDirection direction)
{
	if (this->contentDirection != direction) {
		this->contentDirection = direction;
		this->invalidateLayout();
	}
}

void
DisplayNode::setContentAlignment(DisplayNodeContentAlignment alignment)
{
	if (this->contentAlignment != alignment) {
		this->contentAlignment = alignment;
		this->invalidateLayout();
	}
}

void
DisplayNode::setContentDisposition(DisplayNodeContentDisposition location)
{
	if (this->contentDisposition != location) {
		this->contentDisposition = location;
		this->invalidateLayout();
	}
}

void
DisplayNode::setContentTop(DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length)
{
    length = clamp(length, ABS_DBL_MIN, ABS_DBL_MAX);

	if (this->contentTop.equals(type, unit, length)) {
		return;
	}

	this->contentTop.type = type;
	this->contentTop.unit = unit;
	this->contentTop.length = length;
	this->measuredContentTop = length; // This is temporary until units other than pixels are available.

	this->invalidateLayout();
}

void
DisplayNode::setContentLeft(DisplayNodeContentOriginType type, DisplayNodeContentOriginUnit unit, double length)
{
    length = clamp(length, ABS_DBL_MIN, ABS_DBL_MAX);

	if (this->contentLeft.equals(type, unit, length)) {
		return;
	}

	this->contentLeft.type = type;
	this->contentLeft.unit = unit;
	this->contentLeft.length = length;
	this->measuredContentLeft = length; // This is temporary until units other than pixels are available.

	this->invalidateLayout();
}

void
DisplayNode::setContentWidth(DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->contentWidth.equals(type, unit, length)) {
		return;
	}

	this->contentWidth.type = type;
	this->contentWidth.unit = unit;
	this->contentWidth.length = length;

	this->invalidateContentSize();
}

void
DisplayNode::setContentHeight(DisplayNodeContentSizeType type, DisplayNodeContentSizeUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->contentHeight.equals(type, unit, length)) {
		return;
	}

	this->contentHeight.type = type;
	this->contentHeight.unit = unit;
	this->contentHeight.length = length;

	this->invalidateContentSize();
}

void
DisplayNode::setExpandFactor(double factor)
{
	if (this->expandFactor != factor) {
		this->expandFactor = factor;
		this->invalidateSize();
	}
}

void
DisplayNode::setShrinkFactor(double factor)
{
	if (this->shrinkFactor != factor) {
		this->shrinkFactor = factor;
		this->invalidateSize();
	}
}

void
DisplayNode::setBorderTop(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->borderTop.equals(type, unit, length)) {
		return;
	}

	this->borderTop.type = type;
    this->borderTop.unit = unit;
    this->borderTop.length = length;

    this->invalidateBorder();
}

void
DisplayNode::setBorderLeft(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->borderLeft.equals(type, unit, length)) {
		return;
	}

	this->borderLeft.type = type;
    this->borderLeft.unit = unit;
    this->borderLeft.length = length;

    this->invalidateBorder();
}

void
DisplayNode::setBorderRight(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->borderRight.equals(type, unit, length)) {
		return;
	}

	this->borderRight.type = type;
	this->borderRight.unit = unit;
	this->borderRight.length = length;

    this->invalidateBorder();
}

void
DisplayNode::setBorderBottom(DisplayNodeBorderType type, DisplayNodeBorderUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->borderBottom.equals(type, unit, length)) {
		return;
	}

	this->borderBottom.type = type;
    this->borderBottom.unit = unit;
    this->borderBottom.length = length;

    this->invalidateBorder();
}

void
DisplayNode::setMarginTop(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
{
	if (this->marginTop.equals(type, unit, length)) {
		return;
	}

	this->marginTop.type = type;
	this->marginTop.unit = unit;
	this->marginTop.length = length;

	this->invalidateMargin();
}

void
DisplayNode::setMarginLeft(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
{
	if (this->marginLeft.equals(type, unit, length)) {
		return;
	}

	this->marginLeft.type = type;
	this->marginLeft.unit = unit;
	this->marginLeft.length = length;

	this->invalidateMargin();
}

void
DisplayNode::setMarginRight(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
{
	if (this->marginRight.equals(type, unit, length)) {
		return;
	}

	this->marginRight.type = type;
	this->marginRight.unit = unit;
	this->marginRight.length = length;

	this->invalidateMargin();
}

void
DisplayNode::setMarginBottom(DisplayNodeMarginType type, DisplayNodeMarginUnit unit, double length)
{
	if (this->marginBottom.equals(type, unit, length)) {
		return;
	}

	this->marginBottom.type = type;
	this->marginBottom.unit = unit;
	this->marginBottom.length = length;

	this->invalidateMargin();
}

void
DisplayNode::setMinMarginTop(double min)
{
	if (this->marginTop.min != min) {
		this->marginTop.min = min;
		this->invalidateMargin();
	}
}

void
DisplayNode::setMaxMarginTop(double max)
{
	if (this->marginTop.max != max) {
		this->marginTop.max = max;
		this->invalidateMargin();
	}
}

void
DisplayNode::setMinMarginLeft(double min)
{
	if (this->marginLeft.min != min) {
		this->marginLeft.min = min;
		this->invalidateMargin();
	}
}

void
DisplayNode::setMaxMarginLeft(double max)
{
	if (this->marginLeft.max != max) {
		this->marginLeft.max = max;
		this->invalidateMargin();
	}
}

void
DisplayNode::setMinMarginRight(double min)
{
	if (this->marginRight.min != min) {
		this->marginRight.min = min;
		this->invalidateMargin();
	}
}

void
DisplayNode::setMaxMarginRight(double max)
{
	if (this->marginRight.max != max) {
		this->marginRight.max = max;
		this->invalidateMargin();
	}
}

void
DisplayNode::setMinMarginBottom(double min)
{
	if (this->marginBottom.min != min) {
		this->marginBottom.min = min;
		this->invalidateMargin();
	}
}

void
DisplayNode::setMaxMarginBottom(double max)
{
	if (this->marginBottom.max != max) {
		this->marginBottom.max = max;
		this->invalidateMargin();
	}
}

void
DisplayNode::setPaddingTop(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->paddingTop.equals(type, unit, length)) {
		return;
	}

	this->paddingTop.type = type;
	this->paddingTop.unit = unit;
	this->paddingTop.length = length;

	this->invalidatePadding();
}

void
DisplayNode::setPaddingLeft(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->paddingLeft.equals(type, unit, length)) {
		return;
	}

	this->paddingLeft.type = type;
	this->paddingLeft.unit = unit;
	this->paddingLeft.length = length;

	this->invalidatePadding();
}

void
DisplayNode::setPaddingRight(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->paddingRight.equals(type, unit, length)) {
		return;
	}

	this->paddingRight.type = type;
	this->paddingRight.unit = unit;
	this->paddingRight.length = length;

	this->invalidatePadding();
}

void
DisplayNode::setPaddingBottom(DisplayNodePaddingType type, DisplayNodePaddingUnit unit, double length)
{
    length = clamp(length, 0, ABS_DBL_MAX);

	if (this->paddingBottom.equals(type, unit, length)) {
		return;
	}

	this->paddingBottom.type = type;
	this->paddingBottom.unit = unit;
	this->paddingBottom.length = length;

	this->invalidatePadding();
}

void
DisplayNode::setMinPaddingTop(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->paddingTop.min != min) {
		this->paddingTop.min = min;
		this->invalidatePadding();
	}
}

void
DisplayNode::setMaxPaddingTop(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->paddingTop.max != max) {
		this->paddingTop.max = max;
		this->invalidatePadding();
	}
}

void
DisplayNode::setMinPaddingLeft(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->paddingLeft.min != min) {
		this->paddingLeft.min = min;
		this->invalidatePadding();
	}
}

void
DisplayNode::setMaxPaddingLeft(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->paddingLeft.max != max) {
		this->paddingLeft.max = max;
		this->invalidatePadding();
	}
}

void
DisplayNode::setMinPaddingRight(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->paddingRight.min != min) {
		this->paddingRight.min = min;
		this->invalidatePadding();
	}
}

void
DisplayNode::setMaxPaddingRight(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->paddingRight.max != max) {
		this->paddingRight.max = max;
		this->invalidatePadding();
	}
}

void
DisplayNode::setMinPaddingBottom(double min)
{
	min = clamp(min, 0, ABS_DBL_MAX);

	if (this->paddingBottom.min != min) {
		this->paddingBottom.min = min;
		this->invalidatePadding();
	}
}

void
DisplayNode::setMaxPaddingBottom(double max)
{
	max = clamp(max, 0, ABS_DBL_MAX);

	if (this->paddingBottom.max != max) {
		this->paddingBottom.max = max;
		this->invalidatePadding();
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
	// TODO
	// Automatically add first-child / last-child state
	
	if (child->parent) {
		throw InvalidStructureException("Cannot insert a child from another tree.");
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

	if (child->name.size())
		child->invalidateTraits(kTraitName);
	if (child->type.size())
		child->invalidateTraits(kTraitType);
	if (child->styles.size())
		child->invalidateTraits(kTraitStyle);
	if (child->states.size())
		child->invalidateTraits(kTraitState);

	this->invalidateLayout();

	const auto w = this->width.type;
	const auto h = this->height.type;

	if (w == kDisplayNodeSizeTypeWrap ||
		h == kDisplayNodeSizeTypeWrap) {
		this->invalidateSize();
		this->invalidateOrigin();
		this->invalidateParent();
	}
}

void
DisplayNode::removeChild(DisplayNode* child)
{
	if (child->parent == nullptr) {
		throw InvalidStructureException("Cannot remove a child.");
	}

	auto it = find(
		this->children.begin(),
		this->children.end(),
		child
	);

	if (it == this->children.end()) {
		return;
	}

	if (child->holder) {
		child->holder->removeEntity(child);
		child->holder = nullptr;
	}

	child->parent = nullptr;

	this->children.erase(it);

	this->invalidateLayout();

	const auto w = this->width.type;
	const auto h = this->height.type;

	if (w == kDisplayNodeSizeTypeWrap ||
		h == kDisplayNodeSizeTypeWrap) {
		this->invalidateSize();
		this->invalidateOrigin();
		this->invalidateParent();
	}
}

void
DisplayNode::resolve()
{
	if (this->resolving) {
		return;
	}

	if (this->display == nullptr) {
		throw InvalidOperationException("Cannot resolve a node who's display is null.");
	}

	if (this->display->resolving == false) {
		this->display->resolve();
		return;
	}

	this->resolving = true;

	this->resolveHolder();
	this->resolveTraits();
	this->resolveLayout();

	this->resolving = false;

	this->invalid = false;
}

void
DisplayNode::measure()
{
	if (this->resolving) {
		return;
	}

	if (this->isWindow()) {
		return;
	}

	if (this->parent == nullptr) {
		return;
	}

	this->inheritedWrappedContentWidth = this->inheritsWrappedWidth();
	this->inheritedWrappedContentHeight = this->inheritsWrappedHeight();

	/*
	 * This method is somewhat a private api. It allows to measure a node
	 * manually without running the whole layout. For this reason, we need
	 * to invoke the measure method for a specific layout type.
	 */

	if (this->isAbsolute()) {

		this->layout.measureAbsoluteNode(this);

	} else {

		const double paddingT = this->parent->measuredPaddingTop;
		const double paddingL = this->parent->measuredPaddingLeft;
		const double paddingR = this->parent->measuredPaddingRight;
		const double paddingB = this->parent->measuredPaddingBottom;

		double remainder = 0;
		double remainingW = max(this->parent->measuredContentWidth - paddingL - paddingR, 0.0);
		double remainingH = max(this->parent->measuredContentHeight - paddingT - paddingB, 0.0);

		this->layout.measureRelativeNode(this, remainingW, remainingH, remainder);
	}

	this->invalidSize = false;
}

string
DisplayNode::toString()
{
	string output;

	if (this->name.length() > 0) {
		output.append("#");
		output.append(this->name);
	}

	output.append("[");
	output.append(this->type);
	output.append("]");

	if (this->styles.size() > 0) {

		output.append(" ");
		output.append("Style: ");

		for (auto & style : this->styles) {
			output.append(style);
			output.append(" ");
		}
	}

	if (this->styles.size() > 0) {

		output.append(" ");
		output.append("State: ");

		for (auto & state : this->states) {
			output.append(state);
			output.append(" ");
		}
	}

	return output;
}

} 
