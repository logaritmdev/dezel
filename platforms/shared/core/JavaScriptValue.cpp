#include <unordered_map>
#include <iostream>
#include "JavaScriptContext.h"
#include "JavaScriptValue.h"
#include "JavaScriptValuePrivate.h"

using std::cerr;

static const long long kNewSymbolKey = reinterpret_cast<long long>(new int(0));
static const long long kSetValueWithSymbolKey = reinterpret_cast<long long>(new int(0));
static const long long kGetValueWithSymbolKey = reinterpret_cast<long long>(new int(0));

static
JSObjectRef
JavaScriptCompatFunction(JSContextRef context, const char* name, const long long key) {

	auto function = reinterpret_cast<JSObjectRef>(JavaScriptContextGetAttribute(context, key));

	if (function) {
		return function;
	}

	auto value = JavaScriptValueGetProperty(context, JavaScriptContextGetGlobalObject(context), name);

	JavaScriptContextSetAttribute(context, key, (void*) value);

	return (JSObjectRef) value;
}

JSValueRef
JavaScriptValueCreateNull(JSContextRef context)
{
	return JSValueMakeNull(context);
}

JSValueRef
JavaScriptValueCreateUndefined(JSContextRef context)
{
	return JSValueMakeUndefined(context);
}

JSValueRef
JavaScriptValueCreateString(JSContextRef context, const char* value)
{
	JSStringRef string = JSStringCreateWithUTF8CString(value);
	JSValueRef result = JSValueMakeString(context, string);
	JSStringRelease(string);
	return result;
}

JSValueRef
JavaScriptValueCreateNumber(JSContextRef context, double value)
{
	return JSValueMakeNumber(context, value);
}

JSValueRef
JavaScriptValueCreateBoolean(JSContextRef context, bool value)
{
	return JSValueMakeBoolean(context, value);
}

JSObjectRef
JavaScriptValueCreateEmptyObject(JSContextRef context, JSObjectRef proto)
{
	JSClassDefinition def = kJSClassDefinitionEmpty;

	def.finalize = &JavaScriptValueFinalizeHandler;
	def.callAsFunction = nullptr;
	def.callAsConstructor = nullptr;

	if (proto) {
		def.attributes = kJSClassAttributeNoAutomaticPrototype;
	}

	JSClassRef cls = JSClassCreate(&def);
	JSObjectRef object = JSObjectMake(context, cls, JavaScriptValueDataCreate(context));
	JSClassRelease(cls);

	if (proto) {
		JavaScriptValueSetPrototype(context, object, proto);
	}

	return object;
}

JSObjectRef
JavaScriptValueCreateEmptyArray(JSContextRef context)
{
	JSValueRef error = nullptr;
	JSValueRef array = JSObjectMakeArray(context, 0, nullptr, &error);

	if (error) {
		JavaScriptContextHandleError(context, error);
	}

	return (JSObjectRef) array;
}

JSObjectRef
JavaScriptValueCreateFunction(JSContextRef context, JavaScriptValueFunctionCallback callback, const char* name)
{
	JSClassDefinition def = kJSClassDefinitionEmpty;

	def.attributes = kJSClassAttributeNoAutomaticPrototype;
	def.finalize = &JavaScriptFunctionFinalizeHandler;
	def.callAsFunction = &JavaScriptFunctionCallAsFunctionHandler;
	def.callAsConstructor = &JavaScriptFunctionCallAsConstructorHandler;

	JavaScriptValueDataRef data = JavaScriptValueDataCreate(context);

	JSClassRef obj = JSClassCreate(&kJSClassDefinitionEmpty);
	JSClassRef fnc = JSClassCreate(&def);
	JSObjectRef object = JSObjectMake(context, fnc, data);
	JSObjectRef cproto = JSObjectMake(context, obj, nullptr);
	JSObjectRef parent = JavaScriptValueGetPrototypeOfNativeConstructor(context, "Function");

	data->functionCallback = callback;

	JavaScriptValueSetPrototype(context, object, parent);
	JavaScriptValueSetProperty(context, object, "prototype", cproto);
	JavaScriptValueSetProperty(context, cproto, "constructor", object);

	if (name) {

		JavaScriptValueDefineProperty(context, object, "name", nullptr, nullptr, JavaScriptValueCreateString(context, name), false, true, true);

		JSStringRef toStringName = JSStringCreateWithUTF8CString("string");
		JSObjectRef toStringFunc = JSObjectMakeFunctionWithCallback(context, toStringName, &JavaScriptFunctionConvertToStringHandler);
		JSStringRelease(toStringName);

		JavaScriptValueDefineProperty(context, object, "string", nullptr, nullptr, toStringFunc, false, true, true);
	}

	JSClassRelease(obj);
	JSClassRelease(fnc);

	return object;
}

