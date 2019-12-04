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
	kTokenTypeStyleIdent,
	kTokenTypeStateIdent,
	kTokenTypeAt,
	kTokenTypeHash,
	kTokenTypeUnit,
	kTokenTypeNumber,
	kTokenTypeString,
	kTokenTypeVariable,
	kTokenTypeFunction,
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

class Tokenizer;

class Token {

private:

	size_t offset = 0;

	TokenType type = kTokenTypeNone;

	string name = "";
	string unit = "";

	bool equals(const string& str1, const string& str2) const;

public:

	friend class Tokenizer;

	Token(TokenType type);
	Token(TokenType type, string name);
	Token(TokenType type, string name, string unit);
	Token(TokenType type, char c);

	TokenType getType() const {
		return this->type;
	}

	size_t getOffset() const {
		return this->offset;
	}

	const string& getName() const {
		return this->name;
	}

	const string& getUnit() const {
		return this->unit;
	}

	bool hasName(string name) const;
	bool hasUnit(string unit) const;

	string description() const {

		switch (this->type) {

			case kTokenTypeNone:
				return "kTokenTypeNone";
			case kTokenTypeSpace:
				return "kTokenTypeSpace";
			case kTokenTypeIdent:
				return "kTokenTypeIdent";
			case kTokenTypeStyleIdent:
				return "kTokenTypeStyleIdent";
			case kTokenTypeStateIdent:
				return "kTokenTypeStateIdent";
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
