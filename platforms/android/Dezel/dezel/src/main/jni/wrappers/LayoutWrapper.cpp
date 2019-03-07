#include <jni_module_layout.h>
#include "LayoutWrapper.h"

static void
LayoutBeganCallback(DLLayoutRef layout)
{
	LayoutWrapperRef wrapper =  reinterpret_cast<LayoutWrapperRef>(DLLayoutGetData(layout));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutDispatchLayoutBeganEvent
	);
}

static void
LayoutEndedCallback(DLLayoutRef layout)
{
	LayoutWrapperRef wrapper =  reinterpret_cast<LayoutWrapperRef>(DLLayoutGetData(layout));
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		LayoutDispatchLayoutEndedEvent
	);
}

LayoutWrapperRef
LayoutWrapperCreate(JNIEnv *env, jobject object, DLLayoutRef node)
{
	LayoutWrapperRef wrapper = new LayoutWrapper();
	wrapper->env = env;
	wrapper->object = env->NewGlobalRef(object);

	DLLayoutSetLayoutBeganCallback(node, &LayoutBeganCallback);
	DLLayoutSetLayoutEndedCallback(node, &LayoutEndedCallback);

	return wrapper;
}