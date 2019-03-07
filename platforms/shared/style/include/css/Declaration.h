#ifndef __Declaration_h__
#define __Declaration_h__

#include "Writer.h"
#include "Ruleset.h"
#include "RulesetStatement.h"

#include "Token.h"
#include "TokenList.h"

class Declaration : public RulesetStatement {
protected:
	Token property;
	TokenList value;

public:
	Declaration();
	Declaration(const Token &property);
	virtual ~Declaration();
	void setProperty(const Token &property);
	void setValue(const TokenList &value);
	Token &getProperty();
	const Token &getProperty() const;
	TokenList &getValue();
	const TokenList &getValue() const;
	virtual void process(Ruleset &r, void *context) const;
	virtual void write(Writer &writer) const;
};

#endif  // __Declaration_h__
