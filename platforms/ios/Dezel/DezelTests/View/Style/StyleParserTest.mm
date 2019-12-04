#import <XCTest/XCTest.h>

#include "Tokenizer.h"
#include "TokenizerStream.h"
#include "Parser.h"
#include "ParseException.h"
#include "Variable.h"
#include "Value.h"
#include "StringValue.h"
#include "NumberValue.h"
#include "BooleanValue.h"
#include "Stylesheet.h"

#include <string>

using std::string;
using namespace Dezel::Style;

static void test(const Function* function, const vector<Argument*>& arguments, vector<Value*>& result)
{
 	for (auto argument : arguments) {

		for (auto value : argument->getValues()) {

			if (value->getType() == kValueTypeString) {
				result.push_back(new StringValue(dynamic_cast<StringValue*>(value)->getValue()));
				continue;
			}

			if (value->getType() == kValueTypeNumber) {
				result.push_back(new NumberValue(dynamic_cast<NumberValue*>(value)->getValue(), dynamic_cast<NumberValue*>(value)->getUnit()));
				continue;
			}
		}
	}
}

@interface StyleParserTest : XCTestCase {
	Stylesheet* stylesheet;
}

@end

@implementation StyleParserTest

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

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	XCTAssertEqual(stylesheet->getRootDescriptors().size(), 0);
}

- (void)testVariable {

	string source = R""""(
		$variable1 : 12px solid color "string";
		$variable2: 13px solid color "string";
		$variable-3 : 14px solid color "string"
		$variable-4: 15px solid color "string"
	)"""";

	try {

		Parser::parse(stylesheet, source);

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

-(void)testDescriptors {

	string source = R""""(

	TypeDeclaration {

		prop-1: value1;
		prop-2: value2;
		prop-3: value3;

		prop-4: function(param1, param2, param3);

		#id-child-ruleset {
			prop-1: value1;
			prop-2: value2;
		}

		@state state-descriptor {
			prop-1: value1;
			prop-2: value2;
			SomeType {
				prop-1: value1;
				prop-2: value2;
			}
		}

		@style style-descriptor {
			prop-1: value1;
			prop-2: value2;
			SomeType {
				prop-1: value1;
				prop-2: value2;
			}
		}

		.child-style {
			prop-1: value1;
			prop-2: value2;
		}

		:child-state {
			prop-1: value1;
			prop-2: value2;
		}
	}

	OtherType {
	}

	)"""";

	try {

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	XCTAssertEqual(stylesheet->getRootDescriptors().size(), 2);

	auto descriptor = stylesheet->getRootDescriptors().front();

	auto selector = descriptor->getSelector();
	auto properties = descriptor->getProperties();

	XCTAssertEqual(properties.size(), 4);

	XCTAssertEqual(selector->getHead()->getType(), "TypeDeclaration");

	XCTAssertEqual(properties.get(0)->getName(), "prop1");
	XCTAssertEqual(properties.get(1)->getName(), "prop2");
	XCTAssertEqual(properties.get(2)->getName(), "prop3");
	XCTAssertEqual(properties.get(3)->getName(), "prop4");

	auto values = properties.get(0)->getValues();

	XCTAssertEqual(values.size(), 1);

	if (values.size() == 1) {
		XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getType(), kValueTypeString);
		XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getValue(), "value1");
	}

	values = properties.get(1)->getValues();

	XCTAssertEqual(values.size(), 1);

	if (values.size() == 1) {
		XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getType(), kValueTypeString);
		XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getValue(), "value2");
	}

	values = properties.get(2)->getValues();

	XCTAssertEqual(values.size(), 1);

	if (values.size() == 1) {
		XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getType(), kValueTypeString);
		XCTAssertEqual(dynamic_cast<StringValue*>(values[0])->getValue(), "value3");
	}

	values = properties.get(3)->getValues();

	if (values.size() == 1) {
		XCTAssertEqual(dynamic_cast<FunctionValue*>(values[0])->getType(), kValueTypeFunction);
		XCTAssertEqual(dynamic_cast<FunctionValue*>(values[0])->getName(), "function");
	}

	auto arguments = dynamic_cast<FunctionValue*>(values[0])->getArguments();

	XCTAssertEqual(arguments.size(), 3);

	if (arguments.size() == 3) {
		XCTAssertEqual(dynamic_cast<StringValue*>(arguments[0]->getValues().at(0))->getValue(), "param1");
		XCTAssertEqual(dynamic_cast<StringValue*>(arguments[1]->getValues().at(0))->getValue(), "param2");
		XCTAssertEqual(dynamic_cast<StringValue*>(arguments[2]->getValues().at(0))->getValue(), "param3");
	}

	auto children = descriptor->getChildDescriptors();

	XCTAssertEqual(children.size(), 5);

	auto child = children[0];

	XCTAssertEqual(child->getSelector()->getHead()->getName(), "id-child-ruleset");
	XCTAssertEqual(child->getProperties().size(), 2);
	XCTAssertEqual(child->getProperties().get(0)->getName(), "prop1");
	XCTAssertEqual(child->getProperties().get(0)->getValues().at(0)->getType(), kValueTypeString);
	XCTAssertEqual(child->getProperties().get(1)->getName(), "prop2");
	XCTAssertEqual(child->getProperties().get(1)->getValues().at(0)->getType(), kValueTypeString);

	child = children[3];

	XCTAssertEqual(child->getSelector()->getHead()->getStyles().at(0), "child-style");
	XCTAssertEqual(child->getProperties().size(), 2);
	XCTAssertEqual(child->getProperties().get(0)->getName(), "prop1");
	XCTAssertEqual(child->getProperties().get(0)->getValues().at(0)->getType(), kValueTypeString);
	XCTAssertEqual(child->getProperties().get(1)->getName(), "prop2");
	XCTAssertEqual(child->getProperties().get(1)->getValues().at(0)->getType(), kValueTypeString);

	child = children[4];

	XCTAssertEqual(child->getSelector()->getHead()->getStates().at(0), "child-state");
	XCTAssertEqual(child->getProperties().size(), 2);
	XCTAssertEqual(child->getProperties().get(0)->getName(), "prop1");
	XCTAssertEqual(child->getProperties().get(0)->getValues().at(0)->getType(), kValueTypeString);
	XCTAssertEqual(child->getProperties().get(1)->getName(), "prop2");
	XCTAssertEqual(child->getProperties().get(1)->getValues().at(0)->getType(), kValueTypeString);

	XCTAssertEqual(descriptor->getStateDescriptors().size(), 1);

	auto state = descriptor->getStateDescriptors().at(0);

	XCTAssertEqual(state->getSelector()->getHead()->getStates().at(0), "state-descriptor");
	XCTAssertEqual(state->getProperties().size(), 2);
	XCTAssertEqual(state->getProperties().get(0)->getName(), "prop1");
	XCTAssertEqual(state->getProperties().get(0)->getValues().at(0)->getType(), kValueTypeString);
	XCTAssertEqual(state->getProperties().get(1)->getName(), "prop2");
	XCTAssertEqual(state->getProperties().get(1)->getValues().at(0)->getType(), kValueTypeString);

	auto styleDescriptor = descriptor->getStyleDescriptors().at(0);

	XCTAssertEqual(styleDescriptor->getSelector()->getHead()->getStyles().at(0), "style-descriptor");
	XCTAssertEqual(styleDescriptor->getProperties().size(), 2);
	XCTAssertEqual(styleDescriptor->getProperties().get(0)->getName(), "prop1");
	XCTAssertEqual(styleDescriptor->getProperties().get(0)->getValues().at(0)->getType(), kValueTypeString);
	XCTAssertEqual(styleDescriptor->getProperties().get(1)->getName(), "prop2");
	XCTAssertEqual(styleDescriptor->getProperties().get(1)->getValues().at(0)->getType(), kValueTypeString);
	// TODO test inner

}

