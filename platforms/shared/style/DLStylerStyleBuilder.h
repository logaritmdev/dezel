#ifndef DLStylerStyleBuilder_h
#define DLStylerStyleBuilder_h

#include <vector>
#include <iostream>
#include "Writer.h"
#include "Token.h"
#include "TokenList.h"
#include "Selector.h"
#include "DLStyler.h"

using std::vector;

class DLStylerStyleBuilder : public Writer {

private:
	DLStylerRef context;
	vector<DLStylerStyleRuleRef> all_rules;
	vector<DLStylerStyleRuleRef> new_rules;
	DLStylerStyleRuleRefMap rules;
	int rules_count = 0;
	int items_count = 0;
	void expand_rules();
	void merge_types(const vector<DLStylerStyleRuleRef> &types);
	void merge_rules(const vector<DLStylerStyleRuleRef> &rules);
	void build_tree();

public:

	DLStylerStyleBuilder(DLStylerRef context_) : Writer() {
		context = context_;
	};

	virtual void writeAtRule(const Token &keyword, const TokenList &rule);
	virtual void writeRulesetStart(const Selector &selector);
	virtual void writeRulesetEnd();
	virtual void writeDeclaration(const Token &property, const TokenList &value);
	virtual void writeDeclarationDeliminator();
	virtual void writeComment(const Token &comment);
	virtual void writeMediaQueryStart(const TokenList &selector);
	virtual void writeMediaQueryEnd();

	virtual void build();

};

#endif