JSValueRef
JavaScriptValueCreateSymbol(JSContextRef context, const char* name)
{
	JSValueRef argv[1];
	argv[0] = JavaScriptValueCreateString(context, name);
	return JavaScriptValueCall(context, JavaScriptCompatFunction(context, "__newSymbol__", kNewSymbolKey), nullptr, 1, argv);
}

void
JavaScriptValueProtect(JSContextRef context, JSValueRef value)
{
	JSValueProtect(context, value);
}

void
JavaScriptValueUnprotect(JSContextRef context, JSValueRef value)
{
	JSValueUnprotect(context, value);
}

void
JavaScriptValueDefineProperty(JSContextRef context, JSObjectRef target, const char* property, JSValueRef getter, JSValueRef setter, JSValueRef value, bool writable, bool enumerable, bool configurable)
{
	JSObjectRef object = JavaScriptValueToObject(context, target);
	if (object == nullptr) {
		return;
	}

	JSObjectRef descriptor = JavaScriptValueCreateEmptyObject(context, nullptr);

	JSValueRef args[3];
	args[0] = object;
	args[1] = JavaScriptValueCreateString(context, property);
	args[2] = descriptor;

	if (setter || getter) {
		if (getter) JavaScriptValueSetProperty(context, descriptor, "get", getter);
		if (setter) JavaScriptValueSetProperty(context, descriptor, "set", setter);
	} else {
		if (value) JavaScriptValueSetProperty(context, descriptor, "value", value);
		JavaScriptValueSetPropertyWithBoolean(context, descriptor, "writable", writable);
	}

	JavaScriptValueSetPropertyWithBoolean(context, descriptor, "enumerable", enumerable);
	JavaScriptValueSetPropertyWithBoolean(context, descriptor, "configurable", configurable);

	JSObjectRef global = JSContextGetGlobalObject(context);
	JSObjectRef glbobj = (JSObjectRef) JavaScriptValueGetProperty(context, global, "Object");
	JSObjectRef define = (JSObjectRef) JavaScriptValueGetProperty(context, glbobj, "defineProperty");
	JavaScriptValueCall(context, define, global, 3, args);
}

void
JavaScriptValueDefineConstructor(JSContextRef context, JSObjectRef prototype, JSObjectRef function)
{
	JavaScriptValueDefineProperty(context, prototype, "constructor", nullptr, nullptr, function, true, true, true);
}

void
JavaScriptValueDefineFunction(JSContextRef context, JSObjectRef prototype, const char* name, JSObjectRef function)
{
	JavaScriptValueDefineProperty(context, prototype, name, nullptr, nullptr, function, true, true, true);
}

void
JavaScriptValueDefinePropertySetter(JSContextRef context, JSObjectRef prototype, const char* name, JSObjectRef function)
{
	JSObjectRef descriptor = JavaScriptValueCreateEmptyObject(context, nullptr);

	JSValueRef args[3];
	args[0] = prototype;
	args[1] = JavaScriptValueCreateString(context, name);
	args[2] = descriptor;

	JavaScriptValueSetProperty(context, descriptor, "set", function);
	JavaScriptValueSetPropertyWithBoolean(context, descriptor, "enumerable", true);
	JavaScriptValueSetPropertyWithBoolean(context, descriptor, "configurable", true);

	JSObjectRef global = JSContextGetGlobalObject(context);
	JSObjectRef glbobj = (JSObjectRef) JavaScriptValueGetProperty(context, global, "Object");
	JSObjectRef define = (JSObjectRef) JavaScriptValueGetProperty(context, glbobj, "defineProperty");
	JavaScriptValueCall(context, define, global, 3, args);
}

