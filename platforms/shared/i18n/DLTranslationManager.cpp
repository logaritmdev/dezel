#include <string>
#include <iostream>
#include "DLTranslationManager.h"
#include "include/I18nUtils.h"

USING_NS_I18N;

void
DLTranslationManagerLoad(unsigned char *bytes)
{
	I18nUtils::getInstance()->addMO(bytes);
}

const char*
DLTranslationManagerTranslate(const char* message, const char* context)
{
	std::string string;

	if (context) {

		string = I18nUtils::getInstance()->xgettext(
			std::string(message),
			std::string(context)
		);

	} else {

		string = I18nUtils::getInstance()->gettext(
			std::string(message)
		);

	}

 	return strdup(string.c_str());
}

