#ifndef __MixinCall_h__
#define __MixinCall_h__

#include "TokenList.h"
#include "VariableMap.h"

class StylerFunction;

class StylerMixin;

class ProcessingContext;

class StylerMixinCall {
public:
	StylerMixinCall *parent;
	const StylerFunction *function;
	VariableMap arguments;
	bool savepoint, important;
	StylerMixinCall(StylerMixinCall *parent, const StylerFunction &function, bool savepoint = false,	bool important = false);
	const TokenList *getVariable(const std::string &key, const ProcessingContext &context) const;
	void getFunctions(std::list<const StylerFunction *> &functionList, const StylerMixin &mixin, const ProcessingContext &context) const;
	bool isInStack(const StylerFunction &function) const;
	const VariableMap *getArguments(const StylerFunction &function) const;
};

#endif  // __MixinCall_h__
