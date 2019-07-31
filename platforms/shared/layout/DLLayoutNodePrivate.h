#ifndef DLLayoutNodePrivate_h
#define DLLayoutNodePrivate_h

#include <vector>
#include <string>
#include <stddef.h>
#include "DLLayoutNode.h"

using std::string;
using std::vector;

#define DL_IS_ABSOLUTE(NODE, KEY) NODE->KEY.type == kDLLayoutPositionTypeLength
#define DL_IS_RELATIVE(NODE, KEY) NODE->KEY.type == kDLLayoutPositionTypeAuto

#define DL_FILTER_ANCHOR(TYPE, UNIT, LENGTH) \
	if (TYPE != kDLLayoutAnchorTypeLength) { \
		UNIT = kDLLayoutAnchorUnitPC; \
		LENGTH = 0; \
	}

#define DL_FILTER_POSITION(TYPE, UNIT, LENGTH) \
	if (TYPE != kDLLayoutPositionTypeLength) { \
		UNIT = kDLLayoutPositionUnitNone; \
		LENGTH = 0; \
	}

#define DL_FILTER_SIZE(TYPE, UNIT, LENGTH) \
	if (TYPE != kDLLayoutSizeTypeLength) { \
		UNIT = kDLLayoutSizeUnitNone; \
		LENGTH = 0; \
	}

#define DL_FILTER_CONTENT_SIZE(TYPE, UNIT, LENGTH) \
	if (TYPE != kDLLayoutContentSizeTypeLength) { \
		UNIT = kDLLayoutContentSizeUnitNone; \
		LENGTH = 0; \
	}

#define DL_CLAMP(VALUE, MIN, MAX) \
	if (VALUE < MIN) VALUE = MIN; \
	if (VALUE > MAX) VALUE = MAX;

#define DL_LAYOUT_CONTEXT_INVOKE(CONTEXT, CALLBACK) \
	if (CONTEXT->CALLBACK) CONTEXT->CALLBACK(CONTEXT);

#define DL_LAYOUT_NODE_INVOKE(NODE, CALLBACK) \
	if (NODE->CALLBACK) NODE->CALLBACK(NODE);

#define DL_LAYOUT_TIMER_START(NAME) \
	high_resolution_clock::time_point NAME##_1 = high_resolution_clock::now();

