#ifndef __ProcessingContext_h__
#define __ProcessingContext_h__

#include <list>
#include <map>
#include <string>

#include "TokenList.h"
#include "VariableMap.h"
#include "StylerClosure.h"
#include "StylerExtension.h"
#include "StylerFunction.h"
#include "StylerMixinCall.h"
#include "ValueProcessor.h"
#include "ValueScope.h"

class StylerRuleset;

class StylerFunction;

class StylerClosure;

class StylerMixin;

class StylerStylesheet;

class ProcessingContext : public ValueScope {
private:
	StylerMixinCall *stack;
	ValueProcessor processor;
	std::list<std::list<StylerExtension> *> extensions;
	const StylerStylesheet *contextStylesheet;
	// return values
	std::map<const StylerFunction *, std::list<StylerClosure *> > closures;
	std::map<const StylerFunction *, VariableMap> variables;
	std::list<StylerClosure *> base_closures;
	VariableMap base_variables;
public:
	ProcessingContext();
	virtual ~ProcessingContext();
	void setLessStylesheet(const StylerStylesheet &stylesheet);
	const StylerStylesheet *getLessStylesheet() const;
	virtual const TokenList *getVariable(const std::string &key) const;
	const TokenList *getFunctionVariable(const std::string &key, const StylerFunction *function) const;
	const TokenList *getBaseVariable(const std::string &key) const;
	void pushMixinCall(const StylerFunction &function, bool savepoint = false, bool important = false);
	void popMixinCall();
	bool isInStack(const StylerFunction &function) const;
	VariableMap *getStackArguments() const;
	VariableMap *getStackArguments(const StylerFunction *function) const;
	bool isStackEmpty() const;
	bool isSavePoint() const;
	const StylerFunction *getSavePoint() const;
	bool isImportant() const;
	void getFunctions(std::list<const StylerFunction *> &functionList, const StylerMixin &mixin) const;
	const std::list<StylerClosure *> *getClosures(const StylerFunction *function) const;
	const std::list<StylerClosure *> *getBaseClosures() const;
	void addClosure(const StylerRuleset &ruleset);
	void addVariables(const VariableMap &variables);
	void pushExtensionScope(std::list<StylerExtension> &scope);
	void popExtensionScope();
	void addExtension(StylerExtension &extension);
	std::list<StylerExtension> *getExtensions();
	ValueProcessor *getValueProcessor();
	void interpolate(Selector &selector) const;
	void interpolate(TokenList &tokens) const;
	void interpolate(std::string &str) const;
	void processValue(TokenList &value) const;
	bool validateCondition(const TokenList &value, bool defaultVal = false) const;
};

#endif  // __ProcessingContext_h__
