#include "Tokenizer.h"

#include <string>
#include <functional>

namespace Dezel {
namespace Style {

using std::string;
using std::invoke;

static bool isASCII(char c) {
	return !(c & ~0x7F);
}

static bool isAlpha(char c) {
	return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
}

static bool isDigit(char c) {
	return c >= '0' && c <= '9';
}

static bool isNumberSeparator(char c) {
	return c == '.';
}

static bool isNumberQualifier(char c) {
	return c == '+' || c == '-';
}

static bool isNameStart(char c) {
	return isAlpha(c) || c == '_';
}

static bool isName(char c) {
	return isNameStart(c) || isDigit(c) || c == '-';
}

static bool isUnit(char c) {
	return isAlpha(c) || c == '%';
}

static bool isSemicolon(char c) {
	return c == ';';
}

static bool isSpace(char c) {
	return c == ' ' || c == '\t' || c == '\n';
}

static bool isLinebreak(char c) {
	return (c == '\r' || c == '\n' || c == '\f');
}

/*
 * Map the ASCII table to character consumers.
 */

const Tokenizer::Consumer Tokenizer::consumers[128] = {
	&Tokenizer::consumeEnd,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	&Tokenizer::consumeSpace,
	&Tokenizer::consumeLinebreak,
	0,
	&Tokenizer::consumeLinebreak,
	&Tokenizer::consumeLinebreak,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	&Tokenizer::consumeSpace,
	0,
	&Tokenizer::consumeDoubleQuote,
	&Tokenizer::consumeHash,
	&Tokenizer::consumeDollar,
	0,
	&Tokenizer::consumeAmpersand,
	&Tokenizer::consumeSingleQuote,
	&Tokenizer::consumeParenthesisOpen,
	&Tokenizer::consumeParenthesisClose,
	&Tokenizer::consumeAsterisk,
	&Tokenizer::consumePlus,
	&Tokenizer::consumeComma,
	&Tokenizer::consumeMinus,
	&Tokenizer::consumePeriod,
	&Tokenizer::consumeSlash,
	&Tokenizer::consumeDigit,
	&Tokenizer::consumeDigit,
	&Tokenizer::consumeDigit,
	&Tokenizer::consumeDigit,
	&Tokenizer::consumeDigit,
	&Tokenizer::consumeDigit,
	&Tokenizer::consumeDigit,
	&Tokenizer::consumeDigit,
	&Tokenizer::consumeDigit,
	&Tokenizer::consumeDigit,
	&Tokenizer::consumeColon,
	&Tokenizer::consumeSemicolon,
	0,
	0,
	0,
	0,
	&Tokenizer::consumeAt,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeSquareBracketOpen,
	0,
	&Tokenizer::consumeSquareBracketClose,
	0,
	&Tokenizer::consumeAlpha,
	0,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeAlpha,
	&Tokenizer::consumeCurlyBracketOpen,
	0,
	&Tokenizer::consumeCurlyBracketClose,
	0,
	0
};

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

Tokenizer::Tokenizer(TokenizerStream &stream): stream(stream) {

	if (this->stream.getLength() == 0) {
		return;
	}

	while (true) {

		auto token = this->next();

		if (token.getType() == kTokenTypeNone ||
			token.getType() == kTokenTypeComment) {
			continue;
		}

		token.offset = this->stream.getOffset();

		this->tokens.push_back(token);

		if (token.getType() == kTokenTypeEnd) {
			break;
		}
	}
}

Token
Tokenizer::next()
{
	char c = this->stream.read();

	if (isASCII(c)) {

		auto consumer = consumers[c];

		if (consumer) {
			return invoke(consumer, this, c);
		}
	}

	return Token(kTokenTypeOther, c);
}

Token
Tokenizer::consumeEnd(char c)
{
	return Token(kTokenTypeEnd);
}

Token
Tokenizer::consumeSpace(char c)
{
	this->stream.skip<isSpace>();
	return Token(kTokenTypeSpace, c);
}

Token
Tokenizer::consumeLinebreak(char c)
{
	this->stream.skip<isLinebreak>();
	return Token(kTokenTypeLinebreak, c);
}

Token
Tokenizer::consumeAlpha(char c)
{
	this->stream.back();
	return this->consumeIdent();
}

Token
Tokenizer::consumeDigit(char c)
{
	this->stream.back();
	return this->consumeNumber();
}

Token
Tokenizer::consumeDoubleQuote(char c)
{
	return this->consumeString(c);
}

Token
Tokenizer::consumeSingleQuote(char c)
{
	return this->consumeString(c);
}

Token
Tokenizer::consumeCurlyBracketOpen(char c)
{
	return Token(kTokenTypeCurlyBracketOpen, c);
}

Token
Tokenizer::consumeCurlyBracketClose(char c)
{
	return Token(kTokenTypeCurlyBracketClose, c);
}

Token
Tokenizer::consumeSquareBracketOpen(char c)
{
	return Token(kTokenTypeSquareBracketOpen, c);
}

Token
Tokenizer::consumeSquareBracketClose(char c)
{
	return Token(kTokenTypeSquareBracketClose, c);
}

Token
Tokenizer::consumeParenthesisOpen(char c)
{
	return Token(kTokenTypeParenthesisOpen, c);
}

Token
Tokenizer::consumeParenthesisClose(char c)
{
	return Token(kTokenTypeParenthesisClose, c);
}

Token
Tokenizer::consumePlus(char c)
{
	if (this->stream.peek<isDigit>() ||
		this->stream.peek<isNumberSeparator>()) {
		this->stream.back();
		return this->consumeNumber();
	}

	return Token(kTokenTypeOther, c);
}

Token
Tokenizer::consumeMinus(char c)
{
	if (this->stream.peek<isDigit>() ||
		this->stream.peek<isNumberSeparator>()) {
		this->stream.back();
		return this->consumeNumber();
	}

	return Token(kTokenTypeOther, c);
}

Token
Tokenizer::consumeAsterisk(char c)
{
	return Token(kTokenTypeOther, c);
}

Token
Tokenizer::consumeSlash(char c)
{
	if (this->stream.peek() == '/') {
		this->stream.next<isLinebreak>();
		this->stream.next();
		return Token(kTokenTypeComment);
	}

	if (this->stream.peek() == '*') {
		this->stream.next();

		while (true) {

			size_t offset = 0;

			if (this->stream.find('*', offset) == false) {
				break;
			}

			if (this->stream.peek(offset + 1) == '/') {
				this->stream.next(offset + 1);
				this->stream.next();
				break;
			}
		}

		return Token(kTokenTypeComment);
	}

	return Token(kTokenTypeOther, c);
}

Token
Tokenizer::consumeAt(char c)
{
	return Token(kTokenTypeAt, c);
}

Token
Tokenizer::consumeHash(char c)
{
	return this->stream.peek<isName>() ? Token(kTokenTypeHash, this->stream.read<isName>()) : Token(kTokenTypeOther, c);
}

Token
Tokenizer::consumeDollar(char c)
{
	return this->stream.peek<isNameStart>() ? Token(kTokenTypeVariable, this->stream.read<isName>()) : Token(kTokenTypeOther, c);
}

Token
Tokenizer::consumePeriod(char c)
{
	if (this->stream.peek<isDigit>()) {
		this->stream.back();
		return this->consumeNumber();
	}

	if (this->stream.peek<isName>()) {
		return this->consumeStyleIdent();
	}

	return Token(kTokenTypeOther, c);
}

Token
Tokenizer::consumeColon(char c)
{
	if (this->stream.peek<isName>()) {
		return this->consumeStateIdent();
	}

	return Token(kTokenTypeColon, c);
}

Token
Tokenizer::consumeComma(char c)
{
	return Token(kTokenTypeComma, c);
}

Token
Tokenizer::consumeSemicolon(char c)
{
	this->stream.skip<isSemicolon>();
	return Token(kTokenTypeDelimiter, c);
}

Token
Tokenizer::consumeAmpersand(char c)
{
	return Token(kTokenTypeOther, c);
}

Token
Tokenizer::consumeIdent()
{
	string name;

	this->stream.read<isName>(name);

	if (this->stream.peek() == '(') {
		return Token(kTokenTypeFunction, name);
	}

	return Token(kTokenTypeIdent, name);
}

Token
Tokenizer::consumeStyleIdent()
{
	return Token(kTokenTypeStyleIdent, this->stream.read<isName>());
}

Token
Tokenizer::consumeStateIdent()
{
	return Token(kTokenTypeStateIdent, this->stream.read<isName>());
}

Token
Tokenizer::consumeNumber()
{
	string name;
	string unit;

	if (this->stream.peek<isNumberQualifier>()) {
		this->stream.read(name);
	}

	if (this->stream.peek<isDigit>()) {
		this->stream.read<isDigit>(name);
	}

	if (this->stream.peek<isNumberSeparator>()) {
		this->stream.read(name);
		this->stream.read<isDigit>(name);
	}

	if (this->stream.peek<isUnit>()) {
		this->stream.read<isUnit>(unit);
	}

	return Token(kTokenTypeNumber, name, unit);
}

Token
Tokenizer::consumeString(char end)
{
	string value;

	while (true) {

		size_t offset = 0;

		if (this->stream.find(end, offset) == false) {
			break;
		}

		bool escaped = this->stream.peek(offset - 1) == '\\';

		if (escaped) {

			this->stream.substring(offset - 1, value);
			this->stream.next(offset);
			this->stream.next();

			value.append(1, end);

		} else {

			this->stream.substring(offset, value);
			this->stream.next(offset);
			this->stream.next();

			break;
		}
	}

	return Token(kTokenTypeString, value);
}

void
Tokenizer::locate(const Token &token, size_t &col, size_t &row)
{
	this->stream.transform(token.getOffset(), col, row);
}

}
}
