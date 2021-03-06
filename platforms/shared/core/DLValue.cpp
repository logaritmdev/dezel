#include <unordered_map>
#include <iostream>
#include "DLContext.h"
#include "DLValue.h"
#include "DLValuePrivate.h"

using std::cerr;

JSValueRef
DLValueCreateNull(JSContextRef context)
{
	return JSValueMakeNull(context);
}

JSValueRef
DLValueCreateUndefined(JSContextRef context)
{
	return JSValueMakeUndefined(context);
}

JSValueRef
DLValueCreateString(JSContextRef context, DLString value)
{
	JSStringRef string = JSStringCreateWithUTF8CString(value);
	JSValueRef result = JSValueMakeString(context, string);
	JSStringRelease(string);
	return result;
}

JSValueRef
DLValueCreateNumber(JSContextRef context, DLNumber value)
{
	return JSValueMakeNumber(context, value);
}

JSValueRef
DLValueCreateBoolean(JSContextRef context, DLBoolean value)
{
	return JSValueMakeBoolean(context, value);
}

JSObjectRef
DLValueCreateEmptyObject(JSContextRef context, JSObjectRef proto)
{
	JSClassDefinition def = kJSClassDefinitionEmpty;

	def.finalize = &DLValueFinalizeHandler;
	def.callAsFunction = NULL;
	def.callAsConstructor = NULL;

	if (proto) {
		def.attributes = kJSClassAttributeNoAutomaticPrototype;
	}

	JSClassRef cls = JSClassCreate(&def);
	JSObjectRef object = JSObjectMake(context, cls, DLValueDataCreate(context));
	JSClassRelease(cls);

	if (proto) {
		DLValueSetPrototype(context, object, proto);
	}

	return object;
}

JSObjectRef
DLValueCreateEmptyArray(JSContextRef context)
{
	JSValueRef error = NULL;
	JSValueRef array = JSObjectMakeArray(context, 0, NULL, &error);

	if (error) {
		DLContextHandleError(context, error);
	}

	return (JSObjectRef) array;
}

JSObjectRef
DLValueCreateFunction(JSContextRef context, DLFunctionCallback callback, DLString name)
{
	JSClassDefinition def = kJSClassDefinitionEmpty;

	def.attributes = kJSClassAttributeNoAutomaticPrototype;
	def.finalize = &DLFunctionFinalizeHandler;
	def.callAsFunction = &DLFunctionCallAsFunctionHandler;
	def.callAsConstructor = &DLFunctionCallAsConstructorHandler;

	DLValueDataRef data = DLValueDataCreate(context);

	JSClassRef obj = JSClassCreate(&kJSClassDefinitionEmpty);
	JSClassRef fnc = JSClassCreate(&def);
	JSObjectRef object = JSObjectMake(context, fnc, data);
	JSObjectRef cproto = JSObjectMake(context, obj, NULL);
	JSObjectRef parent = DLValueGetPrototypeOfNativeConstructor(context, "Function");

	data->functionCallback = callback;

	DLValueSetPrototype(context, object, parent);
	DLValueSetProperty(context, object, "prototype", cproto);
	DLValueSetProperty(context, cproto, "constructor", object);

	if (name) {

		DLValueDefineProperty(context, object, "name", NULL, NULL, DLValueCreateString(context, name), false, true, true);

		JSStringRef toStringName = JSStringCreateWithUTF8CString("string");
		JSObjectRef toStringFunc = JSObjectMakeFunctionWithCallback(context, toStringName, &DLFunctionConvertToStringHandler);
		JSStringRelease(toStringName);

		DLValueDefineProperty(context, object, "string", NULL, NULL, toStringFunc, false, true, true);
	}

	JSClassRelease(obj);
	JSClassRelease(fnc);

	return object;
}

void
DLValueProtect(JSContextRef context, JSValueRef value)
{
	JSValueProtect(context, value);
}

void
DLValueUnprotect(JSContextRef context, JSValueRef value)
{
	JSValueUnprotect(context, value);
}

