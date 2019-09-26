#include "Token.h"

namespace View::Style {

Token::Token(TokenType tokenType) : tokenType(tokenType)
{

}

Token::Token(TokenType tokenType, string tokenName) : tokenType(tokenType), tokenName(tokenName)
{

}

Token::Token(TokenType tokenType, string tokenName, string tokenUnit) : tokenType(tokenType), tokenName(tokenName), tokenUnit(tokenUnit)
{

}

Token::Token(TokenType tokenType, char tokenName) : tokenType(tokenType)
{
	this->tokenName.append(1, tokenName);
}

Token::Token(TokenType tokenType, BlockType blockType) : tokenType(tokenType), blockType(blockType)
{

}

Token::Token(TokenType tokenType, BlockType blockType, string tokenName) : tokenType(tokenType), blockType(blockType), tokenName(tokenName)
{

}

}
