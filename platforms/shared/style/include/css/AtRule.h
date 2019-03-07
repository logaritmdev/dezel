#ifndef __AtRule_h__
#define __AtRule_h__

#include "Stylesheet.h"
#include "StylesheetStatement.h"

#include "Writer.h"

#include "Token.h"
#include "TokenList.h"

class AtRule : public StylesheetStatement {
private:
	Token keyword;
	TokenList rule;

public:
	AtRule(const Token &keyword);
	virtual ~AtRule();
	void setKeyword(const Token &keyword);
	void setRule(const TokenList &rule);
	const Token &getKeyword() const;
	TokenList &getRule();
	const TokenList &getRule() const;
	virtual void process(Stylesheet &s, void *context) const;
	virtual void write(Writer &writer) const;
};

#endif  // __AtRule_h__