void
DLValueDefineProperty(JSContextRef context, JSObjectRef target, DLString property, JSValueRef getter, JSValueRef setter, JSValueRef value, DLBoolean writable, DLBoolean enumerable, DLBoolean configurable)
{
	JSObjectRef object = DLValueToObject(context, target);
	if (object == NULL) {
		return;
	}

	JSObjectRef descriptor = DLValueCreateEmptyObject(context, NULL);

	JSValueRef args[3];
	args[0] = object;
	args[1] = DLValueCreateString(context, property);
	args[2] = descriptor;

	if (setter || getter) {
		if (getter) DLValueSetProperty(context, descriptor, "get", getter);
		if (setter) DLValueSetProperty(context, descriptor, "set", setter);
	} else {
		if (value) DLValueSetProperty(context, descriptor, "value", value);
		DLValueSetPropertyWithBoolean(context, descriptor, "writable", writable);
	}

	DLValueSetPropertyWithBoolean(context, descriptor, "enumerable", enumerable);
	DLValueSetPropertyWithBoolean(context, descriptor, "configurable", configurable);

	JSObjectRef global = JSContextGetGlobalObject(context);
	JSObjectRef glbobj = (JSObjectRef) DLValueGetProperty(context, global, "Object");
	JSObjectRef define = (JSObjectRef) DLValueGetProperty(context, glbobj, "defineProperty");
	DLValueCall(context, define, global, 3, args);
}

void
DLValueDefineConstructor(JSContextRef context, JSObjectRef prototype, JSObjectRef function)
{
	DLValueDefineProperty(context, prototype, "constructor", NULL, NULL, function, true, true, true);
}

void
DLValueDefineFunction(JSContextRef context, JSObjectRef prototype, DLString name, JSObjectRef function)
{
	DLValueDefineProperty(context, prototype, name, NULL, NULL, function, true, true, true);
}

void
DLValueDefinePropertySetter(JSContextRef context, JSObjectRef prototype, DLString name, JSObjectRef function)
{
	JSObjectRef descriptor = DLValueCreateEmptyObject(context, NULL);

	JSValueRef args[3];
	args[0] = prototype;
	args[1] = DLValueCreateString(context, name);
	args[2] = descriptor;

	DLValueSetProperty(context, descriptor, "set", function);
	DLValueSetPropertyWithBoolean(context, descriptor, "enumerable", true);
	DLValueSetPropertyWithBoolean(context, descriptor, "configurable", true);

	JSObjectRef global = JSContextGetGlobalObject(context);
	JSObjectRef glbobj = (JSObjectRef) DLValueGetProperty(context, global, "Object");
	JSObjectRef define = (JSObjectRef) DLValueGetProperty(context, glbobj, "defineProperty");
	DLValueCall(context, define, global, 3, args);
}

void
DLValueDefinePropertyGetter(JSContextRef context, JSObjectRef prototype, DLString name, JSObjectRef function)
{
	JSObjectRef descriptor = DLValueCreateEmptyObject(context, NULL);

	JSValueRef args[3];
	args[0] = prototype;
	args[1] = DLValueCreateString(context, name);
	args[2] = descriptor;

	DLValueSetProperty(context, descriptor, "get", function);
	DLValueSetPropertyWithBoolean(context, descriptor, "enumerable", true);
	DLValueSetPropertyWithBoolean(context, descriptor, "configurable", true);

	JSObjectRef global = JSContextGetGlobalObject(context);
	JSObjectRef glbobj = (JSObjectRef) DLValueGetProperty(context, global, "Object");
	JSObjectRef define = (JSObjectRef) DLValueGetProperty(context, glbobj, "defineProperty");
	DLValueCall(context, define, global, 3, args);
}

void
DLValueSetProperty(JSContextRef context, JSObjectRef target, DLString property, JSValueRef value)
{
	JSObjectRef object = DLValueToObject(context, target);
	if (object == NULL) {
		return;
	}

	JSValueRef error = NULL;

	JSStringRef string = JSStringCreateWithUTF8CString(property);
	JSObjectSetProperty(context, object, string, value, kJSPropertyAttributeNone, &error);
	JSStringRelease(string);

	if (error) {
		DLContextHandleError(context, error);
	}
}

void
DLValueSetPropertyWithString(JSContextRef context, JSObjectRef object, DLString property, DLString value)
{
	DLValueSetProperty(context, object, property, DLValueCreateString(context, value));
}

void
DLValueSetPropertyWithNumber(JSContextRef context, JSObjectRef object, DLString property, DLNumber value)
{
	DLValueSetProperty(context, object, property, DLValueCreateNumber(context, value));
}

void
DLValueSetPropertyWithBoolean(JSContextRef context, JSObjectRef object, DLString property, DLBoolean value)
{
	DLValueSetProperty(context, object, property, DLValueCreateBoolean(context, value));
}