#define DL_LAYOUT_TIMER_STOP(NAME, RESULT) \
	high_resolution_clock::time_point NAME##_2 = high_resolution_clock::now(); \
	auto RESULT = duration_cast<microseconds>(NAME##_2 - NAME##_1).count(); \

#define DL_REL(VALUE, BASE) VALUE = (VALUE) / 100 * (BASE)

//------------------------------------------------------------------------------
// Structures
//------------------------------------------------------------------------------

/**
 * @struct OpaqueDLLayoutAnchor
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLLayoutAnchor {
	DLLayoutAnchorType type = kDLLayoutAnchorTypeLength;
	DLLayoutAnchorUnit unit = kDLLayoutAnchorUnitPC;
	double length = 0;
};

/**
 * @struct OpaqueDLLayoutPosition
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLLayoutPosition {
	DLLayoutPositionType type = kDLLayoutPositionTypeAuto;
	DLLayoutPositionUnit unit = kDLLayoutPositionUnitNone;
	double length = 0;
	double min = ABS_DBL_MIN;
	double max = ABS_DBL_MAX;
};

/**
 * @struct OpaqueDLLayoutSize
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLLayoutSize {
	DLLayoutSizeType type = kDLLayoutSizeTypeFill;
	DLLayoutSizeUnit unit = kDLLayoutSizeUnitNone;
	double length = 0;
	double min = 0;
	double max = ABS_DBL_MAX;
};

/**
 * @typedef OpaqueDLLayoutContentPosition
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLLayoutContentPosition {
	DLLayoutContentPositionType type = kDLLayoutContentPositionTypeLength;
	DLLayoutContentPositionUnit unit = kDLLayoutContentPositionUnitNone;
	double length = 0;
};

/**
 * @typedef OpaqueDLLayoutContentSize
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLLayoutContentSize {
	DLLayoutContentSizeType type = kDLLayoutContentSizeTypeAuto;
	DLLayoutContentSizeUnit unit = kDLLayoutContentSizeUnitNone;
	double length = 0;
};

/**
 * @struct OpaqueDLLayoutBorder
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLLayoutBorder {
    DLLayoutBorderType type = kDLLayoutBorderTypeLength;
    DLLayoutBorderUnit unit = kDLLayoutBorderUnitPX;
    double length = 0;
    double min = 0;
    double max = ABS_DBL_MAX;
};

/**
 * @struct OpaqueDLLayoutMargin
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLLayoutMargin {
	DLLayoutMarginType type = kDLLayoutMarginTypeLength;
	DLLayoutMarginUnit unit = kDLLayoutMarginUnitPX;
	double length = 0;
	double min = ABS_DBL_MIN;
	double max = ABS_DBL_MAX;
};

/**
 * @struct OpaqueDLLayoutPadding
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLLayoutPadding {
	DLLayoutPaddingType type = kDLLayoutPaddingTypeLength;
	DLLayoutPaddingUnit unit = kDLLayoutPaddingUnitPX;
	double length = 0;
	double min = 0;
	double max = ABS_DBL_MAX;
};

/**
 * @const kDLLayoutAnchorDefault
 * @since 0.1.0
 * @hidden
 */
const OpaqueDLLayoutAnchor kDLLayoutAnchorDefault;

/**
 * @const kDLLayoutPositionDefault
 * @since 0.1.0
 * @hidden
 */
const OpaqueDLLayoutPosition kDLLayoutPositionDefault;

/**
 * @const kDLLayoutSizeDefault
 * @since 0.1.0
 * @hidden
 */
const OpaqueDLLayoutSize kDLLayoutSizeDefault;

/**
 * @const kDLLayoutContentPositionDefault
 * @since 0.1.0
 * @hidden
 */
const OpaqueDLLayoutContentPosition kDLLayoutContentPositionDefault;

/**
 * @const kDLLayoutContentSizeDefault
 * @since 0.1.0
 * @hidden
 */
const OpaqueDLLayoutContentSize kDLLayoutContentSizeDefault;

/**
 * @const OpaqueDLLayoutBorder
 * @since 0.1.0
 * @hidden
 */
const OpaqueDLLayoutBorder kDLLayoutBorderDefault;

/**
 * @const kDLLayoutMarginDefault
 * @since 0.1.0
 * @hidden
 */
const OpaqueDLLayoutMargin kDLLayoutMarginDefault;

/**
 * @const kDLLayoutPaddingDefault
 * @since 0.1.0
 * @hidden
 */
const OpaqueDLLayoutPadding kDLLayoutPaddingDefault;

/**
 * @struct OpaqueDLLayout
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLLayoutNode {

	string id = "";

	DLLayoutRef layout = NULL;
	DLLayoutNodeRef parent = NULL;
    vector<DLLayoutNodeRef> children;

	bool root = false;

    DLLayoutAnchor anchorTop = kDLLayoutAnchorDefault;
	DLLayoutAnchor anchorLeft = kDLLayoutAnchorDefault;
	DLLayoutPosition top = kDLLayoutPositionDefault;
	DLLayoutPosition left = kDLLayoutPositionDefault;
	DLLayoutPosition right = kDLLayoutPositionDefault;
	DLLayoutPosition bottom = kDLLayoutPositionDefault;
	DLLayoutSize width = kDLLayoutSizeDefault;
	DLLayoutSize height = kDLLayoutSizeDefault;
	DLLayoutContentOrientation contentOrientation = kDLLayoutContentOrientationVertical;
	DLLayoutContentLocation contentLocation = kDLLayoutContentLocationStart;
	DLLayoutContentArrangement contentArrangement = kDLLayoutContentArrangementStart;
	DLLayoutContentPosition contentTop = kDLLayoutContentPositionDefault;
	DLLayoutContentPosition contentLeft = kDLLayoutContentPositionDefault;
	DLLayoutContentSize contentWidth = kDLLayoutContentSizeDefault;
	DLLayoutContentSize contentHeight = kDLLayoutContentSizeDefault;
    DLLayoutBorder borderTop = kDLLayoutBorderDefault;
    DLLayoutBorder borderLeft = kDLLayoutBorderDefault;
    DLLayoutBorder borderRight = kDLLayoutBorderDefault;
    DLLayoutBorder borderBottom = kDLLayoutBorderDefault;
	DLLayoutMargin marginTop = kDLLayoutMarginDefault;
	DLLayoutMargin marginLeft = kDLLayoutMarginDefault;
	DLLayoutMargin marginRight = kDLLayoutMarginDefault;
	DLLayoutMargin marginBottom = kDLLayoutMarginDefault;
	DLLayoutPadding paddingTop = kDLLayoutPaddingDefault;
	DLLayoutPadding paddingLeft = kDLLayoutPaddingDefault;
	DLLayoutPadding paddingRight = kDLLayoutPaddingDefault;
	DLLayoutPadding paddingBottom = kDLLayoutPaddingDefault;

    double expand = 0;
	double shrink = 0;

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

	double extentTop = 0;
	double extentLeft = 0;
	double extentRight = 0;
	double extentBottom = 0;

    bool layouting = false;
   	bool resolving = false;
    bool processing = false;

	bool relayout = false;
	bool relayoutNeeded = false;

	bool resolvedSize = false;
	bool resolvedPosition = false;
	DLLayoutNodeRef resolvedParent = NULL;

	bool measuredWidthUpdated = false;
	bool measuredHeightUpdated = false;
	bool measuredInnerWidthUpdated = false;
	bool measuredInnerHeightUpdated = false;
	bool measuredContentWidthUpdated = false;
	bool measuredContentHeightUpdated = false;

   	bool invalidSize = false;
	bool invalidPosition = false;
	bool invalidInnerSize = false;
	bool invalidContentSize = false;
	bool invalidContentPosition = false;
	bool invalidMargin = false;
	bool invalidBorder = false;
	bool invalidPadding = false;
	bool invalidLayout = false;

	bool isWrappingWidth = false;
	bool isWrappingHeight = false;

	DLLayoutNodePrepareCallback prepareCallback = NULL;
	DLLayoutNodeMeasureCallback measureCallback = NULL;
	DLLayoutNodeResolveCallback resolveSizeCallback = NULL;
    DLLayoutNodeResolveCallback resolvePositionCallback = NULL;
	DLLayoutNodeResolveCallback resolveInnerSizeCallback = NULL;
	DLLayoutNodeResolveCallback resolveContentSizeCallback = NULL;
	DLLayoutNodeResolveCallback resolveMarginCallback = NULL;
    DLLayoutNodeResolveCallback resolveBorderCallback = NULL;
    DLLayoutNodeResolveCallback resolvePaddingCallback = NULL;
   	DLLayoutNodeBeganCallback layoutBeganCallback = NULL;
    DLLayoutNodeEndedCallback layoutEndedCallback = NULL;
    DLLayoutNodeInvalidateCallback invalidateCallback = NULL;

	void *data = NULL;

	// TODO IFDEF TEST ONLY
	int resolveSizeCount = 0;
	int resolvePositionCount = 0;
};

//------------------------------------------------------------------------------
// Functions
//------------------------------------------------------------------------------

double DLLayoutNodeMeasureBorderTop(DLLayoutNodeRef node);
double DLLayoutNodeMeasureBorderLeft(DLLayoutNodeRef node);
double DLLayoutNodeMeasureBorderRight(DLLayoutNodeRef node);
double DLLayoutNodeMeasureBorderBottom(DLLayoutNodeRef node);
double DLLayoutNodeMeasureMarginTop(DLLayoutNodeRef node);
double DLLayoutNodeMeasureMarginLeft(DLLayoutNodeRef node);
double DLLayoutNodeMeasureMarginRight(DLLayoutNodeRef node);
double DLLayoutNodeMeasureMarginBottom(DLLayoutNodeRef node);
double DLLayoutNodeMeasurePaddingTop(DLLayoutNodeRef node);
double DLLayoutNodeMeasurePaddingLeft(DLLayoutNodeRef node);
double DLLayoutNodeMeasurePaddingRight(DLLayoutNodeRef node);
double DLLayoutNodeMeasurePaddingBottom(DLLayoutNodeRef node);
double DLLayoutNodeMeasureInnerWidth(DLLayoutNodeRef node);
double DLLayoutNodeMeasureInnerHeight(DLLayoutNodeRef node);
double DLLayoutNodeMeasureContentWidth(DLLayoutNodeRef node);
double DLLayoutNodeMeasureContentHeight(DLLayoutNodeRef node);
double DLLayoutNodeMeasureAnchorTop(DLLayoutNodeRef node);
double DLLayoutNodeMeasureAnchorLeft(DLLayoutNodeRef node);
void DLLayoutNodeMeasureWrappedLayout(DLLayoutNodeRef node, double &w, double &h);
void DLLayoutNodeLayoutWrappedLayout(DLLayoutNodeRef node);
void DLLayoutNodeInvalidate(DLLayoutNodeRef node);
void DLLayoutNodeResolveInnerSize(DLLayoutNodeRef node);
void DLLayoutNodeResolveContentSize(DLLayoutNodeRef node);
void DLLayoutNodeResolveMargin(DLLayoutNodeRef node);
void DLLayoutNodeResolveBorder(DLLayoutNodeRef node);
void DLLayoutNodeResolvePadding(DLLayoutNodeRef node);
bool DLLayoutNodeInvalidInnerSize(DLLayoutNodeRef node);
bool DLLayoutNodeInvalidContentSize(DLLayoutNodeRef node);
bool DLLayoutNodeInvalidMargin(DLLayoutNodeRef node);
bool DLLayoutNodeInvalidBorder(DLLayoutNodeRef node);
bool DLLayoutNodeInvalidPadding(DLLayoutNodeRef node);
bool DLLayoutNodeShouldWrapWidth(DLLayoutNodeRef node);
bool DLLayoutNodeShouldWrapHeight(DLLayoutNodeRef node);

#endif
