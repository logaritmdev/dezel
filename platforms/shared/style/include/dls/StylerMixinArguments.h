#ifndef __MixinArguments_h__
#define __MixinArguments_h__

#include <map>
#include <string>
#include <vector>

#include "TokenList.h"

class ProcessingContext;

class StylerMixinArguments {
private:
	std::vector<TokenList> arguments;
	std::map<std::string, TokenList> namedArguments;

public:
	size_t count() const;
	const TokenList *get(const size_t i) const;
	const TokenList *get(const std::string &name) const;
	void add(TokenList &argument);
	void add(std::string name, TokenList &argument);
	void process(ProcessingContext &context);
};

#endif  // __MixinArguments_h__
