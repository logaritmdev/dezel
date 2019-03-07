#ifndef __Ruleset_h__
#define __Ruleset_h__

#include "Comment.h"
#include "Selector.h"
#include "Stylesheet.h"
#include "StylesheetStatement.h"

#include "Token.h"
#include "TokenList.h"

#include "Writer.h"

class RulesetStatement;

class Declaration;

class Ruleset : public StylesheetStatement {
private:
	std::list<RulesetStatement *> statements;
	std::list<Declaration *> declarations;

protected:
	Selector *selector;
	virtual void addStatement(RulesetStatement &statement);
	virtual void deleteStatement(RulesetStatement &statement);

public:
	Ruleset();
	Ruleset(Selector &selector);
	virtual ~Ruleset();
	Declaration *createDeclaration();
	Declaration *createDeclaration(const Token &property);
	Comment *createComment();
	void deleteDeclaration(Declaration &declaration);
	void addDeclarations(std::list<Declaration> &declarations);
	Selector &getSelector();
	const Selector &getSelector() const;
	void setSelector(Selector &selector);
	const std::list<RulesetStatement *> &getStatements() const;
	const std::list<Declaration *> &getDeclarations() const;
	void clearStatements();
	virtual void processStatements(Ruleset &target, void *context) const;
	virtual void process(Stylesheet &s, void *context) const;
	virtual void write(Writer &writer) const;
};

#include "Declaration.h"
#include "RulesetStatement.h"

#endif  // __Ruleset_h__
