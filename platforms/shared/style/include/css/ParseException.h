#ifndef __css_ParseException_h__
#define __css_ParseException_h__

#include <exception>
#include <string>

#include "Token.h"
#include "TokenList.h"
#include "StylerException.h"

class ParseException : public StylerException {
public:
	std::string err;
	ParseException(const std::string found,	const std::string &expected, unsigned int line,	unsigned int column, const std::string source);
	ParseException(const std::string found, const char *expected, unsigned int line, unsigned int column, const std::string source);
	ParseException(const char *found, const char *expected, unsigned int line, unsigned int column, const std::string source);
	ParseException(const Token &found, const char *expected);
	ParseException(const TokenList &found, const char *expected);
	~ParseException() throw() {};
	virtual const char *what() const throw();

protected:
	std::string translate(std::string found);
};

#endif  // __css_ParseException_h__
