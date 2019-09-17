#include <DLLayoutNodePrivate.h>
#include "jni_module_layout.h"
#include "LayoutNodeWrapper.h"

static void
LayoutNodePrepareCallback(DLLayoutNodeRef node)
{
	LayoutNodeWrapperRef wrapper = reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutPrepareCallback
	);
}

static void
LayoutNodeMeasureCallback(DLLayoutNodeRef node, DLLayoutNodeMeasure *measure, double w, double h, double minw, double maxw, double minh, double maxh)
{
	LayoutNodeWrapperRef wrapper = reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	jobject result = wrapper->env->CallObjectMethod(
		wrapper->object,
		LayoutMeasureCallback,
		w, h,
		minw, maxw,
		minh, maxh
	);

	JNI_CHECK_EXCEPTION(wrapper->env);

	double measuredW = static_cast<double>(wrapper->env->CallFloatMethod(result, SizeFGetWidth));
	double measuredH = static_cast<double>(wrapper->env->CallFloatMethod(result, SizeFGetHeight));

	if (measuredW > -1) measure->width = measuredW;
	if (measuredH > -1) measure->height = measuredH;
}

static void
LayoutNodeResolveSizeCallback(DLLayoutNodeRef node)
{
	LayoutNodeWrapperRef wrapper = reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutResolveSizeCallback
	);
}

static void
LayoutNodeResolvePositionCallback(DLLayoutNodeRef node)
{
	LayoutNodeWrapperRef wrapper = reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutResolvePositionCallback
	);
}

static void
LayoutNodeResolveInnerSizeCallback(DLLayoutNodeRef node)
{
	LayoutNodeWrapperRef wrapper = reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutResolveInnerSizeCallback
	);
}

static void
LayoutNodeResolveContentSizeCallback(DLLayoutNodeRef node)
{
	LayoutNodeWrapperRef wrapper = reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutResolveContentSizeCallback
	);
}

static void
LayoutNodeResolveMarginCallback(DLLayoutNodeRef node)
{
	LayoutNodeWrapperRef wrapper = reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutResolveMarginCallback
	);
}

static void
LayoutNodeResolveBorderCallback(DLLayoutNodeRef node)
{
	LayoutNodeWrapperRef wrapper = reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutResolveBorderCallback
	);
}

static void
LayoutNodeResolvePaddingCallback(DLLayoutNodeRef node)
{
	LayoutNodeWrapperRef wrapper = reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutResolvePaddingCallback
	);
}

static void
DLLayoutNodeLayoutBeganCallback(DLLayoutNodeRef node)
{
	LayoutNodeWrapperRef wrapper =  reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutLayoutBeganCallback
	);
}

static void
DLLayoutNodeLayoutEndedCallback(DLLayoutNodeRef node)
{
	LayoutNodeWrapperRef wrapper =  reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutLayoutEndedCallback
	);
}

static void
LayoutNodeInvalidateCallback(DLLayoutNodeRef node)
{
	LayoutNodeWrapperRef wrapper =  reinterpret_cast<LayoutNodeWrapperRef>(DLLayoutNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutInvalidateCallback
	);
}

LayoutNodeWrapperRef
LayoutNodeWrapperCreate(JNIEnv* env, jobject object, DLLayoutNodeRef node)
{
	auto wrapper = new LayoutNodeWrapper();
	wrapper->env = env;
	wrapper->object = env->NewWeakGlobalRef(object);

	DLLayoutNodeSetPrepareCallback(node, &LayoutNodePrepareCallback);
	DLLayoutNodeSetMeasureCallback(node, &LayoutNodeMeasureCallback);
	DLLayoutNodeSetResolveSizeCallback(node, &LayoutNodeResolveSizeCallback);
	DLLayoutNodeSetResolvePositionCallback(node, &LayoutNodeResolvePositionCallback);
	DLLayoutNodeSetResolveInnerSizeCallback(node, &LayoutNodeResolveInnerSizeCallback);
	DLLayoutNodeSetResolveContentSizeCallback(node, &LayoutNodeResolveContentSizeCallback);
	DLLayoutNodeSetResolveMarginCallback(node, &LayoutNodeResolveMarginCallback);
	DLLayoutNodeSetResolveBorderCallback(node, &LayoutNodeResolveBorderCallback);
	DLLayoutNodeSetResolvePaddingCallback(node, &LayoutNodeResolvePaddingCallback);
	DLLayoutNodeSetLayoutBeganCallback(node, &DLLayoutNodeLayoutBeganCallback);
	DLLayoutNodeSetLayoutEndedCallback(node, &DLLayoutNodeLayoutEndedCallback);
	DLLayoutNodeSetInvalidateCallback(node, &LayoutNodeInvalidateCallback);

	return wrapper;
}

void
LayoutNodeWrapperDelete(JNIEnv* env, LayoutNodeWrapperRef wrapper)
{
	env->DeleteWeakGlobalRef(wrapper->object);
	delete wrapper;
}