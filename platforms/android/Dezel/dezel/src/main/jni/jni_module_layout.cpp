#include "jni_module_layout.h"

jclass LayoutClass;
jclass LayoutNodeClass;
jclass SizeFClass;

jmethodID SizeFGetWidth;
jmethodID SizeFGetHeight;

jmethodID LayoutDispatchLayoutBeganEvent;
jmethodID LayoutDispatchLayoutEndedEvent;

jmethodID LayoutPrepareCallback;
jmethodID LayoutMeasureCallback;
jmethodID LayoutResolveSizeCallback;
jmethodID LayoutResolvePositionCallback;
jmethodID LayoutResolveInnerSizeCallback;
jmethodID LayoutResolveContentSizeCallback;
jmethodID LayoutResolveMarginCallback;
jmethodID LayoutResolveBorderCallback;
jmethodID LayoutResolvePaddingCallback;
jmethodID LayoutLayoutBeganCallback;
jmethodID LayoutLayoutEndedCallback;
jmethodID LayoutInvalidateCallback;

void
JNI_OnLoad_layout(JNIEnv *env)
{
	SizeFClass = JNIGetClass(
		env,
		"android/util/SizeF"
	);

	LayoutClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/layout/Layout"
	);

	LayoutNodeClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/layout/LayoutNode"
	);

	LayoutDispatchLayoutBeganEvent = JNIGetMethod(
		env,
		LayoutClass,
		"dispatchLayoutBeganEvent",
		"()V"
	);

	LayoutDispatchLayoutEndedEvent = JNIGetMethod(
		env,
		LayoutClass,
		"dispatchLayoutEndedEvent",
		"()V"
	);

	LayoutPrepareCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"prepareCallback",
		"()V"
	);

	LayoutMeasureCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"measureCallback",
		"(DDDDDD)Landroid/util/SizeF;"
	);

	LayoutResolveSizeCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"resolveSizeCallback",
		"()V"
	);

	LayoutResolvePositionCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"resolvePositionCallback",
		"()V"
	);

	LayoutResolveInnerSizeCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"resolveInnerSizeCallback",
		"()V"
	);

	LayoutResolveContentSizeCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"resolveContentSizeCallback",
		"()V"
	);

	LayoutResolveMarginCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"resolveMarginCallback",
		"()V"
	);

	LayoutResolveBorderCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"resolveBorderCallback",
		"()V"
	);

	LayoutResolvePaddingCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"resolvePaddingCallback",
		"()V"
	);

	LayoutInvalidateCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"invalidateCallback",
		"()V"
	);

	LayoutLayoutBeganCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"layoutBeganCallback",
		"()V"
	);

	LayoutLayoutEndedCallback = JNIGetMethod(
		env,
		LayoutNodeClass,
		"layoutEndedCallback",
		"()V"
	);

	SizeFGetWidth = JNIGetMethod(
		env,
		SizeFClass,
		"getWidth",
		"()F"
	);

	SizeFGetHeight = JNIGetMethod(
		env,
		SizeFClass,
		"getHeight",
		"()F"
	);

	SizeFClass  = (jclass) env->NewGlobalRef(SizeFClass);
	LayoutClass = (jclass) env->NewGlobalRef(LayoutClass);
}
