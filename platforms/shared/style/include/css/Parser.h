#ifndef __css_CssParser_h__
#define __css_CssParser_h__

#include <string>

#include "TokenList.h"
#include "Stylesheet.h"
#include "Tokenizer.h"
#include "SelectorParser.h"

class Declaration;

using namespace std;

class Parser {
protected:
	Tokenizer *tokenizer;
	SelectorParser selectorParser;
	virtual void skipWhitespace();
	bool parseWhitespace(TokenList &tokens);
	virtual bool parseStatement(Stylesheet &stylesheet);
	bool parseEmptyStatement();
	MediaQuery *parseMediaQuery(Stylesheet &stylesheet);
	AtRule *parseAtRule(Stylesheet &stylesheet);
	bool parseBlock(TokenList &tokens);
	Ruleset *parseRuleset(Stylesheet &stylesheet);
	virtual bool parseSelector(TokenList &selector);
	Declaration *parseDeclaration(Ruleset &ruleset);
	bool parseProperty(TokenList &property);
	virtual bool parseValue(TokenList &value);
	bool parseAny(TokenList &tokens);
	bool parseUnused(TokenList &tokens);

public:
	Parser(Tokenizer &tokenizer);
	virtual ~Parser() {};
	virtual void parseStylesheet(Stylesheet &stylesheet);
};

#endif  // __css_CssParser_h__
