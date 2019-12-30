#include "DisplayNodeWrapper.h"

#include "jni_module_display.h"

static void
displayNodeInvalidateCallback(DisplayNodeRef node)
{
	const auto wrapper =  reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeInvalidateMethod
	);
}

static void
displayNodeResolveSizeCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveSizeMethod
	);
}

static void
displayNodeResolveOriginCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveOriginMethod
	);
}

static void
displayNodeResolveInnerSizeCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveInnerSizeMethod
	);
}

static void
displayNodeResolveContentSizeCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveContentSizeMethod
	);
}

static void
displayNodeResolveMarginCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveMarginMethod
	);
}

static void
displayNodeResolveBorderCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveBorderMethod
	);
}

static void
displayNodeResolvePaddingCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolvePaddingMethod
	);
}

static void
displayNodePrepareLayoutCallback(DisplayNodeRef node)
{
	const auto wrapper =  reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodePrepareLayoutMethod
	);
}

static void
displayNodeResolveLayoutCallback(DisplayNodeRef node)
{
	const auto wrapper =  reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveLayoutMethod
	);
}

static void
displayNodeMeasureCallback(DisplayNodeRef node, MeasuredSize *measure, double w, double h, double minw, double maxw, double minh, double maxh)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	jobject result = wrapper->env->CallObjectMethod(
		wrapper->object,
		DisplayNodeMeasureMethod,
		w, h,
		minw, maxw,
		minh, maxh
	);

	JNI_CHECK_EXCEPTION(wrapper->env);

	double measuredW = static_cast<double>(wrapper->env->CallFloatMethod(result, SizeFGetWidthMethod));
	double measuredH = static_cast<double>(wrapper->env->CallFloatMethod(result, SizeFGetHeightMethod));

	if (measuredW > -1) measure->width = measuredW;
	if (measuredH > -1) measure->height = measuredH;
}

static void
displayNodeUpdateCallback(DisplayNodeRef node, PropertyRef property, const char* name)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeUpdateMethod,
		wrapper->env->NewStringUTF(name),
		property == nullptr ? 0 : reinterpret_cast<jlong>(property)
	);

	JNI_CHECK_EXCEPTION(wrapper->env);
}

DisplayNodeWrapperRef
DisplayNodeWrapperCreate(JNIEnv* env, jobject object, DisplayNodeRef node)
{
	const auto wrapper = new DisplayNodeWrapper();
	wrapper->env = env;
	wrapper->object = env->NewWeakGlobalRef(object);

	DisplayNodeSetInvalidateCallback(node, &displayNodeInvalidateCallback);

	DisplayNodeSetResolveSizeCallback(node, &displayNodeResolveSizeCallback);
	DisplayNodeSetResolveOriginCallback(node, &displayNodeResolveOriginCallback);
	DisplayNodeSetResolveInnerSizeCallback(node, &displayNodeResolveInnerSizeCallback);
	DisplayNodeSetResolveContentSizeCallback(node, &displayNodeResolveContentSizeCallback);
	DisplayNodeSetResolveMarginCallback(node, &displayNodeResolveMarginCallback);
	DisplayNodeSetResolveBorderCallback(node, &displayNodeResolveBorderCallback);
	DisplayNodeSetResolvePaddingCallback(node, &displayNodeResolvePaddingCallback);
	DisplayNodeSetPrepareLayoutCallback(node, &displayNodePrepareLayoutCallback);
	DisplayNodeSetResolveLayoutCallback(node, &displayNodeResolveLayoutCallback);
	DisplayNodeSetMeasureCallback(node, &displayNodeMeasureCallback);
	DisplayNodeSetUpdateCallback(node, &displayNodeUpdateCallback);

	return wrapper;
}

void
DisplayNodeWrapperDelete(JNIEnv* env, DisplayNodeWrapperRef wrapper)
{
	env->DeleteWeakGlobalRef(wrapper->object);
	delete wrapper;
}