#ifndef __css_MixinException_h__
#define __css_MixinException_h__

#include <exception>
#include <string>
#include "StylerMixin.h"
#include "StylerException.h"

class StylerMixinException : public StylerException {
	std::string err;

public:
	const StylerMixin *mixin;
	StylerMixinException(const StylerMixin &mixin);
	~StylerMixinException() throw() {};
	virtual const char *what() const throw();
};

#endif  // __css_MixinException_h__
