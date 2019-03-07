#ifndef __LessStylesheet_h__
#define __LessStylesheet_h__

#include <list>
#include <map>
#include <string>

#include "Stylesheet.h"

#include "Token.h"
#include "TokenList.h"

#include "StylerAtRule.h"
#include "StylerRuleset.h"
#include "StylerMixin.h"
#include "ProcessingContext.h"

class StylerMediaQuery;

class StylerStylesheet : public Stylesheet {
private:
	std::multimap<TokenList, StylerRuleset *> lessrulesets;
	VariableMap variables;

public:
	StylerStylesheet();
	virtual ~StylerStylesheet();
	StylerRuleset *createStylerRuleset(StylerSelector &selector);
	StylerMixin *createMixin(const TokenList &selector);
	StylerAtRule *createLessAtRule(const Token &keyword);
	StylerMediaQuery *createLessMediaQuery(const TokenList &selector);
	void deleteLessRuleset(StylerRuleset &ruleset);
	void deleteMixin(StylerMixin &mixin);
	void putVariable(const std::string &key, const TokenList &value);
	virtual void getFunctions(std::list<const StylerFunction *> &functionList, const StylerMixin &mixin, const ProcessingContext &context) const;
	const TokenList *getVariable(const std::string &key) const;
	virtual const TokenList *getVariable(const std::string &key, const ProcessingContext &context) const;
	virtual void process(Stylesheet &s, void *context) const;
};

#endif  // __LessStylesheet_h__
