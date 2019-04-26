#ifndef DLStylerNodePrivate_h
#define DLStylerNodePrivate_h

#include <set>
#include <string>
#include <vector>
#include <unordered_map>
#include "DLStylerNode.h"
#include "DLStyler.h"
#include "DLStylerPrivate.h"
#include "DLStylerStyleRule.h"
#include "DLStylerStyleRulePrivate.h"
#include "DLStylerStyleItem.h"
#include "DLStylerStyleItemPrivate.h"

using std::set;
using std::string;
using std::vector;
using std::unordered_map;

typedef struct OpaqueDLStylerMatchedRule* DLStylerMatchedRuleRef; // Forward declaration

/**
 * @struct OpaqueDLStylerNode
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLStylerNode {

	string id = "";

	DLStylerRef styler = NULL;

	DLStylerNodeRef host = NULL;
	DLStylerNodeRef parent = NULL;
	vector<DLStylerNodeRef> children;
	vector<DLStylerNodeRef> shadowed;

	string type = "";
	vector<string> types;
	vector<string> styles;
	vector<string> states;

	vector<DLStylerMatchedRuleRef> matchedStyles;
	unordered_map<string, DLStylerMatchedRuleRef> matchedValues;
	unordered_map<string, DLStylerStyleItemRef> initialValues;
	unordered_map<string, DLStylerStyleItemRef> currentValues;

	bool visible = true;
	bool invalid = false;

	DLStylerNodeApplyCallback applyCallback = NULL;
	DLStylerNodeFetchCallback fetchCallback = NULL;
	DLStylerNodeInvalidateCallback invalidateCallback = NULL;

	void *data = NULL;
};

/**
 * @struct OpaqueDLStyle
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLStylerMatchedRule {
	DLStylerStyleRuleRef rule;
	DLStylerMatchedRuleRef prev = NULL;
	DLStylerMatchedRuleRef next = NULL;
};

/**
 * @function DLStyleGetTypes
 * @since 0.1.0
 * @hidden
 */
void DLStyleParseTypes(DLStylerNodeRef node, const char* type);

/**
 * @function DLStylerNodeSaveDefaultProperty
 * @since 0.1.0
 * @hidden
 */
void DLStylerNodeRetrieveInitialValue(DLStylerNodeRef node, string property);

/**
 * @function DLStylerNodeAttachStyle
 * @hidden
 * @since 0.1.0
 */
void DLStylerNodeAttachStyles(DLStylerNodeRef node, const vector<DLStylerMatchedRuleRef> &styles, DLStylerStyleItemRefMap &definition);

/**
 * @function DLStylerNodeDetachStyle
 * @hidden
 * @since 0.1.0
 */
void DLStylerNodeDetachStyles(DLStylerNodeRef node);

/**
 * @function DLStylerNodeInvalidateChildren
 * @hidden
 * @since 0.1.0
 */
void DLStylerNodeInvalidateChildren(DLStylerNodeRef node, DLStylerMatchedRuleRef style);

/**
 * @function DLStylerNodeInvalidateChildrenMatchingSelectorTreeNode
 * @hidden
 * @since 0.1.0
 */
void DLStylerNodeInvalidateChildrenMatchingSelector(DLStylerNodeRef node, DLStylerStyleSelectorTreeRef tree);

/**
 * @function DLStylerNodeApply
 * @hidden
 * @since 0.1.0
 */
void DLStylerNodeApply(DLStylerNodeRef node, const DLStylerStyleItemRefMap &items);

/**
 * @function DLStylerNodePrintName
 * @hidden
 * @since 0.3.0
 */
void DLStylerNodePrintName(DLStylerNodeRef node);

#endif
