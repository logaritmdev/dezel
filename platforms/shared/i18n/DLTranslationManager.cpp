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

void
DLTranslationManagerClear()
{
	I18nUtils::getInstance()->removeAllMO();
}

const char*
DLTranslationManagerTranslate(const char* message, const char* context)
{
	auto instance = I18nUtils::getInstance();

	if (instance->hasMO() == false) {
		return message;
	}

	std::string string;

	if (context) {

		string = instance->xgettext(
			std::string(message),
			std::string(context)
		);

	} else {

		string = instance->gettext(
			std::string(message)
		);

	}

 	return strdup(string.c_str());
}

