#ifndef StylesheetRef_h
#define StylesheetRef_h

#include "DisplayBase.h"

#if __cplusplus
extern "C" {
#endif

/**
 * @function StylesheetCreate;
 * @since 0.7.0
 * @hidden
 */
StylesheetRef StylesheetCreate();

/**
 * @function StylesheetDelete
 * @since 0.7.0
 * @hidden
 */
void StylesheetDelete(StylesheetRef stylesheet);

/**
 * @function StylesheetSetVariable
 * @since 0.7.0
 * @hidden
 */
void StylesheetSetVariable(StylesheetRef stylesheet, const char* name, const char* value, ParseError** error);

/**
 * @function StylesheetEvaluate
 * @since 0.7.0
 * @hidden
 */
void StylesheetEvaluate(StylesheetRef stylesheet, const char* source, const char* url, ParseError** error);

#if __cplusplus
}
#endif

#endif
