#include "DisplayWrapper.h"
#include "DisplayRef.h"
#include "DisplayNodeRef.h"

#include <jni_module_display.h>

static void
displayPrepareCallback(DisplayRef display)
{
	const auto wrapper =  reinterpret_cast<DisplayWrapperRef>(DisplayGetData(display));
	
	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayPrepareMethod
	);
}

static void
displayResolveCallback(DisplayRef display)
{
	const auto wrapper =  reinterpret_cast<DisplayWrapperRef>(DisplayGetData(display));

	if (wrapper == nullptr) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayResolveMethod
	);
}

DisplayWrapperRef
DisplayWrapperCreate(JNIEnv* env, jobject object, DisplayRef display)
{
	auto wrapper = new DisplayWrapper();
	wrapper->env = env;
	wrapper->object = env->NewWeakGlobalRef(object);

	DisplaySetPrepareCallback(display, &displayPrepareCallback);
	DisplaySetResolveCallback(display, &displayResolveCallback);

	return wrapper;
}

void
DisplayWrapperDelete(JNIEnv* env, DisplayWrapperRef wrapper)
{
	env->DeleteWeakGlobalRef(wrapper->object);
	delete wrapper;
}