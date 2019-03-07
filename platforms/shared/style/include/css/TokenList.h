#ifndef __TokenList_h__
#define __TokenList_h__

#include <list>
#include "Token.h"

class TokenList : public std::list<Token> {
public:
	virtual ~TokenList();
	void ltrim();
	void rtrim();
	void trim();
	std::string toString() const;
	bool contains(const Token &t) const;
	bool contains(Token::Type t, const std::string &str) const;
	bool containsType(Token::Type t) const;
	const_iterator find(const Token &find, const_iterator offset) const;
	const_iterator find(const TokenList &find, const_iterator &offset) const;
};

#endif  // __TokenList_h__
