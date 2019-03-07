#ifndef __MediaQuery_h__
#define __MediaQuery_h__

#include "TokenList.h"
#include "Stylesheet.h"
#include "StylesheetStatement.h"

class MediaQuery : public Stylesheet, public StylesheetStatement {
private:
	TokenList selector;
	static const Token BUILTIN_AND;

public:
	MediaQuery(const TokenList &selector);
	TokenList &getSelector();
	const TokenList &getSelector() const;
	virtual MediaQuery *createMediaQuery(const TokenList &selector);
	virtual void process(Stylesheet &s, void *context) const;
	virtual void write(Writer &writer) const;
};

#endif  // __MediaQuery_h__
