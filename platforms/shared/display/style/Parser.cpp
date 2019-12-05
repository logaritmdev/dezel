#include "Parser.h"
#include "Token.h"
#include "Tokenizer.h"
#include "TokenizerStream.h"
#include "Descriptor.h"
#include "Selector.h"
#include "Fragment.h"
#include "Argument.h"
#include "NullValue.h"
#include "StringValue.h"
#include "NumberValue.h"
#include "BooleanValue.h"
#include "FunctionValue.h"
#include "VariableValue.h"
#include "ParseException.h"

#include <iostream>
#include <string>
#include <assert.h>

namespace Dezel {
namespace Style {

using std::string;

void
Parser::parse(Stylesheet* stylesheet, const string& source)
{
	TokenizerStream stream(source);
	Tokenizer tokenizer(stream);
	Parser parser(stylesheet, &tokenizer);
}

void
Parser::parse(Stylesheet* stylesheet, const string& source, const string& url)
{
	TokenizerStream stream(source);
	Tokenizer tokenizer(stream);
	Parser parser(stylesheet, &tokenizer, url);
}

void
Parser::parse(vector<Value*>& values, const string& source)
{
	TokenizerStream stream(source);
	Tokenizer tokenizer(stream);
	Parser parser(values, &tokenizer);
}

Parser::Parser(Stylesheet* stylesheet, Tokenizer* tokenizer) : Parser(stylesheet, tokenizer, "<anonymous file>")
{

}

Parser::Parser(Stylesheet* stylesheet, Tokenizer* tokenizer, string file) : stylesheet(stylesheet), tokenizer(tokenizer), file(file)
{
	auto tokens = this->tokenizer->getTokens();

	tokens.skipSpace();

	do {

		if (this->parseVariable(tokens, stylesheet)) continue;
		if (this->parseDescriptor(tokens, stylesheet)) continue;

		if (tokens.getCurrTokenType() == kTokenTypeEnd) {
			return;
		}

		/*
		 * If we reach this point it probably mean there's a
		 * syntax error.
		 */

		this->unexpectedToken(tokens);

	} while (tokens.hasNextToken());
}

Parser::Parser(vector<Value*>& values, Tokenizer* tokenizer) : stylesheet(nullptr), tokenizer(tokenizer), file("<anonymous file>")
{
	auto tokens = this->tokenizer->getTokens();

	tokens.skipSpace();

	while (true) {

		if (tokens.getCurrTokenType() == kTokenTypeEnd) {
			break;
		}

		auto parsed = this->parseEvaluatedValue(tokens, values);

		if (parsed) {
			tokens.nextToken();
			continue;
		}

		break;
	}
}

//------------------------------------------------------------------------------
// MARK: Private API
//------------------------------------------------------------------------------

bool
Parser::parseDescriptor(TokenList& tokens, Stylesheet* target)
{
	auto result = this->parseDescriptor(tokens);

	if (result) {
		target->addDescriptor(result);
		return true;
	}

	return false;
}

bool
Parser::parseDescriptor(TokenList& tokens, Descriptor* target)
{
	auto result = this->parseDescriptor(tokens);

	if (result) {
		target->addChildDescriptor(result);
		return true;
	}

	return false;
}

bool
Parser::parseStyleDescriptor(TokenList& tokens, Descriptor* target)
{
	auto result = this->parseStyleDescriptor(tokens);

	if (result) {
		target->addStyleDescriptor(result);
		return true;
	}

	return false;
}

bool
Parser::parseStateDescriptor(TokenList& tokens, Descriptor* target)
{
	auto result = this->parseStateDescriptor(tokens);

	if (result) {
		target->addStateDescriptor(result);
		return true;
	}

	return false;
}

bool
Parser::parseChildDescriptor(TokenList& tokens, Descriptor* target)
{
	auto result = this->parseChildDescriptor(tokens);

	if (result) {
		target->addChildDescriptor(result);
		return true;
	}

	return false;
}

bool
Parser::parseVariable(TokenList& tokens, Stylesheet* target)
{
	auto result = this->parseVariable(tokens);

	if (result) {
		target->addVariable(result);
		return true;
	}

	return false;
}

bool
Parser::parseSelector(TokenList& tokens, Descriptor* target)
{
	auto result = this->parseSelector(tokens);

	if (result) {
		target->selector = result;
		target->selector->descriptor = target;
		return true;
	}

	return false;
}

bool
Parser::parseProperty(TokenList& tokens, Descriptor* target)
{
	auto result = this->parseProperty(tokens);

	if (result) {
		target->addProperty(result);
		return true;
	}

	return false;
}

bool
Parser::parseEvaluatedValue(TokenList& tokens, vector<Value*>& values)
{
	auto result = this->parseValue(tokens);

	if (result == nullptr) {
		return false;
	}

	if (result->getType() == kValueTypeVariable ||
		result->getType() == kValueTypeFunction) {

		bool evaluated = false;

		if (this->evaluateVariable(result, values)) evaluated = true;
		if (this->evaluateFunction(result, values)) evaluated = true;

		if (evaluated) {

			/*
			 * The parsed value has been replaced by the function or variable
			 * and we don't need it anymore.
			 */

			delete result;

			return true;
		}
	}

	values.push_back(result);

	return true;
}

Descriptor*
Parser::parseDescriptor(TokenList& tokens)
{
	if (tokens.getCurrTokenType() != kTokenTypeHash &&
		tokens.getCurrTokenType() != kTokenTypeIdent &&
		tokens.getCurrTokenType() != kTokenTypeStyleIdent &&
		tokens.getCurrTokenType() != kTokenTypeStateIdent) {
		return nullptr;
	}

	auto descriptor = new Descriptor();

	this->parseSelector(tokens, descriptor);
	
	tokens.skipSpace();

	this->assertTokenType(tokens, kTokenTypeCurlyBracketOpen);

	tokens.nextToken();
	tokens.skipSpace();

	this->parseDescriptorBlock(tokens, descriptor);

	this->assertTokenType(tokens, kTokenTypeCurlyBracketClose);

	tokens.nextToken();
	tokens.skipSpace();

	return descriptor;
}

Descriptor*
Parser::parseChildDescriptor(TokenList& tokens)
{
	return this->parseDescriptor(tokens);
}

Descriptor*
Parser::parseStyleDescriptor(TokenList& tokens)
{
	if (tokens.getCurrTokenType() != kTokenTypeAt ||
		tokens.getNextTokenType() != kTokenTypeIdent ||
		tokens.getNextTokenName() != "style") {
		return nullptr;
	}

	tokens.nextToken();

	this->assertTokenType(tokens, kTokenTypeIdent);

	tokens.nextToken();
	tokens.skipSpace();

	auto name = tokens.getCurrTokenName();

	tokens.nextToken();
	tokens.skipSpace();

	this->assertTokenType(tokens, kTokenTypeCurlyBracketOpen);

	tokens.nextToken();
	tokens.skipSpace();

	auto descriptor = new Descriptor();

	auto selector = new Selector();
	auto fragment = new Fragment();

	selector->head = fragment;
	selector->tail = fragment;

	fragment->styles.push_back(name);

	descriptor->selector = selector;

	this->parseDescriptorBlock(tokens, descriptor);

	this->assertTokenType(tokens, kTokenTypeCurlyBracketClose);

	tokens.nextToken();
	tokens.skipSpace();

	return descriptor;
}

Descriptor*
Parser::parseStateDescriptor(TokenList& tokens)
{
	if (tokens.getCurrTokenType() != kTokenTypeAt ||
		tokens.getNextTokenType() != kTokenTypeIdent ||
		tokens.getNextTokenName() != "state") {
		return nullptr;
	}

	tokens.nextToken();

	this->assertTokenType(tokens, kTokenTypeIdent);

	tokens.nextToken();
	tokens.skipSpace();

	this->assertTokenType(tokens, kTokenTypeIdent);

	auto name = tokens.getCurrTokenName();

	tokens.nextToken();
	tokens.skipSpace();

	this->assertTokenType(tokens, kTokenTypeCurlyBracketOpen);

	tokens.nextToken();
	tokens.skipSpace();

	auto descriptor = new Descriptor();

	auto selector = new Selector();
	auto fragment = new Fragment();

	selector->head = fragment;
	selector->tail = fragment;

	fragment->states.push_back(name);

	descriptor->selector = selector;

	this->parseDescriptorBlock(tokens, descriptor);

	this->assertTokenType(tokens, kTokenTypeCurlyBracketClose);

	tokens.nextToken();
	tokens.skipSpace();

	return descriptor;
}

void
Parser::parseDescriptorBlock(TokenList& tokens, Descriptor* descriptor)
{
	while (true) {
		if (this->parseProperty(tokens, descriptor)) continue;
		if (this->parseStyleDescriptor(tokens, descriptor)) continue;
		if (this->parseStateDescriptor(tokens, descriptor)) continue;
		if (this->parseChildDescriptor(tokens, descriptor)) continue;
		break;
	}
}

Variable*
Parser::parseVariable(TokenList& tokens)
{
	if (tokens.getCurrTokenType() != kTokenTypeVariable) {
		return nullptr;
	}

	auto name = tokens.getCurrTokenName();

	tokens.nextToken();
	tokens.skipSpace();

	this->assertTokenType(tokens, kTokenTypeColon);

	auto variable = new Variable(name);

	tokens.nextToken();
	tokens.skipSpace();

	while (true) {

		auto parsed = this->parseEvaluatedValue(tokens, variable->values);

		if (parsed) {
			tokens.nextToken();
			continue;
		}

		break;
	}

	tokens.nextToken();
	tokens.skipSpace();

	return variable;
}

Selector*
Parser::parseSelector(TokenList& tokens)
{
	if (tokens.getCurrTokenType() != kTokenTypeHash &&
		tokens.getCurrTokenType() != kTokenTypeIdent &&
		tokens.getCurrTokenType() != kTokenTypeStyleIdent &&
		tokens.getCurrTokenType() != kTokenTypeStateIdent) {
		return nullptr;
	}

	auto selector = new Selector();

	while (true) {

		auto fragment = this->parseFragment(tokens);

		if (fragment) {

			fragment->selector = selector;

			if (selector->head == nullptr &&
				selector->tail == nullptr) {

				selector->head = fragment;
				selector->tail = fragment;

			} else {

				fragment->prev = selector->tail;
				fragment->prev->next = fragment;
				selector->tail = fragment;
			}

			selector->offset = tokens.getCurrToken().getOffset();
			selector->length++;

			continue;
		}

		tokens.skipSpace();

		if (tokens.getCurrTokenType() != kTokenTypeHash &&
			tokens.getCurrTokenType() != kTokenTypeIdent &&
			tokens.getCurrTokenType() != kTokenTypeStyleIdent &&
			tokens.getCurrTokenType() != kTokenTypeStateIdent) {
			break;
		}
	}

	return selector;
}

Fragment*
Parser::parseFragment(TokenList& tokens)
{
	if (tokens.getCurrTokenType() != kTokenTypeHash &&
		tokens.getCurrTokenType() != kTokenTypeIdent &&
		tokens.getCurrTokenType() != kTokenTypeStyleIdent &&
		tokens.getCurrTokenType() != kTokenTypeStateIdent) {
		return nullptr;
	}

	auto fragment = new Fragment();

	while (true) {

		switch (tokens.getCurrTokenType()) {

			case kTokenTypeHash:
				fragment->name = tokens.getCurrTokenName();
				break;

			case kTokenTypeIdent:
				fragment->type = tokens.getCurrTokenName();
				break;

			case kTokenTypeStyleIdent:
				fragment->styles.push_back(tokens.getCurrTokenName());
				break;

			case kTokenTypeStateIdent:
				fragment->states.push_back(tokens.getCurrTokenName());
				break;

			default:
				break;
		}

		tokens.nextToken();

		if (tokens.getCurrTokenType() != kTokenTypeHash &&
			tokens.getCurrTokenType() != kTokenTypeIdent &&
			tokens.getCurrTokenType() != kTokenTypeStyleIdent &&
			tokens.getCurrTokenType() != kTokenTypeStateIdent) {
			break;
		}
	}

	return fragment;
}

Property*
Parser::parseProperty(TokenList& tokens)
{
	if (tokens.getCurrTokenType() != kTokenTypeIdent) {
		return nullptr;
	}

	if (tokens.getNextTokenType(1) == kTokenTypeSpace &&
		tokens.getNextTokenType(2) != kTokenTypeColon) {
		return nullptr;
	}

	if (tokens.getNextTokenType(1) != kTokenTypeColon) {
		return nullptr;
	}

	auto name = tokens.getCurrTokenName();

	tokens.nextToken();
	tokens.skipSpace();

	this->assertTokenType(tokens, kTokenTypeColon);

	auto property = new Property(this->toCamelCase(name));

	tokens.nextToken();
	tokens.skipSpace();

	while (true) {

		auto parsed = this->parseEvaluatedValue(tokens, property->values);

		if (parsed) {
			tokens.nextToken();
			continue;
		}

		break;
	}

	tokens.nextToken();
	tokens.skipSpace();

	return property;
}

Value*
Parser::parseValue(TokenList& tokens)
{
	if (tokens.getCurrTokenType() == kTokenTypeSpace) {
		tokens.nextToken();
	}

	if (tokens.getCurrTokenType() == kTokenTypeIdent) {
		return this->parseIdentValue(tokens);
	}

	if (tokens.getCurrTokenType() == kTokenTypeNumber) {
		return this->parseNumberValue(tokens);
	}

	if (tokens.getCurrTokenType() == kTokenTypeString) {
		return this->parseStringValue(tokens);
	}

	if (tokens.getCurrTokenType() == kTokenTypeHash) {
		return this->parseColorValue(tokens);
	}

	if (tokens.getCurrTokenType() == kTokenTypeVariable) {
		return this->parseVariableValue(tokens);
	}

	if (tokens.getCurrTokenType() == kTokenTypeFunction) {
		return this->parseFunctionValue(tokens);
	}

	if (tokens.getCurrTokenType() == kTokenTypeDelimiter ||
		tokens.getCurrTokenType() == kTokenTypeLinebreak) {
		return nullptr;
	}

	this->unexpectedToken(tokens);

	return nullptr;
}

Value*
Parser::parseIdentValue(TokenList& tokens)
{
	if (tokens.getCurrToken().hasName("null")) {
		return new NullValue();
	}

	if (tokens.getCurrToken().hasName("true")) {
		return new BooleanValue(true);
	}

	if (tokens.getCurrToken().hasName("false")) {
		return new BooleanValue(false);
	}

	return this->parseStringValue(tokens);
}

Value*
Parser::parseColorValue(TokenList& tokens)
{
	string color;
	color.append("#");
	color.append(tokens.getCurrTokenName());
	return new StringValue(color);
}

Value*
Parser::parseStringValue(TokenList& tokens)
{
	return new StringValue(tokens.getCurrTokenName());
}

Value*
Parser::parseNumberValue(TokenList& tokens)
{
	if (tokens.getCurrTokenUnit() == "") {
		return new NumberValue(tokens.getCurrTokenName(), kValueUnitNone);
	}

	if (tokens.getCurrTokenUnit() == "%") {
		return new NumberValue(tokens.getCurrTokenName(), kValueUnitPC);
	}

	if (tokens.getCurrToken().hasUnit("px")) {
		return new NumberValue(tokens.getCurrTokenName(), kValueUnitPX);
	}

	if (tokens.getCurrToken().hasUnit("vw")) {
		return new NumberValue(tokens.getCurrTokenName(), kValueUnitVW);
	}

	if (tokens.getCurrToken().hasUnit("vh")) {
		return new NumberValue(tokens.getCurrTokenName(), kValueUnitVH);
	}

	if (tokens.getCurrToken().hasUnit("pw")) {
		return new NumberValue(tokens.getCurrTokenName(), kValueUnitPW);
	}

	if (tokens.getCurrToken().hasUnit("ph")) {
		return new NumberValue(tokens.getCurrTokenName(), kValueUnitPH);
	}

	if (tokens.getCurrToken().hasUnit("cw")) {
		return new NumberValue(tokens.getCurrTokenName(), kValueUnitCW);
	}

	if (tokens.getCurrToken().hasUnit("ch")) {
		return new NumberValue(tokens.getCurrTokenName(), kValueUnitCH);
	}

	if (tokens.getCurrToken().hasUnit("deg")) {
		return new NumberValue(tokens.getCurrTokenName(), kValueUnitDeg);
	}

	if (tokens.getCurrToken().hasUnit("rad")) {
		return new NumberValue(tokens.getCurrTokenName(), kValueUnitRad);
	}

	this->unexpectedToken(tokens);

	return nullptr;
}

Value*
Parser::parseVariableValue(TokenList& tokens)
{
	if (tokens.getCurrTokenType() != kTokenTypeVariable) {
		return nullptr;
	}

	return new VariableValue(tokens.getCurrTokenName());
}

Value*
Parser::parseFunctionValue(TokenList& tokens)
{
	if (tokens.getCurrTokenType() != kTokenTypeFunction) {
		return nullptr;
	}

	auto argument = new Argument();
	auto function = new FunctionValue(tokens.getCurrTokenName());

	tokens.nextToken();

	this->assertTokenType(tokens, kTokenTypeParenthesisOpen);

	tokens.nextToken();
	tokens.skipSpace();

	while (true) {

		if (tokens.getCurrTokenType() == kTokenTypeSpace) {
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeIdent) {
			argument->values.push_back(this->parseIdentValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeString) {
			argument->values.push_back(this->parseStringValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeNumber) {
			argument->values.push_back(this->parseNumberValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeVariable) {

			auto value = this->parseVariableValue(tokens);

			if (this->evaluateVariable(value, argument->values)) {

				/*
				 * The parsed value has been replaced by the variable  and we
				 * don't need it anymore.
				 */

				delete value;

			} else {
				argument->values.push_back(value);
			}

			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeFunction) {

			auto value = this->parseFunctionValue(tokens);

			if (this->evaluateFunction(value, argument->values)) {

				/*
				 * The parsed value has been replaced by the variable  and we
				 * don't need it anymore.
				 */

				delete value;

			} else {
				argument->values.push_back(value);
			}

			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeComma) {
			tokens.nextToken();
			function->arguments.push_back(argument);
			argument = new Argument();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeParenthesisClose) {
			function->arguments.push_back(argument);
			argument = nullptr;
			break;
		}

		this->unexpectedToken(tokens);
	}

	return function;
}

bool
Parser::evaluateVariable(Value* value, vector<Value*>& result)
{
	if (this->stylesheet == nullptr) {
		return false;
	}

	return value->getType() == kValueTypeVariable ? dynamic_cast<VariableValue*>(value)->evaluate(this->stylesheet, result) : false;
}

bool
Parser::evaluateFunction(Value* value, vector<Value*>& result)
{
	if (this->stylesheet == nullptr) {
		return false;
	}
	
	return value->getType() == kValueTypeFunction ? dynamic_cast<FunctionValue*>(value)->evaluate(this->stylesheet, result) : false;
}

string
Parser::toCamelCase(string name)
{
	string camelized;

	for (int i = 0; i < name.length(); i++) {

		auto character = name[i];

		if (character == '-' ||
			character == '_') {

			if (i == name.length() - 1) {
				break;
			}

			character = toupper(name[++i]);
		}

		camelized.append(1, character);
	}

	return camelized;
}

void
Parser::assertTokenType(TokenList& tokens, TokenType type)
{
	if (tokens.getCurrTokenType() == type) {
		return;
	}

	this->unexpectedToken(tokens);
}

void
Parser::unexpectedToken(TokenList &tokens)
{
	auto token = tokens.getCurrToken();

	size_t col = 0;
	size_t row = 0;

	this->tokenizer->locate(token, col, row);

	throw ParseException(
		"Unexpected token",
		token.getName(),
		this->file,
		col,
		row
	);
}

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

}
}
