#ifndef __Token_h__
#define __Token_h__

#include <string>

class Token : public std::string {
protected:
public:
	unsigned int line, column;
	const char *source;

	enum Type {
		IDENTIFIER,
		AT,
		VAR,
		STRING,
		HASH,
		NUMBER,
		PERCENTAGE,
		DIMENSION,
		URL,
		UNICODE_RANGE,
		COLON,
		DELIMITER,
		BRACKET_OPEN,
		BRACKET_CLOSED,
		PAREN_OPEN,
		PAREN_CLOSED,
		BRACE_OPEN,
		BRACE_CLOSED,
		WHITESPACE,
		COMMENT,
		INCLUDES,
		DASHMATCH,
		OTHER,
		EOS
	} type;
	//  std::string str;

	static char BUILTIN_SOURCE[8];
	static const Token
		BUILTIN_SPACE,
		BUILTIN_COMMA,
		BUILTIN_PAREN_OPEN,
		BUILTIN_PAREN_CLOSED,
		BUILTIN_IMPORTANT;

	Token();
	Token(unsigned int line, unsigned int column, const char *source);
	Token(const std::string &s, Type t, unsigned int line, unsigned int column, 	const char *source);
	void setLocation(const Token &ref);
	void clear();
	bool stringHasQuotes() const;
	void removeQuotes();
	void removeQuotes(std::string &str) const;
	std::string getUrlString() const;

	inline std::string &append(char c) {
		return std::string::append(1, c);
	}

	inline std::string &append(const std::string &c) {
		return std::string::append(c);
	}

	inline bool operator==(const Token &t) const {
		return (type == t.type && (std::string) *this == (std::string) t);
	}

	inline bool operator!=(const Token &t) const {
		return !(*this == t);
	}

	inline bool operator<(const Token &t) const {
		return (type == t.type) ? (std::string) *this < (std::string) t : (type < t.type);
	}

	inline bool operator>(const Token &t) const {
		return t < *this;
	}

	inline bool operator<=(const Token &t) const {
		return !(t < *this);
	}

	inline bool operator>=(const Token &t) const {
		return !(*this < t);
	}

	inline Token &operator=(const std::string &str) {
		std::string::assign(str);
		return *this;
	}
};

#endif  // __Token_h__
