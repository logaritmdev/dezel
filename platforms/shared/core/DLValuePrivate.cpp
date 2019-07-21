#include "DLValuePrivate.h"
#include <iostream>

DLValueDataRef
DLValueDataCreate(JSContextRef context)
{
	DLValueDataRef data = new OpaqueDLValueData;
	data->context = context;
	data->finalizeCallback = NULL;
	data->functionCallback = NULL;
	return data;
}

void
DLValueDataDelete(DLValueDataRef data)
{
	delete data;
}

DLValueDataRef
DLValueDataGet(JSObjectRef object)
{
	return (DLValueDataRef) JSObjectGetPrivate(object);
}

JSValueRef
DLFunctionCallAsFunctionHandler(JSContextRef context, JSObjectRef callee, JSObjectRef object, size_t argc, const JSValueRef argv[], JSValueRef *error)
{
	JSValueRef result = DLValueDataGet(callee)->functionCallback(context, object, callee, argc, argv);
	if (result == NULL) {
		result = DLValueCreateUndefined(context);
	}

	return result;
}

JSObjectRef
DLFunctionCallAsConstructorHandler(JSContextRef context, JSObjectRef callee, size_t argc, const JSValueRef argv[], JSValueRef *error)
{
	JSObjectRef object = DLValueCreateEmptyObject(context,
		DLValueGetPrototypeOfConstructor(context, callee)
	);

	JSValueRef result = DLValueDataGet(callee)->functionCallback(context, object, callee, argc, argv);
	if (result == NULL) {
		result = DLValueCreateUndefined(context);
	}

	return DLValueIsObject(context, result) ? (JSObjectRef) result : object;
}

void
DLFunctionFinalizeHandler(JSObjectRef object)
{
	DLValueDataRef data = DLValueDataGet(object);

	if (data == NULL) {
		return;
	}

	if (data->finalizeCallback) {
		data->finalizeCallback(data->context, data);
	}

	DLValueDataDelete(data);
}

JSValueRef
DLFunctionConvertToStringHandler(JSContextRef context, JSObjectRef callee, JSObjectRef object, size_t argc, const JSValueRef argv[], JSValueRef *error)
{
	const char* name = DLValueToString(context, DLValueGetProperty(context, object, "name"));

	size_t len = strlen(name);
	char str[len + 31];
	snprintf(str, sizeof str, "function %s() { [native code] }", name);

	return DLValueCreateString(context, str);
}

void
DLValueFinalizeHandler(JSObjectRef object)
{
	DLValueDataRef data = DLValueDataGet(object);

	if (data == NULL) {
		return;
	}

	if (data->finalizeCallback) {
		data->finalizeCallback(data->context, data);
	}

	DLValueDataDelete(data);
}

char*
DLStringCreate(JSContextRef context, JSStringRef string)
{
	auto length = JSStringGetMaximumUTF8CStringSize(string);
	auto buffer = new char[length];
	JSStringGetUTF8CString(string, buffer, length);
	return buffer;
}
