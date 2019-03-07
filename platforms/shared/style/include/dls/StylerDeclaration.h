#ifndef __LessDeclaration_h__
#define __LessDeclaration_h__

#include "Declaration.h"
#include "Ruleset.h"

class StylerRuleset;

class StylerDeclaration : public Declaration {
	StylerRuleset *lessRuleset;

public:
	void setLessRuleset(StylerRuleset &r);
	StylerRuleset *getLessRuleset();
	virtual void process(Ruleset &r, void *context) const;
};

#endif  // __LessDeclaration_h__
