#include "Parser.h"
#include "Token.h"
#include "Tokenizer.h"
#include "TokenizerStream.h"
#include "Ruleset.h"
#include "Rule.h"
#include "Selector.h"
#include "NullValue.h"
#include "StringValue.h"
#include "NumberValue.h"
#include "BooleanValue.h"
#include "FunctionValue.h"
#include "VariableValue.h"
#include "Argument.h"

#include <iostream>
#include <string>
#include <assert.h>

namespace Dezel {
namespace Style {

using std::string;

static bool equals(const string& str1, const string& str2) {

	if (str1.size() != str2.size()) {
        return false;
    }

    for (auto c1 = str1.begin(), c2 = str2.begin(); c1 != str1.end(); ++c1, ++c2) {
        if (tolower(*c1) != tolower(*c2)) {
            return false;
        }
    }

    return true;
}

Parser::Parser(Stylesheet* stylesheet, Tokenizer* tokenizer) : stylesheet(stylesheet), tokenizer(tokenizer)
{
	auto tokens = this->tokenizer->getTokens();

	tokens.skipSpace();

	do {

		auto ruleset = this->parseRuleset(tokens);

		if (ruleset) {
			std::cout << "Ruleset : " << ruleset->toString();
			tokens.nextToken();
			tokens.skipSpace();
		}

		auto variable = this->parseVariable(tokens);

		if (variable) {
			stylesheet->variables[variable->name] = variable;
			tokens.nextToken();
			tokens.skipSpace();
		}

	} while (tokens.hasNextToken());

	for (auto item : stylesheet->variables) {
		std::cout << "Variable: " << item.second->toString();
	}
}

bool
Parser::parseStatement(TokenList& tokens)
{


//	auto variable = this->parseVariable();
//
//	if (variable) {
//		return true;
//	}

	return false;
}

bool
Parser::parseDelimiter(TokenList& tokens)
{
	return false;
}

Ruleset*
Parser::parseRuleset(TokenList& tokens)
{
	if (tokens.getCurrentTokenType() != kTokenTypeHash &&
		tokens.getCurrentTokenType() != kTokenTypeIdent &&
		tokens.getCurrentTokenType() != kTokenTypeClass &&
		tokens.getCurrentTokenType() != kTokenTypeAmpersand) {
		return nullptr;
	}

	auto ruleset = new Ruleset();

	while (true) {

		/*
		 * Start parsing rules until something other than a rule or a
		 * comma is found.
		 */

		auto rule = this->parseRule(tokens);

		if (rule) {
			ruleset->rules.push_back(rule);
			continue;
		}

		tokens.skipSpace();

		if (tokens.getCurrentTokenType() == kTokenTypeComma) {
			tokens.nextToken();
			tokens.skipSpace();
			continue;
		}

		break;
	}

	if (tokens.getCurrentTokenType() != kTokenTypeCurlyBracketOpen) {

		/*
		 * If something other than a bracked is found we have an invalid
		 * declaration list and we should abort.
		 */

		assert(false);
	}

	tokens.nextToken();
	tokens.skipSpace();

	while (true) {

		/*
		 * An ampersand character means a reference to the current block
		 * of rules. It can be safely ignored when followed by a space.
		 */

		if (tokens.peek(0).getType() == kTokenTypeAmpersand &&
			tokens.peek(0).getType() == kTokenTypeSpace) {
			tokens.nextToken();
			tokens.skipSpace();
			continue;
		}

		/*
		 * Parses properties.
		 */

		auto property = this->parseProperty(tokens);

		if (property) {
			ruleset->properties.push_back(property);
			tokens.nextToken();
			tokens.skipSpace();
			continue;
		}

		/*
		 * Parses child rulesets.
		 */

		auto child = this->parseRuleset(tokens);

		if (child) {
			child->parent = ruleset;
			child->parent->children.push_back(child);
			continue;
		}

		if (tokens.getCurrentTokenType() != kTokenTypeCurlyBracketClose) {

			/*
			 * If something other than a bracked is found we have an invalid
			 * declaration list and we should abort.
			 */

			assert(false);
		}

		break;
	}

	/*
	 * At this point the current token is the closing curly bracket. Skip
	 * it so the next token is ready to read.
	 */

	 tokens.nextToken();
	 tokens.skipSpace();

	return ruleset;
}

Rule*
Parser::parseRule(TokenList& tokens)
{
	if (tokens.getCurrentTokenType() != kTokenTypeHash &&
		tokens.getCurrentTokenType() != kTokenTypeIdent &&
		tokens.getCurrentTokenType() != kTokenTypeClass &&
		tokens.getCurrentTokenType() != kTokenTypeAmpersand) {
		return nullptr;
	}

	auto rule = new Rule();

	while (true) {

		auto selector = this->parseSelector(tokens);

		if (selector) {

			if (rule->head == nullptr &&
				rule->tail == nullptr) {

				rule->head = selector;
				rule->tail = selector;

			} else {

				selector->prev = rule->tail;
				selector->prev->next = selector;

				rule->tail = selector;
			}

			continue;
		}

		tokens.skipSpace();

		if (tokens.getCurrentTokenType() != kTokenTypeHash &&
			tokens.getCurrentTokenType() != kTokenTypeIdent &&
			tokens.getCurrentTokenType() != kTokenTypeClass &&
			tokens.getCurrentTokenType() != kTokenTypeAmpersand) {
			break;
		}
	}

	return rule;
}

Variable*
Parser::parseVariable(TokenList& tokens)
{
	if (tokens.getCurrentTokenType() != kTokenTypeVariable) {
		return nullptr;
	}

	if (tokens.peek(1, false).getType() != kTokenTypeColon) {
		return nullptr;
	}

	auto variable = new Variable(tokens.getCurrentTokenName());

	tokens.nextToken();
	tokens.skipSpace();

	tokens.nextToken();
	tokens.skipSpace();

	while (true) {

		if (tokens.getCurrentTokenType() == kTokenTypeSpace) {
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeIdent) {
			variable->values.push_back(this->parseIdentValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeNumber) {
			variable->values.push_back(this->parseNumberValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeString) {
			variable->values.push_back(this->parseStringValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeDelimiter ||
			tokens.getCurrentTokenType() == kTokenTypeLinebreak) {
			break;
		}

		assert(false); // INVALID TOKEN HERE

		break;
	}

	return variable;
}

Selector*
Parser::parseSelector(TokenList& tokens)
{
	if (tokens.getCurrentTokenType() != kTokenTypeHash &&
		tokens.getCurrentTokenType() != kTokenTypeIdent &&
		tokens.getCurrentTokenType() != kTokenTypeClass &&
		tokens.getCurrentTokenType() != kTokenTypeAmpersand) {
		return nullptr;
	}

	auto selector = new Selector();

	while (true) {

		switch (tokens.getCurrentTokenType()) {

			case kTokenTypeHash:
				selector->name = tokens.getCurrentTokenName();
				break;

			case kTokenTypeIdent:
				selector->type = tokens.getCurrentTokenName();
				break;

			case kTokenTypeClass:

				switch (tokens.getCurrentTokenClassType()) {

					case kClassTypeStyle:
						selector->styles.insert(tokens.getCurrentTokenName());
						break;

					case kClassTypeState:
						selector->states.insert(tokens.getCurrentTokenName());
						break;

					default:
						break;
				}

				break;

			case kTokenTypeAmpersand:
				selector->modifier = true;
				break;

			default:
				break;
		}

		tokens.nextToken();

		if (tokens.getCurrentTokenType() != kTokenTypeHash &&
			tokens.getCurrentTokenType() != kTokenTypeIdent &&
			tokens.getCurrentTokenType() != kTokenTypeClass &&
			tokens.getCurrentTokenType() != kTokenTypeAmpersand) {
			break;
		}
	}

	return selector;
}


Property*
Parser::parseProperty(TokenList& tokens)
{
	if (tokens.getCurrentTokenType() != kTokenTypeIdent) {
		return nullptr;
	}

	if (tokens.peek(1, false).getType() != kTokenTypeColon) {
		return nullptr;
	}

	auto property = new Property(tokens.getCurrentTokenName());

	tokens.nextToken();
	tokens.skipSpace();

	tokens.nextToken();
	tokens.skipSpace();

	while (true) {

		if (tokens.getCurrentTokenType() == kTokenTypeSpace) {
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeIdent) {
			property->values.push_back(this->parseIdentValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeNumber) {
			property->values.push_back(this->parseNumberValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeString) {
			property->values.push_back(this->parseStringValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeFunction) {
			property->values.push_back(this->parseFunctionValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeDelimiter ||
			tokens.getCurrentTokenType() == kTokenTypeLinebreak) {
			break;
		}

		break;
	}

	return property;
}

Value*
Parser::parseIdentValue(TokenList& tokens)
{
	if (equals(tokens.getCurrentTokenName(), "null")) {
		return new NullValue();
	}

	if (equals(tokens.getCurrentTokenName(), "true")) {
		return new BooleanValue(true);
	}

	if (equals(tokens.getCurrentTokenName(), "false")) {
		return new BooleanValue(false);
	}

	return this->parseStringValue(tokens);
}

Value*
Parser::parseStringValue(TokenList& tokens)
{
	return new StringValue(tokens.getCurrentTokenName());
}

Value*
Parser::parseNumberValue(TokenList& tokens)
{
	if (tokens.getCurrentTokenUnit() == "") {
		return new NumberValue(tokens.getCurrentTokenName(), kValueUnitNone);
	}

	if (tokens.getCurrentTokenUnit() == "%") {
		return new NumberValue(tokens.getCurrentTokenName(), kValueUnitPC);
	}

	if (equals(tokens.getCurrentTokenUnit(), "px")) {
		return new NumberValue(tokens.getCurrentTokenName(), kValueUnitPX);
	}

	if (equals(tokens.getCurrentTokenUnit(), "vw")) {
		return new NumberValue(tokens.getCurrentTokenName(), kValueUnitVW);
	}

	if (equals(tokens.getCurrentTokenUnit(), "vh")) {
		return new NumberValue(tokens.getCurrentTokenName(), kValueUnitVH);
	}

	if (equals(tokens.getCurrentTokenUnit(), "pw")) {
		return new NumberValue(tokens.getCurrentTokenName(), kValueUnitPW);
	}

	if (equals(tokens.getCurrentTokenUnit(), "ph")) {
		return new NumberValue(tokens.getCurrentTokenName(), kValueUnitPH);
	}

	if (equals(tokens.getCurrentTokenUnit(), "cw")) {
		return new NumberValue(tokens.getCurrentTokenName(), kValueUnitCW);
	}

	if (equals(tokens.getCurrentTokenUnit(), "ch")) {
		return new NumberValue(tokens.getCurrentTokenName(), kValueUnitCH);
	}

	if (equals(tokens.getCurrentTokenUnit(), "deg")) {
		return new NumberValue(tokens.getCurrentTokenName(), kValueUnitDeg);
	}

	if (equals(tokens.getCurrentTokenUnit(), "rad")) {
		return new NumberValue(tokens.getCurrentTokenName(), kValueUnitRad);
	}

	assert(false);
}

Value*
Parser::parseVariableValue(TokenList& tokens)
{
	if (tokens.getCurrentTokenType() != kTokenTypeVariable) {
		return nullptr;
	}

	auto variable = new VariableValue(tokens.getCurrentTokenName());

	tokens.nextToken();
	tokens.skipSpace();

	return variable;
}

Value*
Parser::parseFunctionValue(TokenList& tokens)
{
	if (tokens.getCurrentTokenType() != kTokenTypeFunction) {
		return nullptr;
	}

	auto function = new FunctionValue(tokens.getCurrentTokenName());
	auto argument = new Argument();

	tokens.nextToken();

	if (tokens.getCurrentTokenType() != kTokenTypeParenthesisOpen) {
		assert(false);
	}

	tokens.nextToken();
	tokens.skipSpace();

	while (true) {

		if (tokens.getCurrentTokenType() == kTokenTypeSpace) {
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeIdent) {
			argument->values.push_back(this->parseIdentValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeString) {
			argument->values.push_back(this->parseStringValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeNumber) {
			argument->values.push_back(this->parseNumberValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeVariable) {
			argument->values.push_back(this->parseVariableValue(tokens));
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeComma) {
			tokens.nextToken();
			function->arguments.push_back(argument);
			argument = new Argument();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeParenthesisClose) {
			function->arguments.push_back(argument);
			argument = nullptr;
			break;
		}

		assert(false);
	}

	return function;
}

}
}
