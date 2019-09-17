#include "jni_module_style.h"

jclass StyleClass;

jmethodID StyleApplyCallback;
jmethodID StyleFetchCallback;
jmethodID StyleInvalidateCallback;

void
JNI_OnLoad_style(JNIEnv* env)
{
	StyleClass = JNIGetClass(
		env,
		"ca/logaritm/dezel/style/StylerNode"
	);

	StyleApplyCallback = JNIGetMethod(
		env,
		StyleClass,
		"applyCallback",
		"(JJ)V"
	);

	StyleFetchCallback = JNIGetMethod(
		env,
		StyleClass,
		"fetchCallback",
		"(JJ)Z"
	);

	StyleInvalidateCallback = JNIGetMethod(
		env,
		StyleClass,
		"invalidateCallback",
		"()V"
	);
}
