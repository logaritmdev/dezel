#ifndef __value_ValueException_h__
#define __value_ValueException_h__

#include <string>
#include "TokenList.h"
#include "StylerException.h"

/**
 *
 */
class ValueException : public StylerException {
public:
	std::string err;

	ValueException(std::string message, const TokenList &source) :
		StylerException(source.front()) {
		err = message;
	}

	virtual ~ValueException() throw() {};

	virtual const char *what() const throw() {
		return err.c_str();
	}
};

#endif  // __value_ValueException_h__
