#ifndef __Closure_h__
#define __Closure_h__

#include "StylerFunction.h"

#include "StylerMixin.h"
#include "Ruleset.h"

class StylerRuleset;

class ProcessingContext;

class StylerMixinCall;

class StylerClosure : public StylerFunction {
public:
	const StylerRuleset *ruleset;
	const StylerMixinCall *stack;
	StylerClosure(const StylerRuleset &ruleset, const StylerMixinCall &stack);
	virtual bool call(StylerMixinArguments &args, Ruleset &target, ProcessingContext &context, bool defaultVal = false) const;
	virtual bool call(StylerMixinArguments &args, Stylesheet &s, ProcessingContext &context, bool defaultVal = false) const;
	virtual void getFunctions(std::list<const StylerFunction *> &functionList, const StylerMixin &mixin, TokenList::const_iterator selector_offset, const ProcessingContext &context) const;
	virtual void getLocalFunctions(std::list<const StylerFunction *> &functionList, const StylerMixin &mixin, const ProcessingContext &context) const;
	virtual const StylerSelector &getLessSelector() const;
	virtual const TokenList *getVariable(const std::string &key, const ProcessingContext &context) const;
	bool isInStack(const StylerRuleset &ruleset);
};

#endif  // __Closure_h__
