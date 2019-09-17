#include "DisplayNodeWrapper.h"

#include "jni_module_view.h"

static void
invalidateCallback(DisplayNodeRef node)
{
	const auto wrapper =  reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeInvalidateMethod
	);
}


static void
measureSizeCallback(DisplayNodeRef node, DisplayNodeMeasuredSize *measure, double w, double h, double minw, double maxw, double minh, double maxh)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == NULL) {
		return;
	}

	jobject result = wrapper->env->CallObjectMethod(
		wrapper->object,
		DisplayNodeMeasureSizeMethod,
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
resolveSizeCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveSizeMethod
	);
}

static void
resolveOriginCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveOriginMethod
	);
}

static void
resolveInnerSizeCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveInnerSizeMethod
	);
}

static void
resolveContentSizeCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveContentSizeMethod
	);
}

static void
resolveMarginCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveMarginMethod
	);
}

static void
resolveBorderCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolveBorderMethod
	);
}

static void
resolvePaddingCallback(DisplayNodeRef node)
{
	const auto wrapper = reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeResolvePaddingMethod
	);
}

static void
layoutBeganCallback(DisplayNodeRef node)
{
	const auto wrapper =  reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeLayoutBeganMethod
	);
}

static void
layoutEndedCallback(DisplayNodeRef node)
{
	const auto wrapper =  reinterpret_cast<DisplayNodeWrapperRef>(DisplayNodeGetData(node));

	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayNodeLayoutEndedMethod
	);
}


DisplayNodeWrapperRef
DisplayNodeWrapperCreate(JNIEnv* env, jobject object, DisplayNodeRef node)
{
	const auto wrapper = new DisplayNodeWrapper();
	wrapper->env = env;
	wrapper->object = env->NewWeakGlobalRef(object);

	DisplayNodeSetInvalidateCallback(node, &invalidateCallback);
	DisplayNodeSetMeasureSizeCallback(node, &measureSizeCallback);
	DisplayNodeSetResolveSizeCallback(node, &resolveSizeCallback);
	DisplayNodeSetResolveOriginCallback(node, &resolveOriginCallback);
	DisplayNodeSetResolveInnerSizeCallback(node, &resolveInnerSizeCallback);
	DisplayNodeSetResolveContentSizeCallback(node, &resolveContentSizeCallback);
	DisplayNodeSetResolveMarginCallback(node, &resolveMarginCallback);
	DisplayNodeSetResolveBorderCallback(node, &resolveBorderCallback);
	DisplayNodeSetResolvePaddingCallback(node, &resolvePaddingCallback);
	DisplayNodeSetLayoutBeganCallback(node, &layoutBeganCallback);
	DisplayNodeSetLayoutEndedCallback(node, &layoutEndedCallback);

	return wrapper;
}

void
DisplayNodeWrapperDelete(JNIEnv* env, DisplayNodeWrapperRef wrapper)
{
	env->DeleteWeakGlobalRef(wrapper->object);
	delete wrapper;
}