#ifndef Parser_h
#define Parser_h

#include "Stylesheet.h"
#include "Tokenizer.h"
#include "Token.h"
#include "Ruleset.h"
#include "Selector.h"
#include "Property.h"
#include "Variable.h"
#include "Value.h"
#include "VariableValue.h"
#include "FunctionValue.h"

namespace Dezel {
namespace Style {

class Parser {

private:

	Stylesheet* stylesheet;
	Tokenizer* tokenizer;

	bool parse();
	bool parseStatement(TokenList& tokens);
	bool parseDelimiter(TokenList& tokens);

	Rule* parseRule(TokenList& tokens);
	Ruleset* parseRuleset(TokenList& tokens);
	Variable* parseVariable(TokenList& tokens);
	Selector* parseSelector(TokenList& tokens);
	Property* parseProperty(TokenList& tokens);


	Value* parseIdentValue(TokenList& tokens);
	Value* parseStringValue(TokenList& tokens);
	Value* parseNumberValue(TokenList& tokens);
	Value* parseFunctionValue(TokenList& tokens);
	Value* parseVariableValue(TokenList& tokens);

public:

	Parser(Stylesheet* stylesheet, Tokenizer* tokenizer);

};

}
}

#endif
