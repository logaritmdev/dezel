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
 * @function PropertyGetValueCount
 * @since 0.7.0
 * @hidden
 */
unsigned PropertyGetValueCount(PropertyRef property);

/**
 * @function PropertyGetValueType
 * @since 0.7.0
 * @hidden
 */
PropertyValueType PropertyGetValueType(PropertyRef property, unsigned index);

/**
 * @function PropertyGetValueUnit
 * @since 0.7.0
 * @hidden
 */
PropertyValueUnit PropertyGetValueUnit(PropertyRef property, unsigned index);

/**
 * @function PropertyGetValueAsString
 * @since 0.7.0
 * @hidden
 */
const char* PropertyGetValueAsString(PropertyRef property, unsigned index);

/**
 * @function PropertyGetValueAsNumber
 * @since 0.7.0
 * @hidden
 */
double PropertyGetValueAsNumber(PropertyRef property, unsigned index);

/**
 * @function PropertyGetValueAsBoolean
 * @since 0.7.0
 * @hidden
 */
bool PropertyGetValueAsBoolean(PropertyRef property, unsigned index);

#if __cplusplus
}
#endif
#endif 
