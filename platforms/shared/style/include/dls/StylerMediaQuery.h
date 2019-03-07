#ifndef __LessMediaQuery_h__
#define __LessMediaQuery_h__

#include <list>

#include "Selector.h"
#include "Stylesheet.h"
#include "StylesheetStatement.h"

#include "Writer.h"
#include "StylerFunction.h"
#include "StylerRuleset.h"
#include "StylerStylesheet.h"
#include "StylerMixin.h"
#include "ProcessingContext.h"

class StylerMediaQuery : public StylerStylesheet, public StylesheetStatement {
private:
	TokenList selector;
	const StylerStylesheet *parent;

public:
	StylerMediaQuery(const TokenList &selector, const StylerStylesheet &parent);
	virtual ~StylerMediaQuery();
	TokenList &getSelector();
	const TokenList &getSelector() const;
	void setSelector(const TokenList &s);
	const StylerStylesheet &getLessStylesheet() const;
	virtual void getFunctions(std::list<const StylerFunction *> &functionList, const StylerMixin &mixin, const ProcessingContext &context) const;
	virtual const TokenList *getVariable(const std::string &key, const ProcessingContext &context) const;
	virtual void process(Stylesheet &s, void *context) const;
	virtual void write(Writer &writer) const;
};

#endif  // __LessMediaQuery_h__
