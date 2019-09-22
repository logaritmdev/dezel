#include "Tokenizer.h"

namespace View::Style {

using std::string;

Tokenizer::Tokenizer(TokenizerStream &stream): stream(stream) {

}

Token
Tokenizer::next()
{
	char c = this->stream.read();

	switch (c) {

		// NUL
		case 0:
			return Token(kTokenTypeEOF);

		case 9:
		case 10:
		case 12:
		case 13:
		case 32:
			return this->processSpace(c);

		case 'A':
		case 'B':
		case 'C':
		case 'D':
		case 'E':
		case 'F':
		case 'G':
		case 'H':
		case 'I':
		case 'J':
		case 'K':
		case 'L':
		case 'M':
		case 'N':
		case 'O':
		case 'P':
		case 'Q':
		case 'R':
		case 'S':
		case 'T':
		case 'U':
		case 'V':
		case 'W':
		case 'X':
		case 'Y':
		case 'Z':
		case 'a':
		case 'b':
		case 'c':
		case 'd':
		case 'e':
		case 'f':
		case 'g':
		case 'h':
		case 'i':
		case 'j':
		case 'k':
		case 'l':
		case 'm':
		case 'n':
		case 'o':
		case 'p':
		case 'q':
		case 'r':
		case 's':
		case 't':
		case 'u':
		case 'v':
		case 'w':
		case 'x':
		case 'y':
		case 'z':
		case '_':
			return this->processAlpha(c);

		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
			return this->processDigit(c);

		case '"':
		case '\'':
			return this->processString(c);

		case '(': return this->processParenthesisOpen(c);
		case ')': return this->processParenthesisClose(c);
		case '[': return this->processBracketOpen(c);
		case ']': return this->processBracketClose(c);
		case '{': return this->processBraceOpen(c);
		case '}': return this->processBraceClose(c);
		case '*': return this->processAsterisk(c);
		case '+': return this->processPlus(c);
		case '-': return this->processMinus(c);
		case ',': return this->processComma(c);
		case '.': return this->processPeriod(c);
		case ':': return this->processColon(c);
		case ';': return this->processSemicolon(c);
		case '#': return this->processHash(c);
		case '$': return this->processDollar(c);
		case '@': return this->processAt(c);

		case '/':
			// solidus
			break;
		case '\\':
			// Reverse solidus
			break;



		case '^':
			// Not used yet.
			break;

		case '<':
		 	// Not used yet.
			break;

		case '>':
			// Not used yet.
			break;

		case '~':
			// Not used yet.
			break;
	}

	return Token(kTokenTypeOther);
}

Token
Tokenizer::processSpace(char c)
{
	for (size_t i = 0; ; i++) {

		char c = this->stream.peek(i);

		if (c == ' '  ||
			c == '\t' ||
			c == '\n') {
			continue;
		}

		this->stream.next(i); // Probably not good
		break;
	}

	return Token(kTokenTypeSpace);
}

Token
Tokenizer::processAlpha(char c)
{
	this->stream.back();
	return this->processIdentifier();
}

Token
Tokenizer::processDigit(char c)
{
	this->stream.back();
	return this->processNumber();
}

Token
Tokenizer::processString(char c)
{
	return Token(kTokenTypeOther);
}

Token
Tokenizer::processParenthesisOpen(char c)
{
	return Token(kTokenTypeParenthesisOpen, kBlockTypeStart);
}

Token
Tokenizer::processParenthesisClose(char c)
{
	return Token(kTokenTypeParenthesisClose, kBlockTypeEnd);
}

Token
Tokenizer::processBracketOpen(char c)
{
	return Token(kTokenTypeBracketOpen, kBlockTypeStart);
}

Token
Tokenizer::processBracketClose(char c)
{
	return Token(kTokenTypeBracketClose, kBlockTypeEnd);
}

Token
Tokenizer::processBraceOpen(char c)
{
	return Token(kTokenTypeBraceOpen, kBlockTypeStart);
}

Token
Tokenizer::processBraceClose(char c)
{
	return Token(kTokenTypeBraceClose, kBlockTypeEnd);
}

Token
Tokenizer::processAt(char c)
{
	return Token(kTokenTypeOther);
}

Token
Tokenizer::processHash(char c)
{
	return Token(kTokenTypeOther);
}

Token
Tokenizer::processPlus(char c)
{
	return Token(kTokenTypeOther);
}

Token
Tokenizer::processMinus(char c)
{
	return Token(kTokenTypeOther);
}

Token
Tokenizer::processAsterisk(char c)
{
	return Token(kTokenTypeOther);
}

Token
Tokenizer::processComma(char c)
{
	return Token(kTokenTypeOther);
}

Token
Tokenizer::processPeriod(char c)
{
	return Token(kTokenTypeOther);
}

Token
Tokenizer::processColon(char c)
{
	return Token(kTokenTypeOther);
}

Token
Tokenizer::processSemicolon(char c)
{
	return Token(kTokenTypeOther);
}

Token
Tokenizer::processDollar(char c)
{
	return Token(kTokenTypeOther);
}

Token
Tokenizer::processIdentifier()
{
	auto name = this->readName();

	if (this->stream.peek() == '(') {
		this->stream.next();
		return Token(kTokenTypeFunction, kBlockTypeStart, name);
	}

	return Token(kTokenTypeIdentifier, name);
}

Token
Tokenizer::processNumber()
{
	return Token(kTokenTypeNumber, this->readNumber());
}

string
Tokenizer::readName()
{
	for (size_t i = 0; ; i++) {

		char c = this->stream.peek(i);

		if (this->isNameCodePoint(c)) {
			continue;
		}

		this->stream.next(i);

		return this->stream.substring(i);
	}
}

string
Tokenizer::readNumber()
{
	if (this->isFollowedByNumber() == false) {
		return "WAT";
	}

	for (size_t i = 0; ; i++) {

		char c = this->stream.peek(i);

		if (this->isASCIIDigit(c)) {
			continue;
		}

		this->stream.next(i);

		return this->stream.substring(i);
	}
}

bool
Tokenizer::isFollowedByNumber()
{
	auto c1 = this->stream.peek();
	auto c2 = this->stream.peek(1);

	if (this->isASCIIDigit(c1)) {
		return true;
	}

	if (c1 == '+' ||
		c1 == '-') {
		return this->isASCIIDigit(c2) || (c2 == '.' && this->isASCIIDigit(this->stream.peek(2)));
	}

	if (c1 == '.') {
		return this->isASCIIDigit(c2);
	}

	return false;
}

bool
Tokenizer::isNameCodePoint(char c)
{
    return this->isNameStartCodePoint(c) || this->isASCIIDigit(c) || c == '-';
}

bool
Tokenizer::isNameStartCodePoint(char c)
{
    return this->isASCIIAlpha(c) || c == '_' || this->isASCII(c) == false;
}

bool
Tokenizer::isSpace(char c)
{
    return c == ' ' || c == '\t' || c == '\n';
}

bool
Tokenizer::isASCII(char c)
{
	return true; // TODO
}

bool
Tokenizer::isASCIIAlpha(char c)
{
	return true; // TODO
}

bool
Tokenizer::isASCIIDigit(char c)
{
	return true; // TODO
}

}
