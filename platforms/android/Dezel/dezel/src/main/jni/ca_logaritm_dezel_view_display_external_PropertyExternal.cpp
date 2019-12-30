#include "jni_init.h"
#include "jni_module_display.h"
#include "PropertyRef.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Class:     ca_logaritm_dezel_view_display_external_PropertyExternal
 * Method:    getValues
 * Signature: (J)J
 */
jlong Java_ca_logaritm_dezel_view_display_external_PropertyExternal_getValues(JNIEnv* env, jclass, jlong propertyPtr) {
	return reinterpret_cast<jlong>(
		PropertyGetValues(reinterpret_cast<PropertyRef>(propertyPtr))
	);
}

#ifdef __cplusplus
}
#endif
