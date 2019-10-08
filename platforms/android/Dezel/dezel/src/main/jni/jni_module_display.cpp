#include "jni_module_view.h"

jclass DisplayClass;
jclass DisplayNodeClass;
jclass SizeFClass2;

jmethodID SizeFGetWidthMethod;
jmethodID SizeFGetHeightMethod;

jmethodID DisplayLayoutBeganMethod;
jmethodID DisplayLayoutEndedMethod;

jmethodID DisplayNodeInvalidateMethod;
jmethodID DisplayNodeMeasureSizeMethod;
jmethodID DisplayNodeResolveSizeMethod;
jmethodID DisplayNodeResolveOriginMethod;
jmethodID DisplayNodeResolveInnerSizeMethod;
jmethodID DisplayNodeResolveContentSizeMethod;
jmethodID DisplayNodeResolveMarginMethod;
jmethodID DisplayNodeResolveBorderMethod;
jmethodID DisplayNodeResolvePaddingMethod;
jmethodID DisplayNodeLayoutBeganMethod;
jmethodID DisplayNodeLayoutEndedMethod;

void
JNIDisplayModule(JNIEnv* env)
{
	SizeFClass2 = JNIGetClass(
		env,
		"android/util/SizeF"
	);

	DisplayClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/view/display/Display"
	);

	DisplayNodeClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/view/display/DisplayNode"
	);

	DisplayLayoutBeganMethod = JNIGetMethod(
		env,
		DisplayClass,
		"layoutBegan",
		"()V"
	);

	DisplayLayoutEndedMethod = JNIGetMethod(
		env,
		DisplayClass,
		"layoutEnded",
		"()V"
	);

	DisplayNodeInvalidateMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"onInvalidate",
		"()V"
	);

	DisplayNodeMeasureSizeMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"measure",
		"(DDDDDD)Landroid/util/SizeF;"
	);

	DisplayNodeResolveSizeMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"onResolveSize",
		"()V"
	);

	DisplayNodeResolveOriginMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"onResolveOrigin",
		"()V"
	);

	DisplayNodeResolveInnerSizeMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"onResolveInnerSize",
		"()V"
	);

	DisplayNodeResolveContentSizeMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"onResolveContentSize",
		"()V"
	);

	DisplayNodeResolveMarginMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"onResolveMargin",
		"()V"
	);

	DisplayNodeResolveBorderMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"onResolveBorder",
		"()V"
	);

	DisplayNodeResolvePaddingMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"onResolvePadding",
		"()V"
	);

	DisplayNodeLayoutBeganMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"layoutBegan",
		"()V"
	);

	DisplayNodeLayoutEndedMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"layoutEnded",
		"()V"
	);

	SizeFGetWidthMethod = JNIGetMethod(
		env,
		SizeFClass2,
		"getWidth",
		"()F"
	);

	SizeFGetHeightMethod = JNIGetMethod(
		env,
		SizeFClass2,
		"getHeight",
		"()F"
	);

	SizeFClass2  = JNIGlobalRef(env, SizeFClass2);
	DisplayClass = JNIGlobalRef(env, DisplayClass);
	DisplayNodeClass = JNIGlobalRef(env, DisplayNodeClass);
}
