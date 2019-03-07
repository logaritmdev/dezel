#ifndef DLStylerMatch_h
#define DLStylerMatch_h

#include <set>
#include <vector>
#include <string>
#include "DLStyler.h"
#include "DLStylerNode.h"
#include "DLStylerNodePrivate.h"
#include "DLStylerStyleSelector.h"

using std::set;
using std::vector;
using std::string;

/**
 * @typedef DLStylerMatchedRuleRef
 * @since 0.3.0
 * @hidden
 */
typedef struct OpaqueDLStylerMatchedRule* DLStylerMatchedRuleRef;

/**
 * @function DLStylerMatchSelector
 * @since 0.3.0
 * @hidden
 */
bool DLStylerMatchSelector(DLStylerNodeRef node, DLStylerStyleSelectorRef selector);

/**
 * @function DLStylerMatchSelectorType
 * @since 0.3.0
 * @hidden
 */
bool DLStylerMatchSelectorType(DLStylerNodeRef node, const string &type);

/**
 * @function DLStylerMatchSelectorTraits
 * @since 0.3.0
 * @hidden
 */
bool DLStylerMatchSelectorTraits(DLStylerNodeRef node, const set<string> &traits);

/**
 * @function DLStylerMatchSelectorStates
 * @since 0.3.0
 * @hidden
 */
bool DLStylerMatchSelectorStates(DLStylerNodeRef node, const set<string> &states);

/**
 * @function DLStylerMatchSelectorHierarchy
 * @since 0.3.0
 * @hidden
 */
bool DLStylerMatchSelectorHierarchy(DLStylerNodeRef node, DLStylerStyleSelectorRef selector);

/**
 * @function DLStylerMatchRules
 * @since 0.3.0
 * @hidden
 */
void DLStylerMatchRules(DLStylerNodeRef node, vector<DLStylerMatchedRuleRef> &styles);

#endif
