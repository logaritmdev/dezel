#ifndef DLValuePrivate_h
#define DLValuePrivate_h

#include "DLContext.h"
#include "DLValue.h"
#include <unordered_map>

using std::unordered_map;

/**
 * @struct OpaqueDLValueData
 * @since 0.1.0
 * @hidden
 */
struct OpaqueDLValueData {
	JSContextRef context;
	DLFinalizeCallback finalizeCallback;
	DLFunctionCallback functionCallback;
	unordered_map<long long, void *> attributes;
	void *associatedObject;
};

/**
 * @function DLValueDataCreate
 * @since 0.1.0
 * @hidden
 */
DLValueDataRef DLValueDataCreate(JSContextRef context);

/**
 * @function DLValueDataDelete
 * @since 0.1.0
 * @hidden
 */
void DLValueDataDelete(DLValueDataRef handle);

/**
 * @function DSValueDataGet
 * @since 0.1.0
 * @hidden
 */
DLValueDataRef DLValueDataGet(JSObjectRef object);

/**
 * @function DLFunctionFinalizeHandler
 * @since 0.1.0
 * @hidden
 */
void DLFunctionFinalizeHandler(JSObjectRef object);

/**
 * @function DLFunctionCallAsFunctionHandler
 * @since 0.1.0
 * @hidden
 */
JSValueRef DLFunctionCallAsFunctionHandler(JSContextRef context, JSObjectRef callee, JSObjectRef object, size_t argc, const JSValueRef argv[], JSValueRef *error);

/**
 * @function DLFunctionCallAsConstructorHandler
 * @since 0.1.0
 * @hidden
 */
JSObjectRef DLFunctionCallAsConstructorHandler(JSContextRef context, JSObjectRef callee, size_t argc, const JSValueRef argv[], JSValueRef *error);

/**
 * @function DLFunctionConvertToStringHandler
 * @since 0.1.0
 * @hidden
 */
JSValueRef DLFunctionConvertToStringHandler(JSContextRef context, JSObjectRef callee, JSObjectRef object, size_t argc, const JSValueRef argv[], JSValueRef *error);

/**
 * @function DLValueFinalizeHandler
 * @since 0.1.0
 * @hidden
 */
void DLValueFinalizeHandler(JSObjectRef object);

#endif
