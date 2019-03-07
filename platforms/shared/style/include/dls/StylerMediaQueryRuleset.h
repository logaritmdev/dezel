#ifndef __MediaQueryRuleset_h__
#define __MediaQueryRuleset_h__

#include <list>
#include <map>

#include "Selector.h"
#include "Stylesheet.h"

#include "Token.h"

#include "StylerRuleset.h"

class StylerMediaQueryRuleset : public StylerRuleset {
private:
	TokenList selector;

public:
	StylerMediaQueryRuleset(TokenList &selector, const StylerRuleset &parent);
	virtual ~StylerMediaQueryRuleset();
	virtual void process(Stylesheet &s, const Selector *prefix, ProcessingContext &context) const;
};

#endif  // __MediaQueryRuleset_h__
