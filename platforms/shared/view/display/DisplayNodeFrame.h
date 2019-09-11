#ifndef DisplayNodeFrame_h
#define DisplayNodeFrame_h

#include "DisplayBase.h"
#include "DisplayNodeAnchor.h"
#include "DisplayNodeSize.h"
#include "DisplayNodeOrigin.h"
#include "DisplayNodeMargin.h"
#include "DisplayNodeBorder.h"
#include "DisplayNodePadding.h"
#include "DisplayNodeContentSize.h"
#include "DisplayNodeContentOrigin.h"
#include "Layout.h"
#include "RelativeLayout.h"
#include "AbsoluteLayout.h"

namespace View {

class DisplayNode;
class DisplayNodeFrame {

private:

	Layout layout;

	DisplayNode* node = nullptr;

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
	DisplayNodeContentLocation contentLocation = kDisplayNodeContentLocationStart;

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

	bool visible = true;

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

	bool resolving = false;

	bool resolvedSize = false;
	bool resolvedOrigin = false;
	DisplayNode* resolvedParent = nullptr;

	bool wrapContentWidth = false;
	bool wrapContentHeight = false;

   	bool invalidSize = false;
	bool invalidOrigin = false;
	bool invalidMargin = false;
	bool invalidBorder = false;
	bool invalidPadding = false;
	bool invalidInnerSize = false;
	bool invalidContentSize = false;
	bool invalidContentOrigin = false;
	bool invalidLayout = false;

	bool measuredWidthChanged = false;
	bool measuredHeightChanged = false;
	bool measuredInnerWidthChanged = false;
	bool measuredInnerHeightChanged = false;
	bool measuredContentWidthChanged = false;
	bool measuredContentHeightChanged = false;

	void invalidate();

	bool shouldWrapContentWidth();
	bool shouldWrapContentHeight();

protected:

	bool hasInvalidSize();
	bool hasInvalidOrigin();
	bool hasInvalidInnerSize();
	bool hasInvalidContentSize();
	bool hasInvalidMargin();
	bool hasInvalidBorder();
	bool hasInvalidPadding();
	bool hasInvalidLayout();

	void invalidateSize();
	void invalidateOrigin();
	void invalidateInnerSize();
	void invalidateContentSize();
	void invalidateContentOrigin();
	void invalidateMargin();
	void invalidateBorder();
	void invalidatePadding();
	void invalidateLayout();
	void invalidateParent();

	void resolveLayout(bool force = false);
	void resolveMargin();
	void resolveBorder();
	void resolvePadding();
	void resolveInnerSize();
	void resolveContentSize();

	void resolveWrap(double width, double height);

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

	bool hasResolvedParentChange();

public:

	friend class DisplayNode;
	friend class Layout;
	friend class RelativeLayout;
	friend class AbsoluteLayout;

	DisplayNodeFrame(DisplayNode* node);

	~DisplayNodeFrame();

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
	void setContentLocation(DisplayNodeContentLocation placement);

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

	void setVisible(bool visible);

	void resolve();

	bool isRelative();
	bool isAbsolute();
	bool fillsParentWidth();
	bool fillsParentHeight();
	bool wrapsContentWidth();
	bool wrapsContentHeight();

};

} 

#endif 