-(void)testPropertiesCamelCase {

	string source = R""""(

	TypeDeclaration {
		a-property: value1;
		a-property-with-longer-name: value2;
	}

	)"""";

	try {

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	XCTAssertEqual(stylesheet->getRootDescriptors().size(), 1);

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(properties.size(), 2);

	XCTAssertEqual(properties.get(0)->getName(), "aProperty");
	XCTAssertEqual(properties.get(1)->getName(), "aPropertyWithLongerName");
}

-(void)testStringValue {

	string source = R""""(

	Type {
		property1: value1;
		property2: "value2";
	}

	)"""";

	try {

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(properties.size(), 2);

	XCTAssertEqual(properties.get(0)->getValues().at(0)->getType(), kValueTypeString);
	XCTAssertEqual(properties.get(1)->getValues().at(0)->getType(), kValueTypeString);

	XCTAssertEqual(dynamic_cast<StringValue*>(properties.get(0)->getValues().at(0))->getValue(), "value1");
	XCTAssertEqual(dynamic_cast<StringValue*>(properties.get(1)->getValues().at(0))->getValue(), "value2");
}

-(void)testNumberValue {

	string source = R""""(

	Type {
		property1: 12.5;
		property2: 12;
		property3: 15px;
	}

	)"""";

	try {

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(properties.size(), 3);

	XCTAssertEqual(properties.get(0)->getValues().at(0)->getType(), kValueTypeNumber);
	XCTAssertEqual(properties.get(1)->getValues().at(0)->getType(), kValueTypeNumber);
	XCTAssertEqual(properties.get(2)->getValues().at(0)->getType(), kValueTypeNumber);

	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getValue(), 12.5);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(1)->getValues().at(0))->getValue(), 12.0);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(2)->getValues().at(0))->getValue(), 15.0);
}

