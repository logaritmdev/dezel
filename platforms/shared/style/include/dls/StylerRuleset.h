#ifndef __LessRuleset_h__
#define __LessRuleset_h__

#include <list>
#include <map>
#include <string>

#include "Ruleset.h"
#include "Selector.h"
#include "Stylesheet.h"

#include "ParseException.h"
#include "ValueProcessor.h"

#include "Token.h"
#include "TokenList.h"
#include "VariableMap.h"

#include "StylerFunction.h"
#include "StylerSelector.h"
#include "StylerMixin.h"
#include "StylerMixinArguments.h"
#include "ProcessingContext.h"
#include "StylerDeclaration.h"
#include "StylerAtRule.h"

class StylerStylesheet;

class StylerMediaQueryRuleset;

class StylerClosure;

class StylerRuleset : public Ruleset, public StylerFunction {
protected:
	VariableMap variables;
	std::list<StylerRuleset *> nestedRules;
	std::list<StylerClosure *> closures;
	std::list<StylerExtension> extensions;
	std::list<StylesheetStatement *> stylesheetStatements;
	std::list<StylerDeclaration *> lessDeclarations;
	std::list<StylerMixin *> mixins;
	std::list<StylerAtRule *> lessAtRules;
	const StylerRuleset *parent;
	const StylerStylesheet *lessStylesheet;
	StylerSelector *selector;
	ProcessingContext *context;
	void processVariables();
	void insertNestedRules(Stylesheet &s, const Selector *prefix, ProcessingContext &context) const;
	void addClosures(ProcessingContext &context) const;
	bool call(StylerMixinArguments &args, ProcessingContext &context, Ruleset *ruleset, Stylesheet *stylesheet, bool defaultVal = false) const;
	void mergeDeclarations(Ruleset &ruleset, Declaration *merge = NULL) const;

public:
	StylerRuleset(StylerSelector &selector, const StylerRuleset &parent);
	StylerRuleset(StylerSelector &selector, const StylerStylesheet &parent);
	virtual ~StylerRuleset();
	virtual const StylerSelector &getLessSelector() const;
	void addExtension(StylerExtension &extension);
	StylerDeclaration *createLessDeclaration();
	StylerMixin *createMixin(const TokenList &selector);
	StylerAtRule *createLessAtRule(const Token &keyword);
	StylerRuleset *createNestedRule(StylerSelector &selector);
	StylerMediaQueryRuleset *createMediaQuery(TokenList &selector);
	void deleteNestedRule(StylerRuleset &ruleset);
	const list<StylerDeclaration *> &getLessDeclarations() const;
	const list<StylerMixin *> &getMixins() const;
	const list<StylerAtRule *> &getLessAtRules() const;
	const list<StylesheetStatement *> &getStylesheetStatements() const;
	const list<StylerRuleset *> &getNestedRules() const;
	void putVariable(const std::string &key, const TokenList &value);
	VariableMap &getVariables();
	const TokenList *getVariable(const std::string &key) const;
	const TokenList *getInheritedVariable(const std::string &key, const StylerMixinCall &stack) const;
	const list<StylerClosure *> &getClosures() const;
	void setParent(const StylerRuleset *r);
	const StylerRuleset *getParent() const;
	void setLessStylesheet(const StylerStylesheet &stylesheet);
	const StylerStylesheet *getLessStylesheet() const;
	void processExtensions(ProcessingContext &context, const Selector *prefix) const;
	void processInlineExtensions(ProcessingContext &context, const Selector &selector) const;
	virtual bool call(StylerMixinArguments &args, Ruleset &target, ProcessingContext &context, bool defaultVal = false) const;
	virtual bool call(StylerMixinArguments &args, Stylesheet &s, ProcessingContext &context, bool defaultVal = false) const;
	virtual void processStatements(Ruleset &target, void *context) const;
	void processStatements(Stylesheet &target, void *context) const;
	virtual void process(Stylesheet &s, void *context) const;
	virtual void process(Stylesheet &s, const Selector *prefix, ProcessingContext &context) const;
	const TokenList *getVariable(const std::string &key, const ProcessingContext &context) const;
	virtual void getFunctions(list<const StylerFunction *> &functionList, const StylerMixin &mixin, TokenList::const_iterator selector_offset, const ProcessingContext &context) const;

	/**
	 * Look for a ruleset inside this ruleset and scope up to
	 * getParent(), or getLessStylesheet() if getParent() is NULL.
	 */
	void getLocalFunctions(std::list<const StylerFunction *> &functionList, const StylerMixin &mixin, const ProcessingContext &context) const;
	void getLocalFunctions(std::list<const StylerFunction *> &functionList, const StylerMixin &mixin, const StylerRuleset *exclude, const ProcessingContext &context) const;
	bool matchConditions(const ProcessingContext &context, bool defaultVal = false) const;
	bool putArguments(StylerMixinArguments &args, VariableMap &scope) const;
};

#endif  // __LessRuleset_h__
