#include "jni_module_display.h"

jclass DisplayClass;
jclass DisplayNodeClass;
jclass SizeFClass2;
jclass ParseErrorClass;

jmethodID SizeFGetWidthMethod;
jmethodID SizeFGetHeightMethod;

jmethodID DisplayPrepareMethod;
jmethodID DisplayResolveMethod;

jmethodID DisplayNodeInvalidateMethod;
jmethodID DisplayNodeResolveSizeMethod;
jmethodID DisplayNodeResolveOriginMethod;
jmethodID DisplayNodeResolveInnerSizeMethod;
jmethodID DisplayNodeResolveContentSizeMethod;
jmethodID DisplayNodeResolveMarginMethod;
jmethodID DisplayNodeResolveBorderMethod;
jmethodID DisplayNodeResolvePaddingMethod;
jmethodID DisplayNodePrepareLayoutMethod;
jmethodID DisplayNodeResolveLayoutMethod;
jmethodID DisplayNodeMeasureMethod;
jmethodID DisplayNodeUpdateMethod;

jmethodID ParseErrorConstructor;

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

	ParseErrorClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/view/display/exception/ParseError"
	);

	DisplayPrepareMethod = JNIGetMethod(
		env,
		DisplayClass,
		"onPrepare",
		"()V"
	);

	DisplayResolveMethod = JNIGetMethod(
		env,
		DisplayClass,
		"onResolve",
		"()V"
	);

	DisplayNodeInvalidateMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"onInvalidate",
		"()V"
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

	DisplayNodePrepareLayoutMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"onPrepareLayout",
		"()V"
	);

	DisplayNodeResolveLayoutMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"onResolveLayout",
		"()V"
	);


	DisplayNodeMeasureMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"measure",
		"(DDDDDD)Landroid/util/SizeF;"
	);

	DisplayNodeUpdateMethod = JNIGetMethod(
		env,
		DisplayNodeClass,
		"update",
		"(Ljava/lang/String;J)V"
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

	ParseErrorConstructor = JNIGetMethod(
		env,
		ParseErrorClass,
		"<init>",
		"(Ljava/lang/String;IILjava/lang/String;)V"
	);
	
	SizeFClass2  = JNIGlobalRef(env, SizeFClass2);
	DisplayClass = JNIGlobalRef(env, DisplayClass);
	DisplayNodeClass = JNIGlobalRef(env, DisplayNodeClass);
	ParseErrorClass = JNIGlobalRef(env, ParseErrorClass);
}
