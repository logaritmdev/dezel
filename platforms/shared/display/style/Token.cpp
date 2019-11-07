#include "Token.h"

#include <iostream>

namespace Dezel {
namespace Style {

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

Token::Token(TokenType type) : type(type)
{

}

Token::Token(TokenType type, string name) : type(type), name(name)
{

}

Token::Token(TokenType type, string name, string unit) : type(type), name(name), unit(unit)
{

}

Token::Token(TokenType type, char name) : type(type)
{
	this->name.append(1, name);
}

bool
Token::equals(const string& str1, const string& str2) const {

	if (str1.size() != str2.size()) {
		return false;
	}

	for (
		auto c1 = str1.begin(),
		     c2 = str2.begin();
		     c1 != str1.end();
		     ++c1, ++c2) {
		if (tolower(*c1) != tolower(*c2)) {
			return false;
		}
	}

	return true;
}

bool
Token::hasName(string name) const
{
	return this->equals(this->name, name);
}

bool
Token::hasUnit(string unit) const
{
	return this->equals(this->unit, unit);
}

}
}
