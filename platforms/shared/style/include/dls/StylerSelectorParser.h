#ifndef __less_LessSelectorParser_h__
#define __less_LessSelectorParser_h__

#include "Token.h"
#include "TokenList.h"
#include "StylerSelector.h"
#include "SelectorParser.h"


class StylerSelectorParser : public SelectorParser {
public:
	bool parse(TokenList &tokens,
		StylerSelector &selector);

protected:
	SelectorParser selectorParser;
	bool parseExtension(TokenList &tokens, TokenList::iterator &offset, StylerSelector &s);
	bool isArguments(TokenList &selector, TokenList::iterator it, std::string &delimiter);
	bool parseArguments(TokenList &selector, TokenList::iterator &offset, StylerSelector &s);
	bool parseParameter(TokenList &selector, TokenList::iterator &it, Token &keyword, TokenList &value, const std::string &delimiter);
	bool parseDefaultValue(TokenList &arguments, TokenList::iterator &it, const std::string &delimiter, TokenList &value);
	bool parseConditions(TokenList &selector, TokenList::iterator &offset, StylerSelector &s);
};

#endif  // __less_LessSelectorParser_h__