void
JavaScriptValueDefinePropertyGetter(JSContextRef context, JSObjectRef prototype, const char* name, JSObjectRef function)
{
	JSObjectRef descriptor = JavaScriptValueCreateEmptyObject(context, nullptr);

	JSValueRef args[3];
	args[0] = prototype;
	args[1] = JavaScriptValueCreateString(context, name);
	args[2] = descriptor;

	JavaScriptValueSetProperty(context, descriptor, "get", function);
	JavaScriptValueSetPropertyWithBoolean(context, descriptor, "enumerable", true);
	JavaScriptValueSetPropertyWithBoolean(context, descriptor, "configurable", true);

	JSObjectRef global = JSContextGetGlobalObject(context);
	JSObjectRef glbobj = (JSObjectRef) JavaScriptValueGetProperty(context, global, "Object");
	JSObjectRef define = (JSObjectRef) JavaScriptValueGetProperty(context, glbobj, "defineProperty");
	JavaScriptValueCall(context, define, global, 3, args);
}

void
JavaScriptValueSetProperty(JSContextRef context, JSObjectRef target, const char* property, JSValueRef value)
{
	JSObjectRef object = JavaScriptValueToObject(context, target);
	if (object == nullptr) {
		return;
	}

	JSValueRef error = nullptr;

	if (value == nullptr) {

		JSStringRef string = JSStringCreateWithUTF8CString(property);
		JSObjectDeleteProperty(context, object, string, &error);
		JSStringRelease(string);

	} else {

		JSStringRef string = JSStringCreateWithUTF8CString(property);
		JSObjectSetProperty(context, object, string, value, kJSPropertyAttributeNone, &error);
		JSStringRelease(string);

	}

	if (error) {
		JavaScriptContextHandleError(context, error);
	}
}

void
JavaScriptValueSetPropertyWithString(JSContextRef context, JSObjectRef object, const char* property, const char* value)
{
	JavaScriptValueSetProperty(context, object, property, JavaScriptValueCreateString(context, value));
}

void
JavaScriptValueSetPropertyWithNumber(JSContextRef context, JSObjectRef object, const char* property, double value)
{
	JavaScriptValueSetProperty(context, object, property, JavaScriptValueCreateNumber(context, value));
}

void
JavaScriptValueSetPropertyWithBoolean(JSContextRef context, JSObjectRef object, const char* property, bool value)
{
	JavaScriptValueSetProperty(context, object, property, JavaScriptValueCreateBoolean(context, value));
}

void
JavaScriptValueSetPropertyWithSymbol(JSContextRef context, JSObjectRef object, JSValueRef symbol, JSValueRef value)
{
	JSValueRef argv[3];
	argv[0] = object;
	argv[1] = symbol;
	argv[2] = value;

	JavaScriptValueCall(context, JavaScriptCompatFunction(context, "__setValueWithSymbol__", kSetValueWithSymbolKey), nullptr, 3, argv);
}

JSValueRef
JavaScriptValueGetProperty(JSContextRef context, JSObjectRef target, const char* property)
{
	JSObjectRef object = JavaScriptValueToObject(context, target);
	if (object == nullptr) {
		return nullptr;
	}

	JSStringRef string = JSStringCreateWithUTF8CString(property);
	JSValueRef error = nullptr;
	JSValueRef value = JSObjectGetProperty(context, object, string, &error);
	JSStringRelease(string);

	if (error) {
		JavaScriptContextHandleError(context, error);
	}

	return value;
}

JSValueRef
JavaScriptValueGetPropertyWithSymbol(JSContextRef context, JSObjectRef object, JSValueRef symbol)
{
	JSValueRef argv[2];
	argv[0] = object;
	argv[1] = symbol;

	auto value = JavaScriptValueCall(context, JavaScriptCompatFunction(context, "__getValueWithSymbol__", kGetValueWithSymbolKey), nullptr, 3, argv);

	if (JavaScriptValueIsNull(context, value) ||
		JavaScriptValueIsUndefined(context, value)) {
		return nullptr;
	}

	return value;
}

void
JavaScriptValueSetPropertyAtIndex(JSContextRef context, JSObjectRef target, unsigned int index, JSValueRef value)
{
	JSObjectRef object = JavaScriptValueToObject(context, target);
	if (object == nullptr) {
		return;
	}

	JSValueRef error = nullptr;

	JSObjectSetPropertyAtIndex(context, object, index, value, &error);

	if (error) {
		JavaScriptContextHandleError(context, error);
	}
}

