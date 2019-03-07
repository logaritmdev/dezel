#ifndef DLTranslationManager_h
#define DLTranslationManager_h

#if __cplusplus
extern "C" {
#endif

/**
 * Loads the mo file using bytes.
 * @function DLTanslationManagerLoad
 * @since 0.5.0
 */
void DLTranslationManagerLoad(unsigned char* bytes);

/**
 * Retrieves translated text.
 * @function DLTranslationManagerTranslate
 * @since 0.5.0
 */
const char* DLTranslationManagerTranslate(const char* string, const char* context);

#if __cplusplus
}
#endif
#endif
