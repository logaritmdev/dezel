#ifndef ValueListRef_h
#define ValueListRef_h

#include "DisplayBase.h"

#if __cplusplus
extern "C" {
#endif

/**
* @function ValueListDelete
* @since 0.7.0
* @hidden
*/
void ValueListDelete(ValueListRef values);

/**
 * @function ValueListGetCount
 * @since 0.7.0
 * @hidden
 */
size_t ValueListGetCount(ValueListRef values);

/**
 * @function ValueListGetValue
 * @since 0.7.0
 * @hidden
 */
ValueRef ValueListGetValue(ValueListRef values, size_t index);

#if __cplusplus
}
#endif
#endif
