#include "JavaScriptValuePrivate.h"
#include <iostream>

JavaScriptValueDataRef
JavaScriptValueDataCreate(JSContextRef context)
{
	JavaScriptValueDataRef data = new JavaScriptValueData;
	data->context = context;
	data->finalizeCallback = nullptr;
	data->functionCallback = nullptr;
	return data;
}

void
JavaScriptValueDataDelete(JavaScriptValueDataRef data)
{
	delete data;
}

JavaScriptValueDataRef
JavaScriptValueDataGet(JSObjectRef object)
{
	return (JavaScriptValueDataRef) JSObjectGetPrivate(object);
}

JSValueRef
JavaScriptFunctionCallAsFunctionHandler(JSContextRef context, JSObjectRef callee, JSObjectRef object, size_t argc, const JSValueRef argv[], JSValueRef *error)
{
	JSValueRef result = JavaScriptValueDataGet(callee)->functionCallback(context, object, callee, argc, argv);
	if (result == nullptr) {
		result = JavaScriptValueCreateUndefined(context);
	}

	return result;
}

JSObjectRef
JavaScriptFunctionCallAsConstructorHandler(JSContextRef context, JSObjectRef callee, size_t argc, const JSValueRef argv[], JSValueRef *error)
{
	JSObjectRef object = JavaScriptValueCreateEmptyObject(context,
		JavaScriptValueGetPrototypeOfConstructor(context, callee)
	);

	JSValueRef result = JavaScriptValueDataGet(callee)->functionCallback(context, object, callee, argc, argv);
	if (result == nullptr) {
		result = JavaScriptValueCreateUndefined(context);
	}

	return JavaScriptValueIsObject(context, result) ? (JSObjectRef) result : object;
}

void
JavaScriptFunctionFinalizeHandler(JSObjectRef object)
{
	JavaScriptValueDataRef data = JavaScriptValueDataGet(object);

	if (data == nullptr) {
		return;
	}

	if (data->finalizeCallback) {
		data->finalizeCallback(data->context, data);
	}

	JavaScriptValueDataDelete(data);
}

JSValueRef
JavaScriptFunctionConvertToStringHandler(JSContextRef context, JSObjectRef callee, JSObjectRef object, size_t argc, const JSValueRef argv[], JSValueRef *error)
{
	const char* name = JavaScriptValueToString(context, JavaScriptValueGetProperty(context, object, "name"));

	size_t len = strlen(name);
	char str[len + 31];
	snprintf(str, sizeof str, "function %s() { [native code] }", name);

	return JavaScriptValueCreateString(context, str);
}

void
JavaScriptValueFinalizeHandler(JSObjectRef object)
{
	JavaScriptValueDataRef data = JavaScriptValueDataGet(object);

	if (data == nullptr) {
		return;
	}

	if (data->finalizeCallback) {
		data->finalizeCallback(data->context, data);
	}

	JavaScriptValueDataDelete(data);
}

char*
JavaScriptStringCreaste(JSStringRef string)
{
	auto length = JSStringGetMaximumUTF8CStringSize(string);
	auto buffer = new char[length];
	JSStringGetUTF8CString(string, buffer, length);
	return buffer;
}

void
JavaScriptStringDelete(char* string)
{
	delete [] string;
}
