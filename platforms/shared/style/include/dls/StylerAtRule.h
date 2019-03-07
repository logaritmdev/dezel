#ifndef __LessAtRule_h__
#define __LessAtRule_h__

#include "AtRule.h"
#include "Stylesheet.h"
#include "RulesetStatement.h"

#include "Token.h"

class StylerStylesheet;

class StylerAtRule : public AtRule, public RulesetStatement {

public:
	StylerAtRule(const Token &keyword);
	virtual ~StylerAtRule();
	virtual void process(Stylesheet &s, void *context) const;
	virtual void process(Ruleset &r, void *context) const;
	virtual void write(Writer &writer) const;
};

#endif  // __LessAtRule_h__
