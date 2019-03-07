#ifndef DLStyler_h
#define DLStyler_h

/**
 * @typedef DLStylerRef
 * @since 0.1.0
 */
typedef struct OpaqueDLStyler* DLStylerRef;

/**
 * @typedef DLStylerNodeRef
 * @since 0.1.0
 */
typedef struct OpaqueDLStylerNode* DLStylerNodeRef; // forward declaration

/**
 * @typedef DLStylerStyleItemRef
 * @since 0.3.0
 */
typedef struct OpaqueDLStylerStyleItem* DLStylerStyleItemRef; // forward declaration

#if __cplusplus
extern "C" {
#endif

/**
 * Initializes a new styles styler.
 * @function DLStylerCreate
 * @since 0.1.0
 */
DLStylerRef DLStylerCreate();

/**
 * Deletes a styles styler.
 * @function DLStylerDelete
 * @since 0.1.0
 */
void DLStylerDelete(DLStylerRef styler);

/**
 * Assigns the styler root node.
 * @function DLStylerSetRoot
 * @since 0.1.0
 */
void DLStylerSetRoot(DLStylerRef styler, DLStylerNodeRef node);

/**
 * Loads the specified styles.
 * @function DLStylerLoadStyles
 * @since 0.3.0
 */
void DLStylerLoadStyles(DLStylerRef styler, const char* code, const char* file);

/**
 * Sets a variable that will be used within the styles of this styler.
 * @function DLStylerSetVariable
 * @since 0.3.0
 */
void DLStylerSetVariable(DLStylerRef styler, const char* name, const char* value);

/**
 * Prints the types definitions for debug purposes.
 * @function DLStylerPrintTypes
 * @since 0.3.0
 */
void DLStylerPrintTypes(DLStylerRef styler);

/**
 * Prints the rules definitions for debug purposes.
 * @function DLStylerPrintRules
 * @since 0.3.0
 */
void DLStylerPrintRules(DLStylerRef styler);

/**
 * Prints the detailed description of an item for debug purposes.
 * @function DLStylerPrintItem
 * @since 0.3.0
 */
void DLStylerPrintItem(DLStylerStyleItemRef item);

#if __cplusplus
}
#endif
#endif