void
JavaScriptValueSetPropertyAtIndexWithString(JSContextRef context, JSObjectRef object, unsigned int index, const char* value)
{
	JavaScriptValueSetPropertyAtIndex(context, object, index, JavaScriptValueCreateString(context, value));
}

void
JavaScriptValueSetPropertyAtIndexWithNumber(JSContextRef context, JSObjectRef object, unsigned int index, double value)
{
	JavaScriptValueSetPropertyAtIndex(context, object, index, JavaScriptValueCreateNumber(context, value));
}

void
JavaScriptValueSetPropertyAtIndexWithBoolean(JSContextRef context, JSObjectRef object, unsigned int index, bool value)
{
	JavaScriptValueSetPropertyAtIndex(context, object, index, JavaScriptValueCreateBoolean(context, value));
}

JSValueRef
JavaScriptValueGetPropertyAtIndex(JSContextRef context, JSObjectRef target, unsigned int index)
{
	JSObjectRef object = JavaScriptValueToObject(context, target);
	if (object == nullptr) {
		return nullptr;
	}

	JSValueRef error = nullptr;
	JSValueRef value = JSObjectGetPropertyAtIndex(context, object, index, &error);

	if (error) {
		JavaScriptContextHandleError(context, error);
	}

	return value;
}

JSValueRef
JavaScriptValueCall(JSContextRef context, JSObjectRef target, JSObjectRef object, unsigned int argc, const JSValueRef argv[])
{
	JSObjectRef function = JavaScriptValueToObject(context, target);
	if (function == nullptr) {
		return nullptr;
	}

	JSValueRef error = nullptr;
	JSValueRef value = JSObjectCallAsFunction(context, function, object ? object : JSContextGetGlobalObject(context), (size_t) argc, argv, &error);

	if (error) {
		JavaScriptContextHandleError(context, error);
	}

	return value;
}

JSValueRef
JavaScriptValueCallMethod(JSContextRef context, JSObjectRef target, const char* method, unsigned int argc, const JSValueRef argv[])
{
	JSObjectRef object = JavaScriptValueToObject(context, target);
	if (object == nullptr) {
		return nullptr;
	}

	JSObjectRef function = JavaScriptValueToObject(context, JavaScriptValueGetProperty(context, object, method));
	if (function == nullptr) {
		return nullptr;
	}

	JSValueRef error = nullptr;
	JSValueRef value = JSObjectCallAsFunction(context, function, object, argc, argv, &error);

	if (error) {
		JavaScriptContextHandleError(context, error);
	}

	return value;
}

JSValueRef
JavaScriptValueConstruct(JSContextRef context, JSObjectRef target, unsigned int argc, JSValueRef argv[])
{
	JSObjectRef function = JavaScriptValueToObject(context, target);
	if (function == nullptr) {
		return nullptr;
	}

	JSValueRef error = nullptr;
	JSValueRef value = JSObjectCallAsConstructor(context, function, argc, argv, &error);

	if (error) {
		JavaScriptContextHandleError(context, error);
	}

	return value;
}

void
JavaScriptValueSetPrototype(JSContextRef context, JSObjectRef target, JSValueRef prototype)
{
	JSObjectRef object = JavaScriptValueToObject(context, target);
	if (object == nullptr) {
		return;
	}

	JSObjectSetPrototype(context, object, prototype);
}

JSValueRef
JavaScriptValueGetPrototype(JSContextRef context, JSObjectRef target)
{
	JSObjectRef object = JavaScriptValueToObject(context, target);
	if (object == nullptr) {
		return nullptr;
	}

	return JSObjectGetPrototype(context, object);
}

JSObjectRef
JavaScriptValueGetPrototypeOfConstructor(JSContextRef context, JSObjectRef constructor)
{
	JSValueRef error = nullptr;
	JSValueRef value = JavaScriptValueGetProperty(context, constructor, "prototype");

	JSObjectRef object = JSValueToObject(context, value, &error);

	if (error) {
		JavaScriptContextHandleError(context, error);
	}

	return object;
}

