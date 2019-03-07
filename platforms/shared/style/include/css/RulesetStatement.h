#ifndef __RulesetStatement_h__
#define __RulesetStatement_h__

#include "Writable.h"

class Ruleset;

class RulesetStatement : public Writable {
protected:
	Ruleset *ruleset;

public:
	virtual ~RulesetStatement() {};
	virtual void setRuleset(Ruleset *r);
	Ruleset *getRuleset() const;
	virtual void process(Ruleset &r, void *context) const = 0;
};

#include "Ruleset.h"

#endif  // __RulesetStatement_h__
