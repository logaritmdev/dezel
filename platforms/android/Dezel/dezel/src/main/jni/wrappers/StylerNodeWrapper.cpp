#include <DLStylerStyleItem.h>
#include <DLStylerStyleItemPrivate.h>
#include "jni_module_style.h"
#include "StylerNodeWrapper.h"

static void
DLInvalidateCallback(DLStylerNodeRef node)
{
	StylerNodeWrapperRef wrapper =  reinterpret_cast<StylerNodeWrapperRef>(DLStylerNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		StyleInvalidateCallback
	);
}

static void
DLApplyCallback(DLStylerNodeRef node, DLStylerStyleItemRef item)
{
	StylerNodeWrapperRef wrapper =  reinterpret_cast<StylerNodeWrapperRef>(DLStylerNodeGetData(node));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		StyleApplyCallback,
		reinterpret_cast<jlong>(node),
		reinterpret_cast<jlong>(item)
	);
}

bool
DLFetchCallback(DLStylerNodeRef node, DLStylerStyleItemRef item)
{
	StylerNodeWrapperRef wrapper =  reinterpret_cast<StylerNodeWrapperRef>(DLStylerNodeGetData(node));
	if (wrapper == NULL) {
		return false;
	}

	JNI_CALL_BOOL_METHOD(
		res,
		wrapper->env,
		wrapper->object,
		StyleFetchCallback,
		reinterpret_cast<jlong>(node),
		reinterpret_cast<jlong>(item)
	);

	return res;
}

StylerNodeWrapperRef
StylerNodeWrapperCreate(JNIEnv *env, jobject object, DLStylerNodeRef node)
{
	auto wrapper = new StylerNodeWrapper();
	wrapper->env = env;
	wrapper->object = env->NewWeakGlobalRef(object);

	DLStylerNodeSetApplyCallback(node, &DLApplyCallback);
	DLStylerNodeSetFetchCallback(node, &DLFetchCallback);
	DLStylerNodeSetInvalidateCallback(node, &DLInvalidateCallback);

	return wrapper;
}

void
StylerNodeWrapperDelete(JNIEnv *env, StylerNodeWrapperRef wrapper)
{
	env->DeleteWeakGlobalRef(wrapper->object);
	delete wrapper;
}