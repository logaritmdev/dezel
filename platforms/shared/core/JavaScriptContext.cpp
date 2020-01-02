#include "JavaScriptValue.h"
#include "JavaScriptContext.h"
#include "JavaScriptContextPrivate.h"

#include <unordered_map>
#include <iostream>

using std::cerr;
using std::unordered_map;

#ifdef DEZEL_ANDROID
#include <android/log.h>
#endif

static unordered_map<JSContextRef, unordered_map<long long, void *>> attributes;

static const long long kJavaScriptContextExceptionHandlerKey = reinterpret_cast<long long>(new int(0));

JSContextRef
JavaScriptContextCreate(const char* name)
{
	JSContextRef context = JSGlobalContextCreate(nullptr);
	JavaScriptContextSetName(context, name);

	JavaScriptContextEvaluate(context, "self = this", "");
	JavaScriptContextEvaluate(context, "root = this", "");
	JavaScriptContextEvaluate(context, "global = this", "");

	/*
	 * Creates compatibility with symbol until the JavaScriptCore API
	 * on iOS 13 becomes mainstream.
	 */

	JavaScriptContextEvaluate(context,
		"function __newSymbol__(n) { return Symbol(n); }",
		""
	);

	JavaScriptContextEvaluate(context,
		"function __setValueWithSymbol__(o, s, v) { o[s] = v }",
		""
	);

	JavaScriptContextEvaluate(context,
		"function __getValueWithSymbol__(o, s) { return o[s] }",
		""
	);

	return context;
}

void
JavaScriptContextDelete(JSContextRef context)
{
	JavaScriptContextSetAttribute(context, kJavaScriptContextExceptionHandlerKey, nullptr);
	JSGlobalContextRelease(JSContextGetGlobalContext(context));
}

void
JavaScriptContextSetName(JSContextRef context, const char* name)
{
	JSStringRef namestr = JSStringCreateWithUTF8CString(name);
	JSGlobalContextSetName(JSContextGetGlobalContext(context), namestr);
	JSStringRelease(namestr);
}

JSObjectRef
JavaScriptContextGetGlobalObject(JSContextRef context)
{
	return JSContextGetGlobalObject(context);
}

void
JavaScriptContextEvaluate(JSContextRef context, const char* code, const char* file)
{
	JSValueRef error = nullptr;

	JSStringRef c = JSStringCreateWithUTF8CString(code);
	JSStringRef f = JSStringCreateWithUTF8CString(file);
	JSEvaluateScript(context, c, JSContextGetGlobalObject(context), f, 0, &error);
	JSStringRelease(f);
	JSStringRelease(c);

	if (error) {
		JavaScriptContextHandleError(context, error);
	}
}

void
JavaScriptContextSetAttribute(JSContextRef context, long long key, void *value)
{
	if (attributes.count(context) == 0) {
		attributes[context] = unordered_map<long long, void*>();
	}

	if (value == nullptr) {

		attributes[context].erase(key);

		if (attributes[context].size() == 0) {
			attributes.erase(context);
		}

		return;
	}

	attributes[context][key] = value;
}

void *
JavaScriptContextGetAttribute(JSContextRef context, long long key)
{
	if (attributes.count(context) == 0) {
		return nullptr;
	}

	return attributes[context][key];
}

void
JavaScriptContextSetExceptionHandler(JSContextRef context, JavaScriptContextExceptionHandler handler)
{
	JavaScriptContextExceptionHandlerDataRef exceptionHandlerData = (JavaScriptContextExceptionHandlerDataRef) JavaScriptContextGetAttribute(context, kJavaScriptContextExceptionHandlerKey);

	if (exceptionHandlerData) {
		delete exceptionHandlerData;
	}

	exceptionHandlerData = new JavaScriptContextExceptionHandlerData();
	exceptionHandlerData->handler = handler;

	JavaScriptContextSetAttribute(context, kJavaScriptContextExceptionHandlerKey, exceptionHandlerData);
}

void
JavaScriptContextHandleError(JSContextRef context, JSValueRef error)
{
	JavaScriptContextExceptionHandlerDataRef exceptionHandlerData = (JavaScriptContextExceptionHandlerDataRef) JavaScriptContextGetAttribute(context, kJavaScriptContextExceptionHandlerKey);

	if (exceptionHandlerData) {
		exceptionHandlerData->handler(context, error);
		return;
	}

	JSObjectRef exception = (JSObjectRef) error;

	#ifdef DEZEL_ANDROID

		if (JSValueGetType(context, error) == kJSTypeObject) {
			__android_log_print(ANDROID_LOG_ERROR, "DEZEL",
				"***** JavaScriptError: %s \n File:  %s  \n Line:  %s \n Stack: %s ",
				JavaScriptValueToString(context, error),
				JavaScriptValueToString(context, JavaScriptValueGetProperty(context, exception, "sourceURL")),
				JavaScriptValueToString(context, JavaScriptValueGetProperty(context, exception, "line")),
				JavaScriptValueToString(context, JavaScriptValueGetProperty(context, exception, "stack"))
			);
		}

	#else

		if (JSValueGetType(context, error) == kJSTypeObject) {
			cerr << "***** JavaScriptError: " << JavaScriptValueToString(context, error) << "\n";
			cerr << "File:  " << JavaScriptValueToString(context, JavaScriptValueGetProperty(context, exception, "sourceURL")) << "\n";
			cerr << "Line:  " << JavaScriptValueToString(context, JavaScriptValueGetProperty(context, exception, "line")) << "\n";
			cerr << "Stack: " << JavaScriptValueToString(context, JavaScriptValueGetProperty(context, exception, "stack")) << "\n";
		}

	#endif
}
