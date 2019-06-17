#ifndef DLStylerNode_h
#define DLStylerNode_h

#include <stddef.h>
#include "DLStyler.h"
#include "DLStylerStyleItem.h"

/**
 * @typedef DLStylerNodeRef
 * @since 0.1.0
 */
typedef struct OpaqueDLStylerNode* DLStylerNodeRef;

/**
 * The callback when styles are invalidated.
 * @typedef DLStylerNodeInvalidateCallback
 * @since 0.1.0
 */
typedef void (*DLStylerNodeInvalidateCallback)(DLStylerNodeRef node);

/**
 * The callback when styles needs to be applied.
 * @typedef DLStylerNodeResolveCallback
 * @since 0.1.0
 */
typedef void (*DLStylerNodeApplyCallback)(DLStylerNodeRef node, DLStylerStyleItemRef item);

/**
 * The callback used to needs to be retrieved.
 * @typedef DLStylerNodeFetchCallback
 * @since 0.1.0
 */
typedef bool (*DLStylerNodeFetchCallback)(DLStylerNodeRef node, DLStylerStyleItemRef item);

#if __cplusplus
extern "C" {
#endif

/**
 * Creates a new styling observer.
 * @function DLStyleCreate
 * @since 0.1.0
 */
DLStylerNodeRef DLStylerNodeCreate();

/**
 * Deletes a styling observer.
 * @function DLStyleDelete
 * @since 0.1.0
 */
void DLStylerNodeDelete(DLStylerNodeRef node);

/**
 * Assigns the style node's id.
 * @function DLStylerNodeSetId
 * @since 0.1.0
 */
void DLStylerNodeSetId(DLStylerNodeRef node, const char* id);

/**
 * Assigns styling observer type name.
 * @function DLStylerNodeSetType
 * @since 0.1.0
 */
void DLStylerNodeSetType(DLStylerNodeRef node, const char* type);

/**
 * Assigns the styling observer's context.
 * @function DLStylerNodeSetStyler
 * @since 0.4.0
 */
void DLStylerNodeSetStyler(DLStylerNodeRef node, DLStylerRef styler);

/**
 * Assigns whether the obj observer is visible.
 * @function DLStylerNodeSetVisible
 * @since 0.1.0
 */
void DLStylerNodeSetVisible(DLStylerNodeRef node, bool visible);

/**
 * Appends a node to the observer's children list.
 * @function DLStylerNodeAppendChild
 * @since 0.1.0
 */
void DLStylerNodeAppendChild(DLStylerNodeRef node, DLStylerNodeRef child);

/**
 * Inserts a node to the observer's children list.
 * @function DLStylerNodeInsertChild
 * @since 0.1.0
 */
void DLStylerNodeInsertChild(DLStylerNodeRef node, DLStylerNodeRef child, int index);

/**
 * Appends a node to the observer's children list.
 * @function DLStylerNodeRemoveChild
 * @since 0.1.0
 */
void DLStylerNodeRemoveChild(DLStylerNodeRef node, DLStylerNodeRef child);

/**
 * Appends a node to the observer's element list.
 * @function DLStylerNodeAppendShadowedNode
 * @since 0.1.0
 */
void DLStylerNodeAppendShadowedNode(DLStylerNodeRef node, DLStylerNodeRef child);

/**
 * Inserts a node to the observer's element list.
 * @function DLStylerNodeInsertShadowedElement
 * @since 0.1.0
 */
void DLStylerNodeInsertShadowedElement(DLStylerNodeRef node, DLStylerNodeRef child, int index);

/**
 * Removes a node from the observer's element list.
 * @function DLStylerNodeRemoveShadowedNode
 * @since 0.1.0
 */
void DLStylerNodeRemoveShadowedNode(DLStylerNodeRef node, DLStylerNodeRef child);

/**
 * Indicates whether the node has a specified style.
 * @function DLStylerNodeHasStyle
 * @since 0.7.0
 */
bool DLStylerNodeHasStyle(DLStylerNodeRef node, const char* style);

/**
 * Sets or unsets a style from this node.
 * @function DLStylerNodeSetStyle
 * @since 0.7.0
 */
void DLStylerNodeSetStyle(DLStylerNodeRef node, const char* style, bool enable);

/**
 * Indicates whether the node has a specified state.
 * @function DLStylerNodeHasState
 * @since 0.7.0
 */
bool DLStylerNodeHasState(DLStylerNodeRef node, const char* state);

/**
 * Sets or unsets a state from this node.
 * @function DLStylerNodeSetState
 * @since 0.7.0
 */
void DLStylerNodeSetState(DLStylerNodeRef node, const char* state, bool enable);

/**
 * Assigns user image to this styling observer.
 * @function DLStylerNodeSetData
 * @since 0.1.0
 */
void DLStylerNodeSetData(DLStylerNodeRef node, void* data);

/**
 * Returns the styling observer user image.
 * @function DLStylerNodeGetData
 * @since 0.1.0
 */
void* DLStylerNodeGetData(DLStylerNodeRef node);

/**
 * Removes a state from this styling observer.
 * @function DLStylerNodeInvalidate
 * @since 0.1.0
 */
void DLStylerNodeInvalidate(DLStylerNodeRef node);

/**
 * Assigns the callback that is called when a property is resolved.
 * @function DLStylerNodeSetApplyCallback
 * @since 0.1.0
 */
void DLStylerNodeSetApplyCallback(DLStylerNodeRef node, DLStylerNodeApplyCallback callback);

/**
 * Assigns the callback that is called the node needs the property of a value.
 * @function DLStylerNodeSetFetchCallback
 * @since 0.1.0
 */
void DLStylerNodeSetFetchCallback(DLStylerNodeRef node, DLStylerNodeFetchCallback callback);

/**
 * Assigns the callback that is called when a styles is invalidated.
 * @function DLStylerNodeSetInvalidateCallback
 * @since 0.1.0
 */
void DLStylerNodeSetInvalidateCallback(DLStylerNodeRef node, DLStylerNodeInvalidateCallback callback);

/**
 * Resolves the node's style
 * @function DLStylerNodeResolve
 * @since 0.1.0
 */
void DLStylerNodeResolve(DLStylerNodeRef node);

/**
 * Resolves styles recursively from a starting point.
 * @function DLStylerNodeResolveTree
 * @since 0.1.0
 */
void DLStylerNodeResolveTree(DLStylerNodeRef node);

/**
 * Resolves specified node's style.
 * @function DLStylerNodeResolveStyle
 * @since 0.1.0
 */
void DLStylerNodeResolveStyles(DLStylerNodeRef node);

#if __cplusplus
}
#endif
#endif
