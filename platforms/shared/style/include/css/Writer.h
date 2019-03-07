#ifndef __css_CssWriter_h__
#define __css_CssWriter_h__

#include <cstring>
#include <iostream>

#include "TokenList.h"
#include "SourceMapWriter.h"

class Selector;


class Writer {
protected:
	std::ostream *out;
	unsigned int column;
	SourceMapWriter *sourcemap;
	void writeStr(const char *str, size_t len);
	void writeToken(const Token &token);
	void writeTokenList(const TokenList &tokens);
	virtual void writeSelector(const Selector &selector);
	virtual void writeValue(const TokenList &value);
	void newline();

public:
	Writer();
	Writer(std::ostream &out);
	Writer(std::ostream &out, SourceMapWriter &sourcemap);
	const char *rootpath;
	unsigned int getColumn();
	virtual ~Writer();
	virtual void writeAtRule(const Token &keyword, const TokenList &rule);
	virtual void writeRulesetStart(const Selector &selector);
	virtual void writeRulesetEnd();
	virtual void writeDeclaration(const Token &property, const TokenList &value);
	virtual void writeDeclarationDeliminator();
	virtual void writeComment(const Token &comment);
	virtual void writeMediaQueryStart(const TokenList &selector);
	virtual void writeMediaQueryEnd();
	void writeSourceMapUrl(const char *sourcemap_url);
};

#endif  // __css_CssWriter_h__