-(void)testColorValue {

	string source = R""""(

	Type {
		property1: #000;
		property2: #000000;
		property3: #A00;
		property4: #AAAAAA;
	}

	)"""";

	try {

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(properties.size(), 4);

	XCTAssertEqual(properties.get(0)->getValues().at(0)->getType(), kValueTypeString);
	XCTAssertEqual(properties.get(1)->getValues().at(0)->getType(), kValueTypeString);
	XCTAssertEqual(properties.get(2)->getValues().at(0)->getType(), kValueTypeString);
	XCTAssertEqual(properties.get(3)->getValues().at(0)->getType(), kValueTypeString);

	XCTAssertEqual(dynamic_cast<StringValue*>(properties.get(0)->getValues().at(0))->getValue(), "#000");
	XCTAssertEqual(dynamic_cast<StringValue*>(properties.get(1)->getValues().at(0))->getValue(), "#000000");
	XCTAssertEqual(dynamic_cast<StringValue*>(properties.get(2)->getValues().at(0))->getValue(), "#A00");
	XCTAssertEqual(dynamic_cast<StringValue*>(properties.get(3)->getValues().at(0))->getValue(), "#AAAAAA");
}

-(void)testVariableDefinition {

	try {

		stylesheet->setVariable("some-variable", "10px solid #fff");

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto variable = stylesheet->getVariable("some-variable");

	if (variable) {
		XCTAssertEqual(variable->getValues().size(), 3);
		XCTAssertEqual(dynamic_cast<NumberValue*>(variable->getValues().at(0))->getValue(), 10);
		XCTAssertEqual(dynamic_cast<StringValue*>(variable->getValues().at(1))->getValue(), "solid");
		XCTAssertEqual(dynamic_cast<StringValue*>(variable->getValues().at(2))->getValue(), "#fff");
	} else {
		XCTFail("Variable cannot be null");
	}
}

-(void)testVariables {

	string source = R""""(

	Type {
		property1: $some-variable;
	}

	)"""";

	try {

		stylesheet->setVariable("some-variable", "10px solid #fff");

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(properties.size(), 1);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getValue(), 10);
	XCTAssertEqual(dynamic_cast<StringValue*>(properties.get(0)->getValues().at(1))->getValue(), "solid");
	XCTAssertEqual(dynamic_cast<StringValue*>(properties.get(0)->getValues().at(2))->getValue(), "#fff");
}

-(void)testFunctionCall {

	string source = R""""(

		Type {
			property1: test(2px, 3px);
		}

	)"""";

	try {

		stylesheet->addFunction(new Function("test", test));

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(properties.get(0)->getValues().size(), 2);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getValue(), 2);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(1))->getValue(), 3);
}

-(void)testFunctionCallWithVariables {

	string source = R""""(

	Type {
		property1: test($a, $b);
	}

	)"""";

	try {

		stylesheet->addFunction(new Function("test", test));
		stylesheet->setVariable("a", "2px");
		stylesheet->setVariable("b", "3px");
		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(properties.get(0)->getValues().size(), 2);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getValue(), 2);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(1))->getValue(), 3);
}

-(void)testNestedFunctionCall {

	string source = R""""(

	Type {
		property1: test(2px, test(3px, 10px));
	}

	)"""";

	try {

		stylesheet->addFunction(new Function("test", test));
		stylesheet->setVariable("a", "2px");
		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getValue(), 2);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(1))->getValue(), 3);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(2))->getValue(), 10);
}

-(void)testAddFunction {

	string source = R""""(

	Type {
		property1: add(10px, 5px);
	}

	)"""";

	try {

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getValue(), 15);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getUnit(), kValueUnitPX);
}

-(void)testSubFunction {

	string source = R""""(

	Type {
		property1: sub(10px, 5px);
	}

	)"""";

	try {

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getValue(), 5);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getUnit(), kValueUnitPX);
}

-(void)testMinFunction {

	string source = R""""(

	Type {
		property1: min(10px, 5px);
	}

	)"""";

	try {

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getValue(), 5);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getUnit(), kValueUnitPX);
}

-(void)testMaxFunction {

	string source = R""""(

	Type {
		property1: max(10px, 5px);
	}

	)"""";

	try {

		Parser::parse(stylesheet, source);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	auto properties = stylesheet->getRootDescriptors().front()->getProperties();

	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getValue(), 10);
	XCTAssertEqual(dynamic_cast<NumberValue*>(properties.get(0)->getValues().at(0))->getUnit(), kValueUnitPX);
}

@end
