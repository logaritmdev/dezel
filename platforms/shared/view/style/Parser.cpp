#include "Parser.h"
#include "Token.h"
#include "Tokenizer.h"
#include "TokenizerStream.h"
#include "Ruleset.h"
#include "Rule.h"
#include "Selector.h"
#include "Function.h"

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
		}

		tokens.nextToken();
		tokens.skipSpace();

	} while (tokens.hasNextToken());
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

Variable*
Parser::parseVariable(TokenList& tokens)
{
	return nullptr;
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

			auto function = this->parseFunction(tokens);
			if (function) {
				property->function = function;
			} else {
				assert(false);
			}

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
		return Value::createNull();
	}

	if (equals(tokens.getCurrentTokenName(), "true")) {
		return Value::createBoolean(true);
	}

	if (equals(tokens.getCurrentTokenName(), "false")) {
		return Value::createBoolean(false);
	}

	return this->parseStringValue(tokens);
}

Value*
Parser::parseStringValue(TokenList& tokens)
{
	return Value::createString(tokens.getCurrentTokenName());
}

Value*
Parser::parseNumberValue(TokenList& tokens)
{
	auto value = Value::createNumber(std::stod(tokens.getCurrentTokenName()));

	if (tokens.getCurrentTokenUnit() == "%") {
		value->unit = kValueUnitPC;
	} else if (tokens.getCurrentTokenUnit() == "px") {
		value->unit = kValueUnitPX;
	} else if (tokens.getCurrentTokenUnit() == "vw") {
		value->unit = kValueUnitVW;
	} else if (tokens.getCurrentTokenUnit() == "vh") {
		value->unit = kValueUnitVH;
	} else if (tokens.getCurrentTokenUnit() == "pw") {
		value->unit = kValueUnitPW;
	} else if (tokens.getCurrentTokenUnit() == "ph") {
		value->unit = kValueUnitPH;
	} else if (tokens.getCurrentTokenUnit() == "cw") {
		value->unit = kValueUnitCW;
	} else if (tokens.getCurrentTokenUnit() == "ch") {
		value->unit = kValueUnitCH;
	} else if (tokens.getCurrentTokenUnit() == "deg") {
		value->unit = kValueUnitDeg;
	} else if (tokens.getCurrentTokenUnit() == "rad") {
		value->unit = kValueUnitRad;
	}

	return value;
}

Function*
Parser::parseFunction(TokenList& tokens)
{
	int depth = 0;

	auto function = new Function();

	function->name = tokens.getCurrentTokenName();

	tokens.nextToken();

	while (true) {

		if (tokens.getCurrentTokenType() == kTokenTypeSpace) {
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeComma) {
			tokens.nextToken();
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeIdent) {
			tokens.nextToken();
			// TODO PARSE IDENT
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeString) {
			tokens.nextToken();
			// TODO PARSE IDENT
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeNumber) {
			tokens.nextToken();
			// TODO PARSE IDENT
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeParenthesisOpen) {
			tokens.nextToken();
			depth++;
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeParenthesisClose) {
			tokens.nextToken();
			depth--;
			continue;
		}

		if (tokens.getCurrentTokenType() == kTokenTypeDelimiter ||
			tokens.getCurrentTokenType() == kTokenTypeLinebreak) {
			if (depth != 0) {
				assert(false);
			}

			break;
		}

		assert(false);
	}

	return function;
}

}
}