JSValueRef
DLValueGetProperty(JSContextRef context, JSObjectRef target, DLString property)
{
	JSObjectRef object = DLValueToObject(context, target);
	if (object == NULL) {
		return NULL;
	}

	JSStringRef string = JSStringCreateWithUTF8CString(property);

	JSValueRef error = NULL;
	JSValueRef value = JSObjectGetProperty(context, object, string, &error);

	JSStringRelease(string);

	if (error) {
		DLContextHandleError(context, error);
	}

	return value;
}

DLString*
DLValueGetProperties(JSContextRef context, JSObjectRef target, int* count)
{
	JSObjectRef object = DLValueToObject(context, target);
	if (object == NULL) {
		return NULL;
	}

	JSPropertyNameArrayRef names = JSObjectCopyPropertyNames(context, object);

	int length = (int) JSPropertyNameArrayGetCount(names);
	if (length == 0) {
		return NULL;
	}

	DLString* properties = new DLString[length];

	for (int i = 0; i < length; i++) {

		//JSValueRef error = NULL;
		JSStringRef string = JSPropertyNameArrayGetNameAtIndex(names, i);
		//if (error) {
		//	DLContextHandleError(context, error);
		//}

		size_t len = JSStringGetMaximumUTF8CStringSize(string);
		char * str = (char *) malloc(sizeof(char) * len);
		JSStringGetUTF8CString(string, str, len);

		properties[i] = str;
	}

	JSPropertyNameArrayRelease(names);

	*count = length;

	return properties;
}

void
DLValueDeleteProperty(JSContextRef context, JSObjectRef target, DLString property)
{
	JSObjectRef object = DLValueToObject(context, target);
	if (object == NULL) {
		return;
	}

	JSValueRef error = NULL;

	JSStringRef string = JSStringCreateWithUTF8CString(property);
	JSObjectDeleteProperty(context, object, string, &error);
	JSStringRelease(string);

	if (error) {
		DLContextHandleError(context, error);
	}
}

void
DLValueSetPropertyAtIndex(JSContextRef context, JSObjectRef target, unsigned int index, JSValueRef value)
{
	JSObjectRef object = DLValueToObject(context, target);
	if (object == NULL) {
		return;
	}

	JSValueRef error = NULL;

	JSObjectSetPropertyAtIndex(context, object, index, value, &error);

	if (error) {
		DLContextHandleError(context, error);
	}
}

void
DLValueSetPropertyAtIndexWithString(JSContextRef context, JSObjectRef object, unsigned int index, DLString value)
{
	DLValueSetPropertyAtIndex(context, object, index, DLValueCreateString(context, value));
}

void
DLValueSetPropertyAtIndexWithNumber(JSContextRef context, JSObjectRef object, unsigned int index, DLNumber value)
{
	DLValueSetPropertyAtIndex(context, object, index, DLValueCreateNumber(context, value));
}

void
DLValueSetPropertyAtIndexWithBoolean(JSContextRef context, JSObjectRef object, unsigned int index, DLBoolean value)
{
	DLValueSetPropertyAtIndex(context, object, index, DLValueCreateBoolean(context, value));
}

JSValueRef
DLValueGetPropertyAtIndex(JSContextRef context, JSObjectRef target, unsigned int index)
{
	JSObjectRef object = DLValueToObject(context, target);
	if (object == NULL) {
		return NULL;
	}

	JSValueRef error = NULL;
	JSValueRef value = JSObjectGetPropertyAtIndex(context, object, index, &error);

	if (error) {
		DLContextHandleError(context, error);
	}

	return value;
}

JSValueRef
DLValueCall(JSContextRef context, JSObjectRef target, JSObjectRef object, unsigned int argc, const JSValueRef argv[])
{
	JSObjectRef function = DLValueToObject(context, target);
	if (function == NULL) {
		return NULL;
	}

	JSValueRef error = NULL;
	JSValueRef value = JSObjectCallAsFunction(context, function, object ? object : JSContextGetGlobalObject(context), (size_t) argc, argv, &error);

	if (error) {
		DLContextHandleError(context, error);
	}

	return value;
}

