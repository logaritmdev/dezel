#include "Token.h"

namespace View::Style {

Token::Token(TokenType tokenType) :
	tokenType(tokenType),
	tokenName("")
{

}

Token::Token(TokenType tokenType, string tokenName) :
	tokenType(tokenType),
	tokenName(tokenName)
{

}

Token::Token(TokenType tokenType, BlockType blockType) :
	tokenType(tokenType),
	blockType(blockType),
	tokenName("")
{

}

Token::Token(TokenType tokenType, BlockType blockType, string tokenName) :
	tokenType(tokenType),
	blockType(blockType),
	tokenName(tokenName)
{

}

}
