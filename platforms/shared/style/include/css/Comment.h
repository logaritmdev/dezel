#ifndef __CssComment_h__
#define __CssComment_h__

#include "Token.h"
#include "Writer.h"
#include "RulesetStatement.h"
#include "Stylesheet.h"
#include "StylesheetStatement.h"

class Comment : public StylesheetStatement, public RulesetStatement {
protected:
	Token comment;

public:
	Comment();
	Comment(const Token &comment);
	void setComment(const Token &comment);
	const Token &getComment() const;
	virtual void process(Ruleset &r, void *context) const;
	virtual void process(Stylesheet &s, void *context) const;
	virtual void write(Writer &writer) const;
};

#endif  // __CssComment_h__
