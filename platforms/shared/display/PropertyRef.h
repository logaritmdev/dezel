#ifndef PropertyRef_h
#define PropertyRef_h

#include "DisplayBase.h"

#if __cplusplus
extern "C" {
#endif

/**
 * @function PropertyGetName
 * @since 0.7.0
 * @hidden
 */
const char* PropertyGetName(PropertyRef property);

/**
 * @function PropertyGetValues
 * @since 0.7.0
 * @hidden
 */
ValueListRef PropertyGetValues(PropertyRef property);

#if __cplusplus
}
#endif
#endif 
