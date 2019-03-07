#include <unordered_map>
#include <iostream>
#include "DLValue.h"
#include "DLContext.h"
#include "DLContextPrivate.h"

using std::cerr;
using std::unordered_map;

#ifdef DEZEL_ANDROID
#include <android/log.h>
#endif

static unordered_map<JSContextRef, unordered_map<long long, void *>> attributes;

static const long long kDLContextExceptionHandlerKey = reinterpret_cast<long long>(new int(0));

JSContextRef
DLContextCreate(DLString name)
{
	JSContextRef context = JSGlobalContextCreate(NULL);
	DLContextSetName(context, name);
	DLContextEvaluate(context, "root = this", "");
	DLContextEvaluate(context, "global = this", "");
	DLContextEvaluate(context, "self = this", "");
	return context;
}

void
DLContextDelete(JSContextRef context)
{
	DLContextDeleteAttribute(context, kDLContextExceptionHandlerKey);
	JSGlobalContextRelease(JSContextGetGlobalContext(context));
}

void
DLContextSetName(JSContextRef context, DLString name)
{
	JSStringRef namestr = JSStringCreateWithUTF8CString(name);
	JSGlobalContextSetName(JSContextGetGlobalContext(context), namestr);
	JSStringRelease(namestr);
}

JSObjectRef
DLContextGetGlobalObject(JSContextRef context)
{
	return JSContextGetGlobalObject(context);
}

void
DLContextEvaluate(JSContextRef context, DLString code, DLString file)
{
	JSValueRef error = NULL;

	JSStringRef c = JSStringCreateWithUTF8CString(code);
	JSStringRef f = JSStringCreateWithUTF8CString(file);
	JSEvaluateScript(context, c, JSContextGetGlobalObject(context), f, 0, &error);
	JSStringRelease(f);
	JSStringRelease(c);

	if (error) {
		DLContextHandleError(context, error);
	}
}

void
DLContextSetAttribute(JSContextRef context, long long key, void *value)
{
	if (attributes.count(context) == 0) {
		attributes[context] = unordered_map<long long, void*>();
	}

	attributes[context][key] = value;
}

void *
DLContextGetAttribute(JSContextRef context, long long key)
{
	if (attributes.count(context) == 0) {
		return NULL;
	}

	return attributes[context][key];
}

void
DLContextDeleteAttribute(JSContextRef context, long long key)
{
	if (attributes.count(context) == 0) {
		return;
	}

	attributes[context].erase(key);

	if (attributes[context].size() == 0) {
		attributes.erase(context);
	}
}

void
DLContextSetExceptionHandler(JSContextRef context, DLExceptionHandler handler)
{
	DLExceptionHandlerDataRef exceptionHandlerData = (DLExceptionHandlerDataRef) DLContextGetAttribute(context, kDLContextExceptionHandlerKey);

	if (exceptionHandlerData) {
		delete exceptionHandlerData;
	}

	exceptionHandlerData = new DLExceptionHandlerData();
	exceptionHandlerData->handler = handler;

	DLContextSetAttribute(context, kDLContextExceptionHandlerKey, exceptionHandlerData);
}

void
DLContextHandleError(JSContextRef context, JSValueRef error)
{
	DLExceptionHandlerDataRef exceptionHandlerData = (DLExceptionHandlerDataRef) DLContextGetAttribute(context, kDLContextExceptionHandlerKey);

	if (exceptionHandlerData) {
		exceptionHandlerData->handler(context, error);
		return;
	}

	JSObjectRef exception = (JSObjectRef) error;

	#ifdef DEZEL_ANDROID

		if (JSValueGetType(context, error) == kJSTypeObject) {
			__android_log_print(ANDROID_LOG_ERROR, "DEZEL",
				"***** JavaScriptError: %s \n File:  %s  \n Line:  %s \n Stack: %s ",
				DLValueToString(context, error),
				DLValueToString(context, DLValueGetProperty(context, exception, "sourceURL")),
				DLValueToString(context, DLValueGetProperty(context, exception, "line")),
				DLValueToString(context, DLValueGetProperty(context, exception, "stack"))
			);
		}

	#else

		if (JSValueGetType(context, error) == kJSTypeObject) {
			cerr << "***** JavaScriptError: " << DLValueToString(context, error) << "\n";
			cerr << "File:  " << DLValueToString(context, DLValueGetProperty(context, exception, "sourceURL")) << "\n";
			cerr << "Line:  " << DLValueToString(context, DLValueGetProperty(context, exception, "line")) << "\n";
			cerr << "Stack: " << DLValueToString(context, DLValueGetProperty(context, exception, "stack")) << "\n";
		}

	#endif
}
