#ifndef Token_h
#define Token_h

#include <string>

namespace View::Style {

using std::string;

/**
 * @enum TokenType
 * @since 0.7.0
 */
enum TokenType {
	kTokenTypeSpace,
	kTokenTypeIdentifier,
	kTokenTypeVariable,
	kTokenTypeUnit,
	kTokenTypeNumber,
	kTokenTypeString,
	kTokenTypeFunction,
	kTokenTypeComma,
	kTokenTypeColon,
	kTokenTypeSemicolon,
	kTokenTypeBraceOpen,
	kTokenTypeBraceClose,
	kTokenTypeBracketOpen,
	kTokenTypeBracketClose,
	kTokenTypeParenthesisOpen,
	kTokenTypeParenthesisClose,
	kTokenTypeComment,
	kTokenTypeEOF,
	kTokenTypeOther
};

/**
 * @enum BlockType
 * @since 0.7.0
 */
enum BlockType {
	kBlockTypeNone,
	kBlockTypeStart,
	kBlockTypeEnd
};

/**
 * TODO
 * @class Token
 * @since 0.7.0
 */
class Token {

private:

	string tokenName;
	TokenType tokenType;
	BlockType blockType;

public:

	Token(TokenType tokenType);
	Token(TokenType tokenType, string name);

	Token(TokenType tokenType, BlockType blockType);
	Token(TokenType tokenType, BlockType blockType, string name);

	string getTokenName() {
		return this->tokenName;
	}

	TokenType getTokenType() {
		return this->tokenType;
	}

	BlockType getBlockType() {
		return this->blockType;
	}

};

}

#endif
