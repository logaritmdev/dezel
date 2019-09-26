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
	kTokenTypeHash,
	kTokenTypeClass,
	kTokenTypeNumber,
	kTokenTypeString,
	kTokenTypeFunction,
	kTokenTypeComma,
	kTokenTypeColon,
	kTokenTypeDelimiter,
	kTokenTypeSemicolon,
	kTokenTypeSquareBracketOpen,
	kTokenTypeSquareBracketClose,
	kTokenTypeCurlyBracketOpen,
	kTokenTypeCurlyBracketClose,
	kTokenTypeParenthesisOpen,
	kTokenTypeParenthesisClose,
	kTokenTypeComment,
	kTokenTypeNewline,
	kTokenTypeEnd,
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

	string tokenName = "";
	string tokenUnit = "";
	TokenType tokenType;
	BlockType blockType;

public:

	Token(TokenType tokenType);
	Token(TokenType tokenType, string name);
	Token(TokenType tokenType, string name, string unit);

	Token(TokenType tokenType, char c);

	Token(TokenType tokenType, BlockType blockType);
	Token(TokenType tokenType, BlockType blockType, string name);

	string getTokenName() {
		return this->tokenName;
	}

	string getTokenUnit() {
		return this->tokenUnit;
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
