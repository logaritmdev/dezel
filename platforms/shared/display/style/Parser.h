#ifndef Parser_h
#define Parser_h

#include "Stylesheet.h"
#include "Tokenizer.h"
#include "Token.h"
#include "Descriptor.h"
#include "Fragment.h"
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

	bool parseDescriptor(TokenList& tokens, Stylesheet* stylesheet);
	bool parseDescriptor(TokenList& tokens, Descriptor* descriptor);
	bool parseChildDescriptor(TokenList& tokens, Descriptor* descriptor);
	bool parseStyleDescriptor(TokenList& tokens, Descriptor* descriptor);
	bool parseStateDescriptor(TokenList& tokens, Descriptor* descriptor);
	bool parseVariable(TokenList& tokens, Stylesheet* stylesheet);
	bool parseSelector(TokenList& tokens, Descriptor* descriptor);
	bool parseProperty(TokenList& tokens, Descriptor* descriptor);

	Descriptor* parseDescriptor(TokenList& tokens);
	Descriptor* parseChildDescriptor(TokenList& tokens);
	Descriptor* parseStyleDescriptor(TokenList& tokens);
	Descriptor* parseStateDescriptor(TokenList& tokens);

	void parseDescriptorBlock(TokenList& tokens, Descriptor* target);

	Variable* parseVariable(TokenList& tokens);
	Selector* parseSelector(TokenList& tokens);
	Fragment* parseFragment(TokenList& tokens);
	Property* parseProperty(TokenList& tokens);

	Value* parseIdentValue(TokenList& tokens);
	Value* parseStringValue(TokenList& tokens);
	Value* parseNumberValue(TokenList& tokens);
	Value* parseFunctionValue(TokenList& tokens);
	Value* parseVariableValue(TokenList& tokens);

	void assertTokenType(TokenList& tokens, TokenType type);

	void unexpectedToken(TokenList& tokens);

public:

	Parser(Stylesheet* stylesheet, Tokenizer* tokenizer);

};

}
}

#endif
