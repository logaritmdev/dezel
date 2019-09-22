#ifndef Tokenizer_h
#define Tokenizer_h

#include "Token.h"
#include "TokenizerStream.h"
#include <string>

namespace View::Style {

using std::string;

class Tokenizer {

private:

	TokenizerStream stream;

	Token processSpace(char c);
	Token processAlpha(char c);
	Token processDigit(char c);

	Token processString(char c);
	Token processParenthesisOpen(char c);
	Token processParenthesisClose(char c);
	Token processBracketOpen(char c);
	Token processBracketClose(char c);
	Token processBraceOpen(char c);
	Token processBraceClose(char c);
	Token processAt(char c);
	Token processHash(char c);
	Token processPlus(char c);
	Token processMinus(char c);
	Token processAsterisk(char c);
	Token processComma(char c);
	Token processPeriod(char c);
	Token processColon(char c);
	Token processSemicolon(char c);
	Token processDollar(char c);

	Token processIdentifier();
	Token processNumber();

	string readName();
	string readNumber();

	bool isFollowedByNumber();

	bool isNameCodePoint(char c);
	bool isNameStartCodePoint(char c);
	bool isSpace(char c);
	bool isASCII(char c);
	bool isASCIIAlpha(char c);
	bool isASCIIDigit(char c);

public:

	Tokenizer(TokenizerStream &stream);

	Token next();
};

}

#endif
