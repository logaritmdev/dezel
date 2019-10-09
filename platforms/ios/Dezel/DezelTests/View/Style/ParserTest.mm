#import <XCTest/XCTest.h>

#include "Tokenizer.h"
#include "TokenizerStream.h"
#include "Value.h"
#include "StringValue.h"
#include "NumberValue.h"
#include "BooleanValue.h"
#include "Stylesheet.h"
#include "Parser.h"
#include "ParseException.h"

#include <string>

using std::string;
using namespace Dezel::Style;

@interface ParserTest : XCTestCase {
	Stylesheet* stylesheet;
}

@end

@implementation ParserTest

- (void)setUp {
	stylesheet = new Stylesheet();
}

- (void)tearDown {
    delete stylesheet;
}

- (void)testComments {

	string source = R""""(

		/*
			Comment #1
		*/

		// Comment #2

	)"""";

	try {

		TokenizerStream stream(source);
		Tokenizer tokenizer(stream);
		Parser parser(stylesheet, &tokenizer);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	XCTAssertEqual(stylesheet->getRulesets().size(), 0);
}

- (void)testVariable {

	string source = R""""(
		$variable1 : 12px solid color "string";
		$variable2: 12px solid color "string";
		$variable-3 : 12px solid color "string"
		$variable-4: 12px solid color "string"
	)"""";

	try {

		TokenizerStream stream(source);
		Tokenizer tokenizer(stream);
		Parser parser(stylesheet, &tokenizer);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto variables = stylesheet->getVariables();

	XCTAssertEqual(variables.size(), 4);

	auto values = variables["variable1"]->getValues();

	XCTAssertEqual(dynamic_cast<NumberValue*>(values[0])->getType(), kValueTypeNumber);
	XCTAssertEqual(dynamic_cast<NumberValue*>(values[0])->getUnit(), kValueUnitPX);

	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getValue(), "solid");

	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getValue(), "color");

	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getValue(), "string");

	values = variables["variable2"]->getValues();

	XCTAssertEqual(dynamic_cast<NumberValue*>(values[0])->getType(), kValueTypeNumber);
	XCTAssertEqual(dynamic_cast<NumberValue*>(values[0])->getUnit(), kValueUnitPX);

	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getValue(), "solid");

	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getValue(), "color");

	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getValue(), "string");

	values = variables["variable-3"]->getValues();

	XCTAssertEqual(dynamic_cast<NumberValue*>(values[0])->getType(), kValueTypeNumber);
	XCTAssertEqual(dynamic_cast<NumberValue*>(values[0])->getUnit(), kValueUnitPX);

	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getValue(), "solid");

	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getValue(), "color");

	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getValue(), "string");

	values = variables["variable-4"]->getValues();

	XCTAssertEqual(dynamic_cast<NumberValue*>(values[0])->getType(), kValueTypeNumber);
	XCTAssertEqual(dynamic_cast<NumberValue*>(values[0])->getUnit(), kValueUnitPX);

	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[1])->getValue(), "solid");

	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[2])->getValue(), "color");

	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getUnit(), kValueUnitNone);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[3])->getValue(), "string");
}

-(void)testRuleset {

	string input = R""""(

	TypeDeclaration {

		prop-1: value1;
		prop-2: value2;
		prop-3: value3;

		prop-4: function(param1, param2, param3);

		#id-child-ruleset {
			prop-1: value1;
			prop-2: value2;
		}

		.class-child-ruleset {
			prop-1: value1;
			prop-2: value2;
		}

		:state-child-ruleset {
			prop-1: value1;
			prop-2: value2;
		}

		&:state-selector {
			.state-selector-ruleset {
				prop-1: value1;
				prop-2: value2;
			}
		}

	}
	)"""";

	try {

		TokenizerStream stream(input);
		Tokenizer tokenizer(stream);
		Parser parser(stylesheet, &tokenizer);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	XCTAssertEqual(stylesheet->getRulesets().size(), 1);

	auto ruleset = stylesheet->getRulesets().front();

	auto rules = ruleset->getRules();
	auto props = ruleset->getProperties();

	XCTAssertEqual(rules.size(), 1);
	XCTAssertEqual(props.size(), 4);

	XCTAssertEqual(rules.at(0)->getHead()->getType(), "TypeDeclaration");

	auto values = props.get(0)->getValues();

	XCTAssertEqual(props.get(0)->getName(), "prop-1");
	XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getValue(), "value1");

	values = props.get(1)->getValues();

	XCTAssertEqual(props.get(1)->getName(), "prop-2");
	XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getValue(), "value2");

	values = props.get(2)->getValues();

	XCTAssertEqual(props.get(2)->getName(), "prop-3");
	XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getType(), kValueTypeString);
	XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getValue(), "value3");

	values = props.get(3)->getValues();

	XCTAssertEqual(props.get(3)->getName(), "prop-4");
	XCTAssertEqual(dynamic_cast<FunctionValue*>(values[0])->getType(), kValueTypeFunction);
	XCTAssertEqual(dynamic_cast<FunctionValue*>(values[0])->getName(), "function");

	auto arguments = dynamic_cast<FunctionValue*>(values[0])->getArguments();

	XCTAssertEqual(arguments.size(), 3);

	XCTAssertEqual(dynamic_cast<StringValue*>(arguments[0]->getValues().at(0))->getValue(), "param1");
	XCTAssertEqual(dynamic_cast<StringValue*>(arguments[1]->getValues().at(0))->getValue(), "param2");
	XCTAssertEqual(dynamic_cast<StringValue*>(arguments[2]->getValues().at(0))->getValue(), "param3");

	auto children = ruleset->getChildren();

	XCTAssertEqual(children.size(), 4);

	auto child = children[0];

	XCTAssertEqual(child->getProperties().size(), 2);
	XCTAssertEqual(child->getProperties().get(0)->getName(), "prop-1");
	XCTAssertEqual(child->getProperties().get(0)->getValues().at(0)->getType(), kValueTypeString);
	XCTAssertEqual(child->getProperties().get(1)->getName(), "prop-2");
	XCTAssertEqual(child->getProperties().get(1)->getValues().at(0)->getType(), kValueTypeString);

	child = children[3];

	XCTAssertEqual(child->getRules().at(0)->getHead()->getName(), "");
	XCTAssertEqual(child->getRules().at(0)->getHead()->getType(), "");
	XCTAssertEqual(child->getRules().at(0)->getHead()->getCombinator(), kCombinatorParent);
	XCTAssertEqual(child->getRules().at(0)->getHead()->getStyles().size(), 0);
	XCTAssertEqual(child->getRules().at(0)->getHead()->getStates().size(), 1);

	auto state = std::next(child->getRules().at(0)->getHead()->getStates().begin(), 0);

	XCTAssertEqual(*state, "state-selector");
}

@end