JSValueRef
DLValueCallMethod(JSContextRef context, JSObjectRef target, DLString method, unsigned int argc, const JSValueRef argv[])
{
	JSObjectRef object = DLValueToObject(context, target);
	if (object == NULL) {
		return NULL;
	}

	JSObjectRef function = DLValueToObject(context, DLValueGetProperty(context, object, method));
	if (function == NULL) {
		return NULL;
	}

	JSValueRef error = NULL;
	JSValueRef value = JSObjectCallAsFunction(context, function, object, argc, argv, &error);

	if (error) {
		DLContextHandleError(context, error);
	}

	return value;
}

JSValueRef
DLValueConstruct(JSContextRef context, JSObjectRef target, unsigned int argc, JSValueRef argv[])
{
	JSObjectRef function = DLValueToObject(context, target);
	if (function == NULL) {
		return NULL;
	}

	JSValueRef error = NULL;
	JSValueRef value = JSObjectCallAsConstructor(context, function, argc, argv, &error);

	if (error) {
		DLContextHandleError(context, error);
	}

	return value;
}

void
DLValueSetPrototype(JSContextRef context, JSObjectRef target, JSValueRef prototype)
{
	JSObjectRef object = DLValueToObject(context, target);
	if (object == NULL) {
		return;
	}

	JSObjectSetPrototype(context, object, prototype);
}

JSValueRef
DLValueGetPrototype(JSContextRef context, JSObjectRef target)
{
	JSObjectRef object = DLValueToObject(context, target);
	if (object == NULL) {
		return NULL;
	}

	return JSObjectGetPrototype(context, object);
}

JSObjectRef
DLValueGetPrototypeOfConstructor(JSContextRef context, JSObjectRef constructor)
{
	JSValueRef error = NULL;
	JSValueRef value = DLValueGetProperty(context, constructor, "prototype");

	JSObjectRef object = JSValueToObject(context, value, &error);

	if (error) {
		DLContextHandleError(context, error);
	}

	return object;
}

JSObjectRef
DLValueGetPrototypeOfNativeConstructor(JSContextRef context, DLString constructor)
{
	JSStringRef objstr = JSStringCreateWithUTF8CString(constructor);
	JSStringRef keystr = JSStringCreateWithUTF8CString("prototype");
	JSObjectRef global = JSContextGetGlobalObject(context);
	JSObjectRef object = (JSObjectRef) JSObjectGetProperty(context, global, objstr, NULL);
	JSObjectRef cproto = (JSObjectRef) JSObjectGetProperty(context, object, keystr, NULL);
	JSStringRelease(objstr);
	JSStringRelease(keystr);
	return cproto;
}

void
DLValueSetAttribute(JSContextRef context, JSObjectRef object, long long key, void *value)
{
	DLValueDataRef data = DLValueDataGet(object);

	if (data == NULL) {
		cerr << "Attributes is only supported by natively created objects.";
		return;
	}

	DLValueDataSetAttribute(data, key, value);
}

void *
DLValueGetAttribute(JSContextRef context, JSObjectRef object, long long key)
{
	DLValueDataRef data = DLValueDataGet(object);

	if (data == NULL) {
		cerr << "Attributes is only supported by natively created objects.";
		return NULL;
	}

	return DLValueDataGetAttribute(data, key);
}

void
DLValueDeleteAttribute(JSContextRef context, JSObjectRef object, long long key)
{
	DLValueDataRef data = DLValueDataGet(object);

	if (data == NULL) {
		cerr << "Attributes is only supported by natively created objects.";
		return;
	}

	DLValueDataDeleteAttribute(data, key);
}

void
DLValueSetAssociatedObject(JSContextRef context, JSObjectRef object, void *associatedObject)
{
	DLValueDataRef data = DLValueDataGet(object);

	if (data == NULL) {
		cerr << "Associated Object is only supported by natively created objects.";
		return;
	}

	data->associatedObject = associatedObject;
}

void *
DLValueGetAssociatedObject(JSContextRef context, JSObjectRef object)
{
	DLValueDataRef data = DLValueDataGet(object);

	if (data == NULL) {
		cerr << "Associated Object is only supported by natively created objects.";
		return NULL;
	}

	return data->associatedObject;
}

void
DLValueSetFinalizeHandler(JSContextRef context, JSObjectRef object, DLFinalizeCallback callback)
{
	DLValueDataRef data = DLValueDataGet(object);

	if (data == NULL) {
		cerr << "Finalize holder is only supported by natively created objects.";
		return;
	}

	data->finalizeCallback = callback;
}

bool
DLValueEquals(JSContextRef context, JSValueRef value1, JSValueRef value2)
{
	return JSValueIsStrictEqual(context, value1, value2);
}