JSObjectRef
JavaScriptValueGetPrototypeOfNativeConstructor(JSContextRef context, const char* constructor)
{
	JSStringRef objstr = JSStringCreateWithUTF8CString(constructor);
	JSStringRef keystr = JSStringCreateWithUTF8CString("prototype");
	JSObjectRef global = JSContextGetGlobalObject(context);
	JSObjectRef object = (JSObjectRef) JSObjectGetProperty(context, global, objstr, nullptr);
	JSObjectRef cproto = (JSObjectRef) JSObjectGetProperty(context, object, keystr, nullptr);
	JSStringRelease(objstr);
	JSStringRelease(keystr);
	return cproto;
}

void
JavaScriptValueSetAttribute(JSContextRef context, JSObjectRef object, long long key, void *value)
{
	JavaScriptValueDataRef data = JavaScriptValueDataGet(object);

	if (data == nullptr) {
		cerr << "Attributes is only supported by natively created objects.";
		return;
	}

	JavaScriptValueDataSetAttribute(data, key, value);
}

void *
JavaScriptValueGetAttribute(JSContextRef context, JSObjectRef object, long long key)
{
	JavaScriptValueDataRef data = JavaScriptValueDataGet(object);

	if (data == nullptr) {
		cerr << "Attributes is only supported by natively created objects.";
		return nullptr;
	}

	return JavaScriptValueDataGetAttribute(data, key);
}

void
JavaScriptValueSetAssociatedObject(JSContextRef context, JSObjectRef object, void *associatedObject)
{
	JavaScriptValueDataRef data = JavaScriptValueDataGet(object);

	if (data == nullptr) {
		cerr << "Associated Object is only supported by natively created objects.";
		return;
	}

	data->associatedObject = associatedObject;
}

void *
JavaScriptValueGetAssociatedObject(JSContextRef context, JSObjectRef object)
{
	JavaScriptValueDataRef data = JavaScriptValueDataGet(object);

	if (data == nullptr) {
		cerr << "Associated Object is only supported by natively created objects.";
		return nullptr;
	}

	return data->associatedObject;
}

void
JavaScriptValueSetFinalizeHandler(JSContextRef context, JSObjectRef object, JavaScriptValueFinalizeCallback callback)
{
	JavaScriptValueDataRef data = JavaScriptValueDataGet(object);

	if (data == nullptr) {
		cerr << "Finalize holder is only supported by natively created objects.";
		return;
	}

	data->finalizeCallback = callback;
}

bool
JavaScriptValueEquals(JSContextRef context, JSValueRef value1, JSValueRef value2)
{
	return JSValueIsStrictEqual(context, value1, value2);
}

bool
JavaScriptValueEqualsString(JSContextRef context, JSValueRef value1, const char* value2)
{
	return JavaScriptValueEquals(context, value1, JavaScriptValueCreateString(context, value2));
}

bool
JavaScriptValueEqualsNumber(JSContextRef context, JSValueRef value1, double value2)
{
	return JavaScriptValueEquals(context, value1, JavaScriptValueCreateNumber(context, value2));
}

bool
JavaScriptValueEqualsBoolean(JSContextRef context, JSValueRef value1, bool value2)
{
	return JavaScriptValueEquals(context, value1, JavaScriptValueCreateBoolean(context, value2));
}

bool
JavaScriptValueIsString(JSContextRef context, JSValueRef value)
{
	return JSValueIsString(context, value);
}

bool
JavaScriptValueIsNumber(JSContextRef context, JSValueRef value)
{
	return JSValueIsNumber(context, value);
}

bool
JavaScriptValueIsBoolean(JSContextRef context, JSValueRef value)
{
	return JSValueIsBoolean(context, value);
}

bool
JavaScriptValueIsObject(JSContextRef context, JSValueRef value)
{
	return JSValueIsObject(context, value);
}

bool
JavaScriptValueIsArray(JSContextRef context, JSValueRef value)
{
	return JSValueIsArray(context, value);
}

bool
JavaScriptValueIsFunction(JSContextRef context, JSValueRef value)
{
	return JSValueIsObject(context, value) && JSObjectIsFunction(context, (JSObjectRef) value);
}

bool
JavaScriptValueIsUndefined(JSContextRef context, JSValueRef value)
{
	return JSValueIsUndefined(context, value);
}

bool
JavaScriptValueIsNull(JSContextRef context, JSValueRef value)
{
	return JSValueIsNull(context, value);
}

