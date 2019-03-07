#ifndef __Function_h__
#define __Function_h__

#include <list>

#include "TokenList.h"
#include "Ruleset.h"

class StylerSelector;

class StylerMixin;

class StylerMixinArguments;

class ProcessingContext;

class StylerSelector;

class StylerMixinCall;

class StylerFunction {
public:
	virtual bool call(StylerMixinArguments &args,
		Ruleset &target,
		ProcessingContext &context,
		bool defaultVal = false) const = 0;

	virtual bool call(StylerMixinArguments &args,
		Stylesheet &s,
		ProcessingContext &context,
		bool defaultVal = false) const = 0;

	virtual void getFunctions(
		std::list<const StylerFunction *> &functionList,
		const StylerMixin &mixin,
		TokenList::const_iterator selector_offset,
		const ProcessingContext &context) const = 0;

	virtual void getLocalFunctions(std::list<const StylerFunction *> &functionList,
		const StylerMixin &mixin,
		const ProcessingContext &context) const = 0;

	virtual const TokenList *getVariable(const std::string &key,
		const ProcessingContext &context) const = 0;

	virtual const StylerSelector &getLessSelector() const = 0;
};

#endif  // __Function_h__