bool
DLValueEqualsString(JSContextRef context, JSValueRef value1, DLString value2)
{
	return DLValueEquals(context, value1, DLValueCreateString(context, value2));
}

bool
DLValueEqualsNumber(JSContextRef context, JSValueRef value1, DLNumber value2)
{
	return DLValueEquals(context, value1, DLValueCreateNumber(context, value2));
}

bool
DLValueEqualsBoolean(JSContextRef context, JSValueRef value1, DLBoolean value2)
{
	return DLValueEquals(context, value1, DLValueCreateBoolean(context, value2));
}

bool
DLValueIsString(JSContextRef context, JSValueRef value)
{
	return JSValueIsString(context, value);
}

bool
DLValueIsNumber(JSContextRef context, JSValueRef value)
{
	return JSValueIsNumber(context, value);
}

bool
DLValueIsBoolean(JSContextRef context, JSValueRef value)
{
	return JSValueIsBoolean(context, value);
}

bool
DLValueIsObject(JSContextRef context, JSValueRef value)
{
	return JSValueIsObject(context, value);
}

bool
DLValueIsArray(JSContextRef context, JSValueRef value)
{
	return JSValueIsArray(context, value);
}

bool
DLValueIsFunction(JSContextRef context, JSValueRef value)
{
	return JSValueIsObject(context, value) && JSObjectIsFunction(context, (JSObjectRef) value);
}

bool
DLValueIsUndefined(JSContextRef context, JSValueRef value)
{
	return JSValueIsUndefined(context, value);
}

bool
DLValueIsNull(JSContextRef context, JSValueRef value)
{
	return JSValueIsNull(context, value);
}

int
DLValueGetType(JSContextRef context, JSValueRef value)
{
	switch (JSValueGetType(context, value)) {

		case kJSTypeUndefined:
			return DL_TYPE_UNDEFINED;

		case kJSTypeNull:
			return DL_TYPE_NULL;

		case kJSTypeBoolean:
			return DL_TYPE_BOOLEAN;

		case kJSTypeNumber:
			return DL_TYPE_NUMBER;

		case kJSTypeString:
			return DL_TYPE_STRING;

		case kJSTypeObject:
			if (JSValueIsArray(context, value)) return DL_TYPE_ARRAY;
			if (JSObjectIsFunction(context, (JSObjectRef)value)) return DL_TYPE_FUNCTION;
			if (JSObjectIsConstructor(context, (JSObjectRef)value)) return DL_TYPE_FUNCTION;
			return DL_TYPE_OBJECT;
	}

	return 0;
}

JSObjectRef
DLValueToObject(JSContextRef context, JSValueRef value)
{
	JSValueRef error = NULL;
	JSObjectRef object = JSValueToObject(context, value, &error);

	if (error) {
		DLContextHandleError(context, error);
		return NULL;
	}

	return object;
}

DLString
DLValueToString(JSContextRef context, JSValueRef value)
{
	JSValueRef error = NULL;

	JSStringRef string = JSValueToStringCopy(context, value, &error);

	if (error) {
		DLContextHandleError(context, error);
	}

	size_t len = JSStringGetMaximumUTF8CStringSize(string);
	char *buf = new char[len];
	JSStringGetUTF8CString(string, buf, len);
	JSStringRelease(string);
	return buf;
}

DLNumber
DLValueToNumber(JSContextRef context, JSValueRef value)
{
	JSValueRef error = NULL;

	DLNumber result = JSValueToNumber(context, value, &error);

	if (error) {
		DLContextHandleError(context, error);
	}

	return result;
}

DLBoolean
DLValueToBoolean(JSContextRef context, JSValueRef value)
{
	return JSValueToBoolean(context, value);
}

void
DLValueDataSetAttribute(DLValueDataRef data, long long key, void *value)
{
	data->attributes[key] = value;
}

void *
DLValueDataGetAttribute(DLValueDataRef data, long long key)
{
	return data->attributes[key];
}

void
DLValueDataDeleteAttribute(DLValueDataRef data, long long key)
{
	data->attributes.erase(key);
}

void
DLValueDataSetAssociatedObject(DLValueDataRef data, void *associatedObject)
{
	data->associatedObject = associatedObject;
}

void *
DLValueDataGetAssociatedObject(DLValueDataRef data)
{
	return data->associatedObject;
}