JavaScriptValueType
JavaScriptValueGetType(JSContextRef context, JSValueRef value)
{
	switch (JSValueGetType(context, value)) {

		case kJSTypeUndefined:
			return kJavaScriptValueTypeUndefined;

		case kJSTypeNull:
			return kJavaScriptValueTypeNull;

		case kJSTypeBoolean:
			return kJavaScriptValueTypeBoolean;

		case kJSTypeNumber:
			return kJavaScriptValueTypeNumber;

		case kJSTypeString:
			return kJavaScriptValueTypeString;

		case kJSTypeObject:

			if (JSObjectIsFunction(context, const_cast<JSObjectRef>(value)) ||
				JSObjectIsConstructor(context, const_cast<JSObjectRef>(value))) {
				return kJavaScriptValueTypeFunction;
			}

			if (JSValueIsArray(context, value)) {
				return kJavaScriptValueTypeArray;
			}

			return kJavaScriptValueTypeObject;

		default:
			break;
	}

	assert(false);
}

JSObjectRef
JavaScriptValueToObject(JSContextRef context, JSValueRef value)
{
	JSValueRef error = nullptr;
	JSObjectRef object = JSValueToObject(context, value, &error);

	if (error) {
		JavaScriptContextHandleError(context, error);
		return nullptr;
	}

	return object;
}

const char*
JavaScriptValueToString(JSContextRef context, JSValueRef value)
{
	JSValueRef error = nullptr;

	JSStringRef string = JSValueToStringCopy(context, value, &error);

	if (error) {
		JavaScriptContextHandleError(context, error);
	}

	size_t length = JSStringGetMaximumUTF8CStringSize(string);

	char* buffer = new char[length];
	JSStringGetUTF8CString(string, buffer, length);
	JSStringRelease(string);
	return buffer;
}

double
JavaScriptValueToNumber(JSContextRef context, JSValueRef value)
{
	JSValueRef error = nullptr;

	double result = JSValueToNumber(context, value, &error);

	if (error) {
		JavaScriptContextHandleError(context, error);
	}

	return result;
}

bool
JavaScriptValueToBoolean(JSContextRef context, JSValueRef value)
{
	return JSValueToBoolean(context, value);
}

void
JavaScriptValueDataSetAttribute(JavaScriptValueDataRef data, long long key, void *value)
{
	if (value == nullptr) {
		data->attributes.erase(key);
		return;
	}

	data->attributes[key] = value;
}

void *
JavaScriptValueDataGetAttribute(JavaScriptValueDataRef data, long long key)
{
	return data->attributes[key];
}

void
JavaScriptValueDataSetAssociatedObject(JavaScriptValueDataRef data, void *associatedObject)
{
	data->associatedObject = associatedObject;
}

void *
JavaScriptValueDataGetAssociatedObject(JavaScriptValueDataRef data)
{
	return data->associatedObject;
}

void
JavaScriptValueForEach(JSContextRef context, JSValueRef value, JavaScriptValueForEachHandler callback, void* data)
{
	JSObjectRef object = JavaScriptValueToObject(context, value);
	if (object == nullptr) {
		return;
	}

	JSValueRef length = JavaScriptValueGetProperty(context, object, "length");
	if (length == nullptr) {
		return;
	}

	int len = (int) JavaScriptValueToNumber(context, length);

	for (int i = 0; i < len; i++) {
		callback(context, JavaScriptValueGetPropertyAtIndex(context, object, i), i, data);
	}
}

void
JavaScriptValueForOwn(JSContextRef context, JSValueRef value, JavaScriptValueForOwnHandler callback, void* data)
{
	JSObjectRef object = JavaScriptValueToObject(context, value);
	if (object == nullptr) {
		return;
	}

	JSPropertyNameArrayRef properties = JSObjectCopyPropertyNames(context, object);

	size_t len = JSPropertyNameArrayGetCount(properties);

	for (size_t i = 0; i < len; i++) {

		JSStringRef name = JSPropertyNameArrayGetNameAtIndex(properties, i);
		auto string = JavaScriptStringCreaste(name);
		JSStringRelease(name);

		callback(context, JavaScriptValueGetProperty(context, object, string), string, data);

		JavaScriptStringDelete(string);
	}
}
