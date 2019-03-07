#include <set>
#include <queue>
#include <string>
#include <vector>
#include <sstream>
#include <iostream>
#include <iterator>
#include <algorithm>
#include "DLStylerMatch.h"
#include "DLStylerNode.h"
#include "DLStylerNodePrivate.h"
#include "DLStyler.h"
#include "DLStylerPrivate.h"

#include <chrono>

#ifdef ANDROID
#include <android/log.h>
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG  , "DEZEL", __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR  , "DEZEL", __VA_ARGS__)
#endif

using namespace std;
using namespace std::chrono;

#define DL_STYLER_TIMER_START(NAME) \
	high_resolution_clock::time_point NAME##_1 = high_resolution_clock::now();

#define DL_STYLER_TIMER_STOP(NAME, RESULT) \
	high_resolution_clock::time_point NAME##_2 = high_resolution_clock::now(); \
	auto RESULT = duration_cast<microseconds>(NAME##_2 - NAME##_1).count(); \

using std::find;
using std::queue;
using std::string;
using std::vector;

DLStylerNodeRef
DLStylerNodeCreate()
{
	return new OpaqueDLStylerNode;
}

void
DLStylerNodeDelete(DLStylerNodeRef node)
{
	delete node;
}

void
DLStylerNodeSetId(DLStylerNodeRef node, const char *id)
{
	node->id = string(id);
}

void
DLStylerNodeSetType(DLStylerNodeRef node, const char *type)
{
	DLStyleParseTypes(node, type);

	if (node->styler->cache.count(node->type) == 1) {
		DLStylerNodeApply(node, node->styler->cache[node->type]);
		return;
	}

	DLStylerStyleItemRefMap items;

	for (auto it = node->types.rbegin(); it != node->types.rend(); it++) {
		auto type = *it;
		if (node->styler->types.count(type) > 0) {
			for (auto &pair : node->styler->types[type]) {
				items[pair.first] = pair.second;
			}
		}
	}

	node->styler->cache[node->type] = items;

	DLStylerNodeApply(node, items);
}

void
DLStylerNodeSetStyler(DLStylerNodeRef node, DLStylerRef context)
{
	node->styler = context;
}

void
DLStylerNodeSetVisible(DLStylerNodeRef node, bool visible)
{
	if (node->visible != visible) {
		node->visible = visible;
		if (visible) {
			DLStylerNodeInvalidate(node);
		}
	}
}

void
DLStylerNodeAppendChild(DLStylerNodeRef node, DLStylerNodeRef child)
{
	DLStylerNodeInsertChild(node, child, (int) node->children.size());
}

void
DLStylerNodeInsertChild(DLStylerNodeRef node, DLStylerNodeRef child, int index)
{
	auto it = find(
		node->children.begin(),
		node->children.end(),
		child
	);

	if (it != node->children.end()) {
		return;
	}

	child->parent = node;
	node->children.insert(node->children.begin() + index, child);

	DLStylerNodeInvalidate(child);
}

void
DLStylerNodeRemoveChild(DLStylerNodeRef node, DLStylerNodeRef child)
{
	auto it = find(
		node->children.begin(),
		node->children.end(),
		child
	);

	if (it == node->children.end()) {
		return;
	}

	child->parent = NULL;
	node->children.erase(it);
}

void
DLStylerNodeAppendShadowedNode(DLStylerNodeRef node, DLStylerNodeRef child)
{
	DLStylerNodeInsertShadowedElement(node, child, (int) node->shadowed.size());
}

void
DLStylerNodeInsertShadowedElement(DLStylerNodeRef node, DLStylerNodeRef child, int index)
{
	auto it = find(
		node->shadowed.begin(),
		node->shadowed.end(),
		child
	);

	if (it != node->shadowed.end()) {
		return;
	}

	child->host = node;
	node->shadowed.insert(node->shadowed.begin() + index, child);
}

void
DLStylerNodeRemoveShadowedNode(DLStylerNodeRef node, DLStylerNodeRef child)
{
	auto it = find(
		node->shadowed.begin(),
		node->shadowed.end(),
		child
	);

	if (it == node->shadowed.end()) {
		return;
	}

	child->host = NULL;
	node->shadowed.erase(it);
}

void
DLStylerNodeAppendStyle(DLStylerNodeRef node, const char *style)
{
	string value(style);

	auto res = find(
		node->styles.begin(),
		node->styles.end(),
		value
	);

	if (res != node->styles.end()) {
		return;
	}

	node->styles.push_back(value);

	DLStylerNodeInvalidate(node);
}

void
DLStylerNodeRemoveStyle(DLStylerNodeRef node, const char *style)
{
	string value(style);

	auto res = find(
		node->styles.begin(),
		node->styles.end(),
		value
	);

	if (res == node->styles.end()) {
		return;
	}

	node->styles.erase(res);

	DLStylerNodeInvalidate(node);
}

void
DLStylerNodeAppendState(DLStylerNodeRef node, const char *state)
{
	string value(state);

	auto res = find(
		node->states.begin(),
		node->states.end(),
		value
	);

	if (res != node->states.end()) {
		return;
	}

	node->states.push_back(value);

	DLStylerNodeInvalidate(node);
}

void
DLStylerNodeRemoveState(DLStylerNodeRef node, const char *state)
{
	string value(state);

	auto res = find(
		node->states.begin(),
		node->states.end(),
		value
	);

	if (res == node->states.end()) {
		return;
	}

	node->states.erase(res);

	DLStylerNodeInvalidate(node);
}

void
DLStylerNodeInvalidate(DLStylerNodeRef node)
{
	if (node->invalid) {
		return;
	}

	node->invalid = true;

	if (node->invalidateCallback) {
		node->invalidateCallback(node);
	}

	if (node->styler) {
		node->styler->invalid = true;
	}
}

void
DLStylerNodeSetData(DLStylerNodeRef node, void* data)
{
	node->data = data;
}

void*
DLStylerNodeGetData(DLStylerNodeRef node)
{
	return node->data;
}

void
DLStylerNodeSetApplyCallback(DLStylerNodeRef node, DLStylerNodeApplyCallback callback)
{
	node->applyCallback = callback;
}

void
DLStylerNodeSetFetchCallback(DLStylerNodeRef node, DLStylerNodeFetchCallback callback)
{
	node->fetchCallback = callback;
}

void
DLStylerNodeSetInvalidateCallback(DLStylerNodeRef node, DLStylerNodeInvalidateCallback callback)
{
	node->invalidateCallback = callback;
}

void
DLStylerNodeResolve(DLStylerNodeRef node)
{
	if (node->styler == NULL ||
		node->styler->invalid == false) {
		return;
	}

	if (node->styler->resolving == false) {
		node->styler->resolving = true;

		DL_STYLER_TIMER_START(STYLER_TIME);

		DLStylerNodeRef root = node->styler->root;

		if (root &&
			root->visible) {
			DLStylerNodeResolveTree(root);
		}

		DL_STYLER_TIMER_STOP(STYLER_TIME, RESULT);

		#ifdef ANDROID
			LOGD("Styler resolution: %llu microseconds", RESULT);
		#else
			std::cout << "Styler resolution: " << RESULT << " microseconds \n";
		#endif

		node->styler->invalid = false;

		node->styler->resolving = false;
	}
}

void
DLStylerNodeResolveTree(DLStylerNodeRef node)
{
	queue<DLStylerNodeRef> queue;
	queue.push(node);

	while (queue.size() > 0) {

		DLStylerNodeRef item = queue.front();
    	DLStylerNodeResolveStyles(item);
		queue.pop();

		if (node->visible) {
			for (auto &child : item->children) {
				queue.push(child);
			}
		}
	}
}

void
DLStylerNodeResolveStyles(DLStylerNodeRef node)
{
	if (node->invalid == false) {
		return;
	}

	DLStylerStyleItemRefMap current = node->currentValues;
	DLStylerStyleItemRefMap matches = node->initialValues;
	vector<DLStylerMatchedRuleRef> matchedRules;

	DLStylerMatchRules(node, matchedRules);

	DLStylerNodeDetachStyles(node);
	DLStylerNodeAttachStyles(node, matchedRules, matches);

	DLStylerStyleItemRefMap changes;

	for (auto &value : matches) {

		auto key = value.first;
		auto val = value.second;

		if (current.count(key) == 1 &&
			current[key] == val) {
			continue;
		}

		changes[key] = val;
	}

	DLStylerNodeApply(node, changes);

	node->invalid = false;
}

