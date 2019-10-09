#ifndef Token_h
#define Token_h

#include <string>

namespace Dezel {
namespace Style {

using std::string;

enum TokenType {
	kTokenTypeNone,
	kTokenTypeSpace,
	kTokenTypeIdent,
	kTokenTypeClass,
	kTokenTypeAt,
	kTokenTypeHash,
	kTokenTypeUnit,
	kTokenTypeNumber,
	kTokenTypeString,
	kTokenTypeVariable,
	kTokenTypeFunction,
	kTokenTypeAmpersand,
	kTokenTypeComma,
	kTokenTypeColon,
	kTokenTypeDelimiter,
	kTokenTypeSquareBracketOpen,
	kTokenTypeSquareBracketClose,
	kTokenTypeCurlyBracketOpen,
	kTokenTypeCurlyBracketClose,
	kTokenTypeParenthesisOpen,
	kTokenTypeParenthesisClose,
	kTokenTypeComment,
	kTokenTypeLinebreak,
	kTokenTypeOther,
	kTokenTypeEnd,
};

enum BlockType {
	kBlockTypeNone,
	kBlockTypeStart,
	kBlockTypeEnd
};

enum ClassType {
	kClassTypeNone,
	kClassTypeStyle,
	kClassTypeState
};

class Tokenizer;

class Token {

private:

	string name = "";
	string unit = "";

	size_t offset = 0;

	TokenType type = kTokenTypeNone;
	BlockType blockType = kBlockTypeNone;
	ClassType classType = kClassTypeNone;

public:

	friend class Tokenizer;

	Token(TokenType type);
	Token(TokenType type, string name);
	Token(TokenType type, string name, string unit);
	Token(TokenType type, char c);

	Token(TokenType type, BlockType blockType);
	Token(TokenType type, BlockType blockType, string name);

	Token(ClassType classType, string name);

	const string& getName() const {
		return this->name;
	}

	const string& getUnit() const {
		return this->unit;
	}

	TokenType getType() const {
		return this->type;
	}

	BlockType getBlockType() const {
		return this->blockType;
	}

	ClassType getClassType() const {
		return this->classType;
	}

	size_t getOffset() const {
		return this->offset;
	}

	string description() const {

		switch (this->type) {

			case kTokenTypeNone:
				return "kTokenTypeNone";
			case kTokenTypeSpace:
				return "kTokenTypeSpace";
			case kTokenTypeIdent:
				return "kTokenTypeIdent";
			case kTokenTypeClass:
				return "kTokenTypeClass";
			case kTokenTypeAt:
				return "kTokenTypeAt";
			case kTokenTypeUnit:
				return "kTokenTypeHash";
			case kTokenTypeHash:
				return "kTokenTypeHash";
			case kTokenTypeNumber:
				return "kTokenTypeNumber";
			case kTokenTypeString:
				return "kTokenTypeString";
			case kTokenTypeVariable:
				return "kTokenTypeVariable";
			case kTokenTypeFunction:
				return "kTokenTypeFunction";
			case kTokenTypeAmpersand:
				return "kTokenTypeAmpersand";
			case kTokenTypeComma:
				return "kTokenTypeComma";
			case kTokenTypeColon:
				return "kTokenTypeColon";
			case kTokenTypeDelimiter:
				return "kTokenTypeDelimiter";
			case kTokenTypeSquareBracketOpen:
				return "kTokenTypeSquareBracketOpen";
			case kTokenTypeSquareBracketClose:
				return "kTokenTypeSquareBracketClose";
			case kTokenTypeCurlyBracketOpen:
				return "kTokenTypeCurlyBracketOpen";
			case kTokenTypeCurlyBracketClose:
				return "kTokenTypeCurlyBracketClose";
			case kTokenTypeParenthesisOpen:
				return "kTokenTypeParenthesisOpen";
			case kTokenTypeParenthesisClose:
				return "kTokenTypeParenthesisClose";
			case kTokenTypeComment:
				return "kTokenTypeComment";
			case kTokenTypeLinebreak:
				return "kTokenTypeLinebreak";
			case kTokenTypeOther:
				return "kTokenTypeOther";
			case kTokenTypeEnd:
				return "kTokenTypeEnd";
		}
	}
};

}
}

#endif
