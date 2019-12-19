#include "DisplayNode.h"
#include "Display.h"
#include "DisplayNode.h"
#include "DisplayNodeWalker.h"
#include "LayoutResolver.h"
#include "Descriptor.h"
#include "PropertyList.h"
#include "Selector.h"
#include "Fragment.h"
#include "Matcher.h"
#include "Matches.h"
#include "Match.h"
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
using Style::Matches;

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

	if (this->marginTop.unit == kMarginUnitPX &&
		this->marginLeft.unit == kMarginUnitPX &&
		this->marginRight.unit == kMarginUnitPX &&
		this->marginBottom.unit == kMarginUnitPX) {
		return false;
	}

	if (this->parent->measuredInnerWidthChanged) {
		if (this->marginLeft.unit == kMarginUnitPC ||
			this->marginRight.unit == kMarginUnitPC) {
			return true;
		}
	}

	if (this->parent->measuredInnerHeightChanged) {
		if (this->marginTop.unit == kMarginUnitPC ||
			this->marginBottom.unit == kMarginUnitPC) {
			return true;
		}
	}

	if (this->parent->measuredInnerWidthChanged) {
		if (this->marginTop.unit == kMarginUnitPW ||
			this->marginLeft.unit == kMarginUnitPW ||
			this->marginRight.unit == kMarginUnitPW ||
			this->marginBottom.unit == kMarginUnitPW) {
			return true;
		}
	}

	if (this->parent->measuredInnerHeightChanged) {
		if (this->marginTop.unit == kMarginUnitPH ||
			this->marginLeft.unit == kMarginUnitPH ||
			this->marginRight.unit == kMarginUnitPH ||
			this->marginBottom.unit == kMarginUnitPH) {
			return true;
		}
	}

	if (this->parent->measuredContentWidthChanged) {
		if (this->marginTop.unit == kMarginUnitCW ||
			this->marginLeft.unit == kMarginUnitCW ||
			this->marginRight.unit == kMarginUnitCW ||
			this->marginBottom.unit == kMarginUnitCW) {
			return true;
		}
	}

	if (this->parent->measuredContentHeightChanged) {
		if (this->marginTop.unit == kMarginUnitCH ||
			this->marginLeft.unit == kMarginUnitCH ||
			this->marginRight.unit == kMarginUnitCH ||
			this->marginBottom.unit == kMarginUnitCH) {
			return true;
		}
	}

	if (this->display->viewportWidthChanged) {
		if (this->marginTop.unit == kMarginUnitVW ||
			this->marginLeft.unit == kMarginUnitVW ||
			this->marginRight.unit == kMarginUnitVW ||
			this->marginBottom.unit == kMarginUnitVW) {
			return true;
		}
	}

	if (this->display->viewportHeightChanged) {
		if (this->marginTop.unit == kMarginUnitVH ||
			this->marginLeft.unit == kMarginUnitVH ||
			this->marginRight.unit == kMarginUnitVH ||
			this->marginBottom.unit == kMarginUnitVH) {
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

	if (this->borderTop.unit == kBorderUnitPX &&
		this->borderLeft.unit == kBorderUnitPX &&
		this->borderRight.unit == kBorderUnitPX &&
		this->borderBottom.unit == kBorderUnitPX) {
		return false;
	}

	if (this->measuredWidthChanged) {
		if (this->borderLeft.unit == kBorderUnitPC ||
			this->borderRight.unit == kBorderUnitPC) {
			return true;
		}
	}

	if (this->measuredHeightChanged) {
		if (this->borderTop.unit == kBorderUnitPC ||
			this->borderBottom.unit == kBorderUnitPC) {
			return true;
		}
	}

	if (this->parent->measuredInnerWidthChanged) {
		if (this->borderTop.unit == kBorderUnitPW ||
			this->borderLeft.unit == kBorderUnitPW ||
			this->borderRight.unit == kBorderUnitPW ||
			this->borderBottom.unit == kBorderUnitPW) {
			return true;
		}
	}

	if (this->parent->measuredInnerHeightChanged) {
		if (this->borderTop.unit == kBorderUnitPH ||
			this->borderLeft.unit == kBorderUnitPH ||
			this->borderRight.unit == kBorderUnitPH ||
			this->borderBottom.unit == kBorderUnitPH) {
			return true;
		}
	}

	if (this->parent->measuredContentWidthChanged) {
		if (this->borderTop.unit == kBorderUnitCW ||
			this->borderLeft.unit == kBorderUnitCW ||
			this->borderRight.unit == kBorderUnitCW ||
			this->borderBottom.unit == kBorderUnitCW) {
			return true;
		}
	}

	if (this->parent->measuredContentHeightChanged) {
		if (this->borderTop.unit == kBorderUnitCH ||
			this->borderLeft.unit == kBorderUnitCH ||
			this->borderRight.unit == kBorderUnitCH ||
			this->borderBottom.unit == kBorderUnitCH) {
			return true;
		}
	}

	if (this->display->viewportWidthChanged) {
		if (this->borderTop.unit == kBorderUnitVW ||
			this->borderLeft.unit == kBorderUnitVW ||
			this->borderRight.unit == kBorderUnitVW ||
			this->borderBottom.unit == kBorderUnitVW) {
			return true;
		}
	}

	if (this->display->viewportHeightChanged) {
		if (this->borderTop.unit == kBorderUnitVH ||
			this->borderLeft.unit == kBorderUnitVW ||
			this->borderRight.unit == kBorderUnitVW ||
			this->borderBottom.unit == kBorderUnitVW) {
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

	if (this->contentWidth.type == kContentSizeTypeAuto &&
		this->contentHeight.type == kContentSizeTypeAuto) {
		return false;
	}

	if (this->contentWidth.unit == kContentSizeUnitPX &&
		this->contentHeight.unit == kContentSizeUnitPX) {
		return false;
	}

	if (this->measuredInnerWidthChanged &&
		this->contentWidth.unit == kContentSizeUnitPC) {
		return true;
	}

	if (this->measuredInnerHeightChanged &&
		this->contentHeight.unit == kContentSizeUnitPC) {
		return true;
	}

	if (this->parent->measuredInnerWidthChanged) {
		if (this->contentWidth.unit == kContentSizeUnitPW ||
			this->contentHeight.unit == kContentSizeUnitPW) {
			return true;
		}
	}

	if (this->parent->measuredInnerHeightChanged) {
		if (this->contentWidth.unit == kContentSizeUnitPH ||
			this->contentHeight.unit == kContentSizeUnitPH) {
			return true;
		}
	}

	if (this->parent->measuredContentWidthChanged) {
		if (this->contentWidth.unit == kContentSizeUnitCW ||
			this->contentHeight.unit == kContentSizeUnitCW) {
			return true;
		}
	}

	if (this->parent->measuredContentHeightChanged) {
		if (this->contentWidth.unit == kContentSizeUnitCH ||
			this->contentHeight.unit == kContentSizeUnitCH) {
			return true;
		}
	}

	if (this->display->viewportWidthChanged) {
		if (this->contentWidth.unit == kContentSizeUnitVW ||
			this->contentHeight.unit == kContentSizeUnitVW) {
			return true;
		}
	}

	if (this->display->viewportHeightChanged) {
		if (this->contentWidth.unit == kContentSizeUnitVH ||
			this->contentHeight.unit == kContentSizeUnitVH) {
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

	if (this->paddingTop.unit == kPaddingUnitPX &&
		this->paddingLeft.unit == kPaddingUnitPX &&
		this->paddingRight.unit == kPaddingUnitPX &&
		this->paddingBottom.unit == kPaddingUnitPX) {
		return false;
	}

	if (this->measuredInnerWidthChanged) {
		if (this->paddingLeft.unit == kPaddingUnitPC ||
			this->paddingRight.unit == kPaddingUnitPC) {
			return true;
		}
	}

	if (this->measuredInnerHeightChanged) {
		if (this->paddingTop.unit == kPaddingUnitPC ||
			this->paddingBottom.unit == kPaddingUnitPC) {
			return true;
		}
	}

	if (this->parent->measuredInnerWidthChanged) {
		if (this->paddingTop.unit == kPaddingUnitPW ||
			this->paddingLeft.unit == kPaddingUnitPW ||
			this->paddingRight.unit == kPaddingUnitPW ||
			this->paddingBottom.unit == kPaddingUnitPW) {
			return true;
		}
	}

	if (this->parent->measuredInnerHeightChanged) {
		if (this->paddingTop.unit == kPaddingUnitPH ||
			this->paddingLeft.unit == kPaddingUnitPH ||
			this->paddingRight.unit == kPaddingUnitPH ||
			this->paddingBottom.unit == kPaddingUnitPH) {
			return true;
		}
	}

	if (this->parent->measuredContentWidthChanged) {
		if (this->paddingTop.unit == kPaddingUnitCW ||
			this->paddingLeft.unit == kPaddingUnitCW ||
			this->paddingRight.unit == kPaddingUnitCW ||
			this->paddingBottom.unit == kPaddingUnitCW) {
			return true;
		}
	}

	if (this->parent->measuredContentHeightChanged) {
		if (this->paddingTop.unit == kPaddingUnitCH ||
			this->paddingLeft.unit == kPaddingUnitCH ||
			this->paddingRight.unit == kPaddingUnitCH ||
			this->paddingBottom.unit == kPaddingUnitCH) {
			return true;
		}
	}

	if (this->display->viewportWidthChanged) {
		if (this->paddingTop.unit == kPaddingUnitVW ||
			this->paddingLeft.unit == kPaddingUnitVW ||
			this->paddingRight.unit == kPaddingUnitVW ||
			this->paddingBottom.unit == kPaddingUnitVW) {
			return true;
		}
	}

	if (this->display->viewportHeightChanged) {
		if (this->paddingTop.unit == kPaddingUnitVH ||
			this->paddingLeft.unit == kPaddingUnitVH ||
			this->paddingRight.unit == kPaddingUnitVH ||
			this->paddingBottom.unit == kPaddingUnitVH) {
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
		this->didInvalidate();
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

	if (parentW.type == kSizeTypeWrap ||
		parentH.type == kSizeTypeWrap) {

		parent->invalidateSize();
		parent->invalidateOrigin();

		vector<DisplayNode*> path;
		DisplayNode* last = nullptr;
		DisplayNode* node = parent;

		while (node != nullptr) {

			node = node->parent;

			if (node) {

				const auto w = width;
				const auto h = height;

				if (w.type != kSizeTypeWrap && h.type != kSizeTypeWrap &&
					w.type != kSizeTypeFill && h.type != kSizeTypeFill) {
					break;
				}

				this->invalidateSize();
				this->invalidateOrigin();
				this->invalidateLayout();

				if (w.type == kSizeTypeWrap ||
					h.type == kSizeTypeWrap) {
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
DisplayNode::invalidateTraits()
{
	if (this->invalidTraits == false) {
		this->invalidTraits = true;
		this->invalidate();
	}
}

void
DisplayNode::invalidateStyleTraits()
{
	if (this->invalidStyleTraits == false) {
		this->invalidStyleTraits = true;
		this->invalidateTraits();
	}
}

void
DisplayNode::invalidateStateTraits()
{
	if (this->invalidStateTraits == false) {
		this->invalidStateTraits = true;
		this->invalidateTraits();
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

	if (l == kOriginTypeLength &&
		r == kOriginTypeLength) {
		return false;
	}

	if (w == kSizeTypeWrap) {
		return true;
	}

	if (w == kSizeTypeFill) {

		auto node = this->parent;

		while (node) {

			if (node->width.type == kSizeTypeFill) {
				node = node->parent;
				continue;
			}

			if (node->width.type == kSizeTypeWrap) {
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

	if (t == kOriginTypeLength &&
		b == kOriginTypeLength) {
		return false;
	}

	if (h == kSizeTypeWrap) {
		return true;
	}

	if (h == kSizeTypeFill) {

		auto node = this->parent;

		while (node) {

			if (node->height.type == kSizeTypeFill) {
				node = node->parent;
				continue;
			}

			if (node->height.type == kSizeTypeWrap) {
				return true;
			}

			return false;
		}
	}

	return false;
}

void
DisplayNode::resolveTraits()
{
	if (this->display->stylesheet == nullptr) {
		return;
	}

	if (this->invalidTraits == false) {
		return;
	}

	Matches matches;
	Matcher matcher;

	matcher.match(this, matches, this->display->stylesheet->getRuleDescriptors());
	matches.order();

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

	if (this->invalidStyleTraits ||
		this->invalidStateTraits) {

		/*
		 * TODO
		 * There is an optimization to be done here. First, there's no need
		 * to invalidate the tree if none of the matched styles have child
		 * descriptors..
		 */

		DisplayNodeWalker walker(this);

		while (walker.hasNext()) {
			walker.getNode()->invalidateTraits();
			walker.getNext();
		}
	}

	this->invalidTraits = false;
	this->invalidStyleTraits = false;
	this->invalidStateTraits = false;
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

			if (this->width.type != kSizeTypeLength ||
				this->width.unit != kSizeUnitPX) {
				throw InvalidOperationException("The root node size must be specified in pixels.");
			}

			if (this->height.type != kSizeTypeLength ||
				this->height.unit != kSizeUnitPX) {
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

	MeasuredSize size;
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

		this->contentAlignment = kContentAlignmentStart;
		this->contentDisposition = kContentDispositionStart;

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

	if (this->anchorTop.type == kAnchorTypeLength) {

		value = this->anchorTop.length;

		switch (this->anchorTop.unit) {
			case kAnchorUnitPC: value = scale(value, this->measuredHeight); break;
			default: break;
		}
	}

	return round(value, this->display->scale);
}

double
DisplayNode::measureAnchorLeft()
{
	double value = 0;

	if (this->anchorLeft.type == kAnchorTypeLength) {

		value = this->anchorLeft.length;

		switch (this->anchorLeft.unit) {
			case kAnchorUnitPC: value = scale(value, this->measuredWidth); break;
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

	if (type == kBorderTypeLength) {

		switch (unit) {

			case kBorderUnitPC: value = scale(value, this->measuredHeight); break;
			case kBorderUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kBorderUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kBorderUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kBorderUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kBorderUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kBorderUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kBorderTypeLength) {

		switch (unit) {

			case kBorderUnitPC: value = scale(value, this->measuredWidth); break;
			case kBorderUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kBorderUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kBorderUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kBorderUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kBorderUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kBorderUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kBorderTypeLength) {

		switch (unit) {

			case kBorderUnitPC: value = scale(value, this->measuredWidth); break;
			case kBorderUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kBorderUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kBorderUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kBorderUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kBorderUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kBorderUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kBorderTypeLength) {

		switch (unit) {

			case kBorderUnitPC: value = scale(value, this->measuredHeight); break;
			case kBorderUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kBorderUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kBorderUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kBorderUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kBorderUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kBorderUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kMarginTypeLength) {

		switch (unit) {

			case kMarginUnitPC: value = scale(value, this->parent->measuredContentHeight); break;
			case kMarginUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kMarginUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kMarginUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kMarginUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kMarginUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kMarginUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kMarginTypeLength) {

		switch (unit) {

			case kMarginUnitPC: value = scale(value, this->parent->measuredContentWidth); break;
			case kMarginUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kMarginUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kMarginUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kMarginUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kMarginUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kMarginUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kMarginTypeLength) {

		switch (unit) {

			case kMarginUnitPC: value = scale(value, this->parent->measuredContentWidth); break;
			case kMarginUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kMarginUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kMarginUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kMarginUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kMarginUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kMarginUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kMarginTypeLength) {

		switch (unit) {

			case kMarginUnitPC: value = scale(value, this->parent->measuredContentHeight); break;
			case kMarginUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kMarginUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kMarginUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kMarginUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kMarginUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kMarginUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kPaddingTypeLength) {

		switch (unit) {

			case kPaddingUnitPC: value = scale(value, this->measuredInnerHeight); break;
			case kPaddingUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kPaddingUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kPaddingUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kPaddingUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kPaddingUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kPaddingUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kPaddingTypeLength) {

		switch (unit) {

			case kPaddingUnitPC: value = scale(value, this->measuredInnerWidth); break;
			case kPaddingUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kPaddingUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kPaddingUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kPaddingUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kPaddingUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kPaddingUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kPaddingTypeLength) {

		switch (unit) {

			case kPaddingUnitPC: value = scale(value, this->measuredInnerWidth); break;
			case kPaddingUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kPaddingUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kPaddingUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kPaddingUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kPaddingUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kPaddingUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kPaddingTypeLength) {

		switch (unit) {

			case kPaddingUnitPC: value = scale(value, this->measuredInnerHeight); break;
			case kPaddingUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kPaddingUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kPaddingUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kPaddingUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kPaddingUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kPaddingUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kContentSizeTypeAuto) {

		value = this->measuredInnerWidth;

	} else {

		switch (unit) {

			case kContentSizeUnitPC: value = scale(value, this->measuredInnerWidth); break;
			case kContentSizeUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kContentSizeUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kContentSizeUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kContentSizeUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kContentSizeUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kContentSizeUnitVH: value = scale(value, this->display->viewportHeight); break;
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

	if (type == kContentSizeTypeAuto) {

		value = this->measuredInnerHeight;

	} else {

		switch (unit) {

			case kContentSizeUnitPC: value = scale(value, this->measuredInnerHeight); break;
			case kContentSizeUnitPW: value = scale(value, this->parent ? this->parent->measuredInnerWidth : 0); break;
			case kContentSizeUnitPH: value = scale(value, this->parent ? this->parent->measuredInnerHeight : 0); break;
			case kContentSizeUnitCW: value = scale(value, this->parent ? this->parent->measuredContentWidth : 0); break;
			case kContentSizeUnitCH: value = scale(value, this->parent ? this->parent->measuredContentHeight : 0); break;
			case kContentSizeUnitVW: value = scale(value, this->display->viewportWidth); break;
			case kContentSizeUnitVH: value = scale(value, this->display->viewportHeight); break;
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
		this->invalidateTraits();
	}
}

void
DisplayNode::setType(string type)
{
	if (this->type != type) {
		this->type = type;
		this->explode(type);
		this->invalidateTraits();
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

	this->invalidateStyleTraits();
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

	this->invalidateStyleTraits();
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

	this->invalidateStateTraits();
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

	this->invalidateStateTraits();
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
DisplayNode::setAnchorTop(AnchorType type, AnchorUnit unit, double length)
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
DisplayNode::setAnchorLeft(AnchorType type, AnchorUnit unit, double length)
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
DisplayNode::setTop(OriginType type, OriginUnit unit, double length)
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
DisplayNode::setLeft(OriginType type, OriginUnit unit, double length)
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
DisplayNode::setRight(OriginType type, OriginUnit unit, double length)
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
DisplayNode::setBottom(OriginType type, OriginUnit unit, double length)
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
DisplayNode::setWidth(SizeType type, SizeUnit unit, double length)
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
DisplayNode::setHeight(SizeType type, SizeUnit unit, double length)
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
DisplayNode::setContentDirection(ContentDirection direction)
{
	if (this->contentDirection != direction) {
		this->contentDirection = direction;
		this->invalidateLayout();
	}
}

void
DisplayNode::setContentAlignment(ContentAlignment alignment)
{
	if (this->contentAlignment != alignment) {
		this->contentAlignment = alignment;
		this->invalidateLayout();
	}
}

void
DisplayNode::setContentDisposition(ContentDisposition location)
{
	if (this->contentDisposition != location) {
		this->contentDisposition = location;
		this->invalidateLayout();
	}
}

void
DisplayNode::setContentTop(ContentOriginType type, ContentOriginUnit unit, double length)
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
DisplayNode::setContentLeft(ContentOriginType type, ContentOriginUnit unit, double length)
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
DisplayNode::setContentWidth(ContentSizeType type, ContentSizeUnit unit, double length)
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
DisplayNode::setContentHeight(ContentSizeType type, ContentSizeUnit unit, double length)
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
DisplayNode::setBorderTop(BorderType type, BorderUnit unit, double length)
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
DisplayNode::setBorderLeft(BorderType type, BorderUnit unit, double length)
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
DisplayNode::setBorderRight(BorderType type, BorderUnit unit, double length)
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
DisplayNode::setBorderBottom(BorderType type, BorderUnit unit, double length)
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
DisplayNode::setMarginTop(MarginType type, MarginUnit unit, double length)
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
DisplayNode::setMarginLeft(MarginType type, MarginUnit unit, double length)
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
DisplayNode::setMarginRight(MarginType type, MarginUnit unit, double length)
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
DisplayNode::setMarginBottom(MarginType type, MarginUnit unit, double length)
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
DisplayNode::setPaddingTop(PaddingType type, PaddingUnit unit, double length)
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
DisplayNode::setPaddingLeft(PaddingType type, PaddingUnit unit, double length)
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
DisplayNode::setPaddingRight(PaddingType type, PaddingUnit unit, double length)
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
DisplayNode::setPaddingBottom(PaddingType type, PaddingUnit unit, double length)
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

	this->invalidateLayout();

	const auto w = this->width.type;
	const auto h = this->height.type;

	if (w == kSizeTypeWrap ||
		h == kSizeTypeWrap) {
		this->invalidateSize();
		this->invalidateOrigin();
		this->invalidateParent();
	}

	child->invalidateTraits();
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

	child->parent = nullptr;

	this->children.erase(it);

	this->invalidateLayout();

	const auto w = this->width.type;
	const auto h = this->height.type;

	if (w == kSizeTypeWrap ||
		h == kSizeTypeWrap) {
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

	this->resolveTraits();

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

	this->lastMeasuredWidth = this->measuredWidth;
	this->lastMeasuredHeight = this->measuredHeight;

	this->didResolveSize();

	this->invalidSize = false;
}

void
DisplayNode::reset()
{
	for (auto property : this->properties) {
		this->update(property->getName(), nullptr);
	}

	this->properties.clear();
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
