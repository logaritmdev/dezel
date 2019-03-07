#ifndef DLRelativeLayout_h
#define DLRelativeLayout_h

#include <vector>
#include "DLLayoutNode.h"

using std::vector;

#define DL_GET_MID_OFFSET(SIZE, CONTAINER) \
	CONTAINER / 2 - SIZE / 2

#define DL_GET_END_OFFSET(SIZE, CONTAINER) \
	CONTAINER - SIZE

/**
 * @function DLRelativeLayoutNodeMeasureWidth
 * @since 0.1.0
 * @hidden
 */
double DLRelativeLayoutNodeMeasureWidth(DLLayoutNodeRef node, double remaining);

/**
 * @function DLRelativeLayoutNodeMeasureHeight
 * @since 0.1.0
 * @hidden
 */
double DLRelativeLayoutNodeMeasureHeight(DLLayoutNodeRef node, double remaining);

/**
 * @function DLRelativeLayoutNodeResolveArrangement
 * @since 0.1.0
 * @hidden
 */
double DLRelativeLayoutNodeResolveArrangement(DLLayoutNodeRef node, double remaining);

/**
 * @function DLRelativeLayoutNodeRoundAndCarry
 * @since 0.1.0
 * @hidden
 */
void DLRelativeLayoutNodeRoundAndCarry(double scale, double &value, double &carry);

/**
 * @function DLRelativeLayoutExpandNodesVertically
 * @since 0.1.0
 * @hidden
 */
void DLRelativeLayoutExpandNodesVertically(const vector<DLLayoutNodeRef> &nodes, double space, double weights);

/**
 * @function DLRelativeLayoutExpandNodesHorizontally
 * @since 0.1.0
 * @hidden
 */
void DLRelativeLayoutExpandNodesHorizontally(const vector<DLLayoutNodeRef> &nodes, double space, double weights);

/**
 * @function DLRelativeLayoutShrinkNodesVertically
 * @since 0.1.0
 * @hidden
 */
void DLRelativeLayoutShrinkNodesVertically(const vector<DLLayoutNodeRef> &nodes, double space, double weights);

/**
 * @function DLRelativeLayoutShrinkNodesHorizontally
 * @since 0.1.0
 * @hidden
 */
void DLRelativeLayoutShrinkNodesHorizontally(const vector<DLLayoutNodeRef> &nodes, double space, double weights);

/**
 * @function DLRelativeLayoutNodeMeasure
 * @since 0.1.0
 * @hidden
 */
void DLRelativeLayoutNodeMeasure(DLLayoutNodeRef node, double &remainingW, double &remainingH, double &remainder);

/**
 * @function DLRelativeLayoutResolve
 * @since 0.1.0
 * @hidden
 */
void DLRelativeLayoutResolve(DLLayoutNodeRef node, const vector<DLLayoutNodeRef> &nodes);

#endif
