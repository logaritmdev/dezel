#ifndef __css_CssTokenizer_h__
#define __css_CssTokenizer_h__

#include <iostream>
#include <string>
#include "Token.h"
#include "ParseException.h"

using namespace std;

class Tokenizer {
public:
	Tokenizer(istream &in, const char *source);
	virtual ~Tokenizer();
	Token::Type readNextToken();
	Token &getToken();
	Token::Type getTokenType();
	const char *getSource();

protected:
	istream *in;
	Token currentToken;
	char lastRead;
	unsigned int line, column;
	const char *source;
	void readChar();
	bool readIdent();
	bool readName();
	bool readNMStart();
	bool readNonAscii();
	bool readEscape();
	bool readUnicode();
	bool readNMChar();
	bool readNum(bool readDecimals);
	bool readNumSuffix();
	bool readString();
	bool readNewline();
	bool readWhitespace();
	bool readUrl();
	virtual bool readComment();
	bool readUnicodeRange();
	bool lastReadEq(char c);
	bool lastReadInRange(char c1, char c2);
	bool lastReadIsDigit();
	bool lastReadIsHex();
};

#endif  // __css_CssTokenizer_h__
