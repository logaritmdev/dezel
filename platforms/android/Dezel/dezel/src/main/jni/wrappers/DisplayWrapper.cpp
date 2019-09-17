#include "DisplayWrapper.h"
#include "DisplayRef.h"
#include "DisplayNodeRef.h"

#include <jni_module_view.h>

static void
layoutBeganCallback(DisplayRef display)
{
	const auto wrapper =  reinterpret_cast<DisplayWrapperRef>(DisplayGetData(display));
	
	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayLayoutBeganMethod
	);
}

static void
layoutEndedCallback(DisplayRef display)
{
	const auto wrapper =  reinterpret_cast<DisplayWrapperRef>(DisplayGetData(display));

	if (wrapper == NULL) {
		return;
	}

	JNI_CALL_VOID_METHOD(
		wrapper->env,
		wrapper->object,
		DisplayLayoutEndedMethod
	);
}

DisplayWrapperRef
DisplayWrapperCreate(JNIEnv* env, jobject object, DisplayRef display)
{
	auto wrapper = new DisplayWrapper();
	wrapper->env = env;
	wrapper->object = env->NewWeakGlobalRef(object);

	DisplaySetLayoutBeganCallback(display, &layoutBeganCallback);
	DisplaySetLayoutEndedCallback(display, &layoutEndedCallback);

	return wrapper;
}

void
DisplayWrapperDelete(JNIEnv* env, DisplayWrapperRef wrapper)
{
	env->DeleteWeakGlobalRef(wrapper->object);
	delete wrapper;
}