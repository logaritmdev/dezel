#ifndef DLAbsoluteLayout_h
#define DLAbsoluteLayout_h

#include <vector>
#include <iostream>
#include "DLLayoutNode.h"

using std::vector;
using std::cerr;

/**
 * @function DLAbsoluteLayoutNodeInvalidSize
 * @since 0.1.0
 * @hidden
 */
bool DLAbsoluteLayoutNodeInvalidSize(DLLayoutNodeRef node);

/**
 * @function DLAbsoluteLayoutNodeInvalidPosition
 * @since 0.1.0
 * @hidden
 */
bool DLAbsoluteLayoutNodeInvalidPosition(DLLayoutNodeRef node);

/**
 * @function DLAbsoluteLayoutNodeMeasureTop
 * @since 0.1.0
 * @hidden
 */
double DLAbsoluteLayoutNodeMeasureTop(DLLayoutNodeRef node);

/**
 * @function DLAbsoluteLayoutNodeMeasureLeft
 * @since 0.1.0
 * @hidden
 */
double DLAbsoluteLayoutNodeMeasureLeft(DLLayoutNodeRef node);

/**
 * @function DLAbsoluteLayoutNodeMeasureRight
 * @since 0.1.0
 * @hidden
 */
double DLAbsoluteLayoutNodeMeasureRight(DLLayoutNodeRef node);

/**
 * @function DLAbsoluteLayoutNodeMeasureBottom
 * @since 0.1.0
 * @hidden
 */
double DLAbsoluteLayoutNodeMeasureBottom(DLLayoutNodeRef node);

/**
 * @function DLAbsoluteLayoutNodeMeasureWidth
 * @since 0.1.0
 * @hidden
 */
double DLAbsoluteLayoutNodeMeasureWidth(DLLayoutNodeRef node);

/**
 * @function DLAbsoluteLayoutNodeMeasureHeight
 * @since 0.1.0
 * @hidden
 */
double DLAbsoluteLayoutNodeMeasureHeight(DLLayoutNodeRef node);

/**
 * @function DLAbsoluteLayoutNodeMeasure
 * @since 0.1.0
 * @hidden
 */
void DLAbsoluteLayoutNodeMeasure(DLLayoutNodeRef node);

/**
 * @function DLRelativeLayoutResolve
 * @since 0.1.0
 * @hidden
 */
void DLAbsoluteLayoutResolve(DLLayoutNodeRef node, const vector<DLLayoutNodeRef> &nodes);

#endif
