#include "Token.h"

namespace Dezel {
namespace Style {

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

}
}
