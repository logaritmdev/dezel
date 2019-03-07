#ifndef __Mixin_h__
#define __Mixin_h__


#include "Ruleset.h"
#include "Stylesheet.h"
#include "StylesheetStatement.h"
#include "RulesetStatement.h"

#include "StylerMixinArguments.h"

class StylerStylesheet;

class StylerRuleset;

class ProcessingContext;

class StylerMixin : public StylesheetStatement, public RulesetStatement {
private:
	const StylerStylesheet *lessStylesheet;
	const StylerRuleset *lessRuleset;
	bool important;

public:
	TokenList name;
	StylerMixinArguments arguments;
	StylerMixin(const TokenList &name, const StylerStylesheet &parent);
	StylerMixin(const TokenList &name, const StylerRuleset &parent);
	virtual ~StylerMixin();
	bool call(ProcessingContext &context, Ruleset *ruleset, Stylesheet *stylesheet) const;
	void setImportant(bool b);
	bool isImportant() const;
	const StylerStylesheet *getLessStylesheet() const;
	const StylerRuleset *getLessRuleset() const;
	virtual void process(Ruleset &r, void *context) const;
	virtual void process(Stylesheet &s, void *context) const;
	virtual void write(Writer &writer) const;
};

#endif  // __Mixin_h__
