#ifndef JavaScriptValuePrivate_h
#define JavaScriptValuePrivate_h

#include "JavaScriptContext.h"
#include "JavaScriptValue.h"
#include <unordered_map>

using std::unordered_map;

/**
 * @struct JavaScriptValueData
 * @since 0.7.0
 * @hidden
 */
struct JavaScriptValueData {
	JSContextRef context;
	JavaScriptValueFinalizeCallback finalizeCallback;
	JavaScriptValueFunctionCallback functionCallback;
	unordered_map<long long, void *> attributes;
	void *associatedObject;
};

/**
 * @function JavaScriptValueDataCreate
 * @since 0.7.0
 * @hidden
 */
JavaScriptValueDataRef JavaScriptValueDataCreate(JSContextRef context);

/**
 * @function JavaScriptValueDataDelete
 * @since 0.7.0
 * @hidden
 */
void JavaScriptValueDataDelete(JavaScriptValueDataRef handle);

/**
 * @function DSValueDataGet
 * @since 0.7.0
 * @hidden
 */
JavaScriptValueDataRef JavaScriptValueDataGet(JSObjectRef object);

/**
 * @function JavaScriptFunctionFinalizeHandler
 * @since 0.7.0
 * @hidden
 */
void JavaScriptFunctionFinalizeHandler(JSObjectRef object);

/**
 * @function JavaScriptFunctionCallAsFunctionHandler
 * @since 0.7.0
 * @hidden
 */
JSValueRef JavaScriptFunctionCallAsFunctionHandler(JSContextRef context, JSObjectRef callee, JSObjectRef object, size_t argc, const JSValueRef argv[], JSValueRef *error);

/**
 * @function JavaScriptFunctionCallAsConstructorHandler
 * @since 0.7.0
 * @hidden
 */
JSObjectRef JavaScriptFunctionCallAsConstructorHandler(JSContextRef context, JSObjectRef callee, size_t argc, const JSValueRef argv[], JSValueRef *error);

/**
 * @function JavaScriptFunctionConvertToStringHandler
 * @since 0.7.0
 * @hidden
 */
JSValueRef JavaScriptFunctionConvertToStringHandler(JSContextRef context, JSObjectRef callee, JSObjectRef object, size_t argc, const JSValueRef argv[], JSValueRef *error);

/**
 * @function JavaScriptValueFinalizeHandler
 * @since 0.7.0
 * @hidden
 */
void JavaScriptValueFinalizeHandler(JSObjectRef object);

/**
 * @function JavaScriptStringCreaste
 * @since 0.7.0
 * @hidden
 */
char* JavaScriptStringCreaste(JSStringRef string);

/**
 * @function JavaScriptStringDelete
 * @since 0.7.0
 * @hidden
 */
void JavaScriptStringDelete(char* string);

#endif
