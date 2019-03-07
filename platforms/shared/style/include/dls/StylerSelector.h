#ifndef __LessSelector_h__
#define __LessSelector_h__

#include <iterator>
#include <list>
#include <map>
#include <string>

#include "StylerMixinArguments.h"
#include "StylerExtension.h"
#include "Selector.h"

class StylerSelector : public Selector {
private:
	std::list<StylerExtension> extensions;
	std::list<std::string> parameters;
	std::list<TokenList> defaults;
	std::list<TokenList> conditions;
	bool _unlimitedArguments;
	bool _needsArguments;
	std::string restIdentifier;

public:
	StylerSelector();
	virtual ~StylerSelector();
	void addExtension(StylerExtension &extension);
	void addParameter(Token &keyword, TokenList &value);
	void setUnlimitedArguments(bool b);
	void setUnlimitedArguments(bool b, Token restKeyword);
	void eraseArguments();
	void addCondition(TokenList &condition);
	void setNeedsArguments(bool b);
	const std::list<StylerExtension> &getExtensions() const;
	const std::list<std::string> &getParameters() const;
	const TokenList *getDefault(const std::string &parameter) const;
	const std::list<TokenList> &getConditions() const;
	bool matchArguments(const StylerMixinArguments &arguments) const;
	bool needsArguments() const;
	bool unlimitedArguments() const;
	std::string getRestIdentifier() const;
};

#endif  // __LessSelector_h__
