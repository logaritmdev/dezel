#ifndef __LessException_h__
#define __LessException_h__

#include <exception>
#include <string>
#include "Token.h"

using std::string;

/**
 * @class StylerException
 * @since 0.3.0
 */
class StylerException : public std::exception {

public:

	/**
	 * @member source
	 * @since 0.3.0
	 */
	string source;

	/**
	 * @member line
	 * @since 0.3.0
	 */
	unsigned int line;

	/**
	 * @member column
	 * @since 0.3.0
	 */
	unsigned int column;

	/**
	 * @constructor
	 * @since 0.3.0
	 */
	StylerException(unsigned int line, unsigned int column, std::string source);

	/**
	 * @constructor
	 * @since 0.3.0
	 */
	StylerException(const Token &token);

	/**
	 * @destructor
	 * @since 0.3.0
	 */
	~StylerException() throw() {};

	/**
	 * @since 0.3.0
	 */
	void setLocation(unsigned int line, unsigned int column);

	/**
	 * @since 0.3.0
	 */
	unsigned int getLineNumber();

	/**
	 * @since 0.3.0
	 */
	unsigned int getColumn();

	/**
	 * URL or file name where the Less code is located.
	 * @since 0.3.0
	 */
	void setSource(string source);

	/**
	 * @since 0.3.0
	 */
	string getSource();

	/**
	 * @since 0.3.0
	 */
	virtual const char *what() const throw() =0;

};

#endif  // __css_LessException_h__
