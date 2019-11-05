#include "Parser.h"
#include "Token.h"
#include "Tokenizer.h"
#include "TokenizerStream.h"
#include "Descriptor.h"
#include "Selector.h"
#include "Fragment.h"
#include "NullValue.h"
#include "StringValue.h"
#include "NumberValue.h"
#include "BooleanValue.h"
#include "FunctionValue.h"
#include "VariableValue.h"
#include "Argument.h"
#include "ParseException.h"

#include <iostream>
#include <string>
#include <assert.h>

namespace Dezel {
namespace Style {

using std::string;

Parser::Parser(Stylesheet* stylesheet, Tokenizer* tokenizer) : stylesheet(stylesheet), tokenizer(tokenizer)
{
	auto tokens = this->tokenizer->getTokens();

	tokens.skipSpace();

	do {

		auto variable = this->parseVariable(tokens);

		if (variable) {
			stylesheet->addVariable(variable);
			continue;
		}

		if (this->parseDescriptor(tokens, stylesheet)) {
			continue;
		}

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
Parser::parseProperty(TokenList& tokens, Descriptor* target)
{
	auto result = this->parseProperty(tokens);

	if (result) {
		target->addProperty(result);
		return true;
	}

	return false;
}

Descriptor*
Parser::parseDescriptor(TokenList& tokens)
{
	if (tokens.getCurrTokenType() != kTokenTypeHash &&
		tokens.getCurrTokenType() != kTokenTypeIdent) {
		return nullptr;
	}

	auto descriptor = new Descriptor();

	descriptor->selector = this->parseSelector(tokens);

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
	fragment->style = name;

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
	fragment->state = name;

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

		if (tokens.getCurrTokenType() == kTokenTypeSpace) {
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeIdent) {
			variable->values.push_back(this->parseIdentValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeNumber) {
			variable->values.push_back(this->parseNumberValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeString) {
			variable->values.push_back(this->parseStringValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeVariable) {
			variable->values.push_back(this->parseVariableValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeFunction) {
			variable->values.push_back(this->parseFunctionValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeDelimiter ||
			tokens.getCurrTokenType() == kTokenTypeLinebreak) {
			break;
		}

		this->unexpectedToken(tokens);

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
		tokens.getCurrTokenType() != kTokenTypeIdent) {
		return nullptr;
	}

	auto selector = new Selector();

	while (true) {

		auto fragment = this->parseFragment(tokens);

		if (fragment) {

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

			if (fragment->type.size())
				selector->weight += 1;
			if (fragment->name.size())
				selector->weight += 10;
			if (fragment->style.size())
				selector->weight += 100;
			if (fragment->state.size())
				selector->weight += 100;

			selector->length++;

			continue;
		}

		tokens.skipSpace();

		if (tokens.getCurrTokenType() != kTokenTypeHash &&
			tokens.getCurrTokenType() != kTokenTypeIdent) {
			break;
		}
	}

	return selector;
}

Fragment*
Parser::parseFragment(TokenList& tokens)
{
	if (tokens.getCurrTokenType() != kTokenTypeHash &&
		tokens.getCurrTokenType() != kTokenTypeIdent) {
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

			default:
				break;
		}

		tokens.nextToken();

		if (tokens.getCurrTokenType() != kTokenTypeHash &&
			tokens.getCurrTokenType() != kTokenTypeIdent) {
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

	auto property = new Property(name);

	tokens.nextToken();
	tokens.skipSpace();

	while (true) {

		if (tokens.getCurrTokenType() == kTokenTypeSpace) {
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeIdent) {
			property->values.push_back(this->parseIdentValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeNumber) {
			property->values.push_back(this->parseNumberValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeString) {
			property->values.push_back(this->parseStringValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeVariable) {
			property->values.push_back(this->parseVariableValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeFunction) {
			property->values.push_back(this->parseFunctionValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrTokenType() == kTokenTypeDelimiter ||
			tokens.getCurrTokenType() == kTokenTypeLinebreak) {
			break;
		}

		break;
	}

	tokens.nextToken();
	tokens.skipSpace();

	return property;
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

	auto variable = new VariableValue(tokens.getCurrTokenName());

	tokens.nextToken();
	tokens.skipSpace();

	return variable;
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
			argument->values.push_back(this->parseVariableValue(tokens));
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
		col,
		row
	);
}

}
}
