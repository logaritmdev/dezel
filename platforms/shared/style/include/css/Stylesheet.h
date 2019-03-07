#ifndef __Stylesheet_h__
#define __Stylesheet_h__

#include <list>

#include "Writable.h"
#include "Selector.h"

#include "Token.h"
#include "TokenList.h"

#include "Writer.h"

class AtRule;
class Ruleset;
class StylesheetStatement;
class Comment;
class MediaQuery;

class Stylesheet : public Writable {
private:
	std::list<AtRule *> atrules;
	std::list<Ruleset *> rulesets;
	std::list<StylesheetStatement *> statements;

protected:
	virtual void addStatement(StylesheetStatement &statement);
	virtual void addRuleset(Ruleset &ruleset);
	virtual void addAtRule(AtRule &rule);
	void deleteStatement(StylesheetStatement &statement);

public:
	Stylesheet() {}
	virtual ~Stylesheet();
	Ruleset *createRuleset(Selector &selector);
	AtRule *createAtRule(const Token &keyword);
	virtual MediaQuery *createMediaQuery(const TokenList &selector);
	Comment *createComment();
	void deleteRuleset(Ruleset &ruleset);
	void deleteAtRule(AtRule &atrule);
	void deleteMediaQuery(MediaQuery &query);
	const std::list<AtRule *> &getAtRules() const;
	const std::list<Ruleset *> &getRulesets() const;
	const std::list<StylesheetStatement *> &getStatements() const;
	virtual Ruleset *getRuleset(const Selector &selector) const;
	void updateRulesetSelector(const Ruleset &ruleset);
	virtual void process(Stylesheet &s, void *context) const;
	virtual void write(Writer &writer) const;
};

#endif  // __Stylesheet_h__
