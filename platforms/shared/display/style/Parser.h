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

	string file;

	Parser(Stylesheet* stylesheet, Tokenizer* tokenizer);
	Parser(Stylesheet* stylesheet, Tokenizer* tokenizer, string file);
	Parser(vector<Value*>& values, Tokenizer* tokenizer);

	bool parse();

	bool parseDescriptor(TokenList& tokens, Stylesheet* stylesheet);
	bool parseDescriptor(TokenList& tokens, Descriptor* descriptor);
	bool parseChildDescriptor(TokenList& tokens, Descriptor* descriptor);
	bool parseStyleDescriptor(TokenList& tokens, Descriptor* descriptor);
	bool parseStateDescriptor(TokenList& tokens, Descriptor* descriptor);
	bool parseVariable(TokenList& tokens, Stylesheet* stylesheet);
	bool parseSelector(TokenList& tokens, Descriptor* descriptor);
	bool parseProperty(TokenList& tokens, Descriptor* descriptor);

	bool parseEvaluatedValue(TokenList& tokens, vector<Value*>& values);

	Descriptor* parseDescriptor(TokenList& tokens);
	Descriptor* parseChildDescriptor(TokenList& tokens);
	Descriptor* parseStyleDescriptor(TokenList& tokens);
	Descriptor* parseStateDescriptor(TokenList& tokens);

	void parseDescriptorBlock(TokenList& tokens, Descriptor* target);

	Variable* parseVariable(TokenList& tokens);
	Selector* parseSelector(TokenList& tokens);
	Fragment* parseFragment(TokenList& tokens);
	Property* parseProperty(TokenList& tokens);

	Value* parseValue(TokenList& tokens);
	Value* parseIdentValue(TokenList& tokens);
	Value* parseColorValue(TokenList& tokens);
	Value* parseStringValue(TokenList& tokens);
	Value* parseNumberValue(TokenList& tokens);
	Value* parseFunctionValue(TokenList& tokens);
	Value* parseVariableValue(TokenList& tokens);

	bool evaluateVariable(Value* value, vector<Value*>& result);
	bool evaluateFunction(Value* value, vector<Value*>& result);

	string toCamelCase(string name);

	void assertTokenType(TokenList& tokens, TokenType type);

	void unexpectedToken(TokenList& tokens);

public:

	static void parse(Stylesheet* stylesheet, const string& source);
	static void parse(Stylesheet* stylesheet, const string& source, const string& url);
	static void parse(vector<Value*>& values, const string& source);

};

}
}

#endif
