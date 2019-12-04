#ifndef Tokenizer_h
#define Tokenizer_h

#include "Token.h"
#include "TokenList.h"
#include "TokenizerStream.h"

#include <string>
#include <vector>

using std::string;
using std::vector;

namespace Dezel {
namespace Style {

class Tokenizer {

private:

	using Consumer = Token (Tokenizer::*)(char);

	static const Consumer consumers[];

	TokenizerStream stream;

	vector<Token> tokens;

	Token consumeEnd(char c);
	Token consumeSpace(char c);
	Token consumeLinebreak(char c);
	Token consumeAlpha(char c);
	Token consumeDigit(char c);
	Token consumeDoubleQuote(char c);
	Token consumeSingleQuote(char c);
	Token consumeCurlyBracketOpen(char c);
	Token consumeCurlyBracketClose(char c);
	Token consumeSquareBracketOpen(char c);
	Token consumeSquareBracketClose(char c);
	Token consumeParenthesisOpen(char c);
	Token consumeParenthesisClose(char c);
	Token consumePlus(char c);
	Token consumeMinus(char c);
	Token consumeAsterisk(char c);
	Token consumeSlash(char c);
	Token consumeAt(char c);
	Token consumeHash(char c);
	Token consumeDollar(char c);
	Token consumeComma(char c);
	Token consumeColon(char c);
	Token consumeSemicolon(char c);
	Token consumePeriod(char c);
	Token consumeAmpersand(char c);

	Token consumeIdent();
	Token consumeStyleIdent();
	Token consumeStateIdent();
	Token consumeNumber();
	Token consumeString(char end);

	Token next();

public:

	Tokenizer(TokenizerStream &stream);

	TokenList getTokens() {
		return TokenList(
			&(*this->tokens.begin()),
			&(*this->tokens.end())
		);
	}

	void locate(const Token& token, size_t& col, size_t& row);
};

}
}

#endif
