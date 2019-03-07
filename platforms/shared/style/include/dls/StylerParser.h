#ifndef __less_LessParser_h__
#define __less_LessParser_h__

#include <fstream>
#include <iostream>
#include <list>
#include <string>

#include "Parser.h"
#include "Tokenizer.h"
#include "StylerSelectorParser.h"
#include "StylerMediaQuery.h"
#include "StylerRuleset.h"
#include "StylerStylesheet.h"
#include "StylerMediaQueryRuleset.h"
#include "Stylesheet.h"

#include "Token.h"
#include "TokenList.h"

#include "StylerTokenizer.h"

class StylerParser : public Parser {
public:
	static const unsigned int
		IMPORT_REFERENCE = 1,
		IMPORT_INLINE = 2,
		IMPORT_LESS = 4,
		IMPORT_CSS = 8,
		IMPORT_ONCE = 16,
		IMPORT_MULTIPLE = 32,
		IMPORT_OPTIONAL = 64;

	std::list<const char *> *includePaths;

	StylerParser(Tokenizer &tokenizer, std::list<const char *> &source_files) : Parser(tokenizer), sources(source_files), reference(false) { }
	StylerParser(Tokenizer &tokenizer, std::list<const char *> &source_files, bool isreference) : Parser(tokenizer), sources(source_files), reference(isreference) { }
	virtual ~StylerParser() { }
	virtual void parseStylesheet(StylerStylesheet &stylesheet);
	void parseStylesheet(StylerRuleset &ruleset);

protected:
	std::list<const char *> &sources;
	bool reference;
	StylerSelectorParser stylerSelectorParser;
	virtual void skipWhitespace();
	bool parseStatement(Stylesheet &stylesheet);
	bool parseAtRule(StylerStylesheet &stylesheet);
	bool parseAtRule(StylerRuleset &ruleset);
	bool parseAtRuleValue(TokenList &rule);
	bool parseVariable(TokenList &value);
	bool parseVariable(std::string &keyword, TokenList &value);
	bool parseSelector(TokenList &selector);
	bool parseSelectorVariable(TokenList &selector);
	bool parseRuleset(StylerStylesheet &parent, TokenList &selector);
	bool parseRuleset(StylerRuleset &parent, TokenList &selector);
	void parseMediaQueryRuleset(Token &mediatoken, StylerRuleset &parent);
	bool parsePropertyVariable(TokenList &selector);
	bool parseRulesetStatement(StylerRuleset &parent);
	bool parseComment(StylerRuleset &ruleset);
	bool parseExtension(TokenList &statement, StylerRuleset &ruleset);
	bool parseDeclaration(TokenList &tokens, size_t property_i, StylerRuleset &ruleset);
	bool parseMixin(TokenList &tokens, StylerStylesheet &stylesheet);
	bool parseMixin(TokenList &tokens, StylerRuleset &ruleset);
	void parseMixinArguments(TokenList::const_iterator &i, const TokenList &tokens, StylerMixin &mixin);

	void parseList(std::list<TokenList *> *list, TokenList *tokens);
	bool parseImportStatement(TokenList &statement, StylerStylesheet &stylesheet);
	bool parseImportStatement(TokenList &statement, StylerRuleset &ruleset);
	unsigned int parseImportDirective(Token &t);
	bool importFile(Token uri, StylerStylesheet &stylesheet, unsigned int directive);
	bool importFile(Token uri, StylerRuleset &ruleset, unsigned int directive);
	void parseLessMediaQuery(Token &mediatoken, StylerStylesheet &stylesheet);

private:
	TokenList *processValue(TokenList *value);
	std::list<TokenList *> *processArguments(TokenList *arguments);
	bool findFile(Token &uri, std::string &filename);
	bool parseRuleset(TokenList &selector, StylerStylesheet *stylesheet, StylerRuleset *parentRuleset);
	bool parseMixin(TokenList &tokens, StylerRuleset *parent_r, StylerStylesheet *parent_s);
	bool parseAtRule(StylerStylesheet *stylesheet, StylerRuleset *ruleset);
	bool parseImportStatement(TokenList &statement, StylerStylesheet *stylesheet, StylerRuleset *ruleset);
	bool importFile(Token uri, StylerStylesheet *stylesheet, StylerRuleset *ruleset, unsigned int directive);
};

#endif  // __less_LessParser_h__
