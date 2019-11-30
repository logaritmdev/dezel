#import <XCTest/XCTest.h>
#include "Display.h"
#include "DisplayNode.h"
#include "PropertyRef.h"
#include "Tokenizer.h"
#include "TokenizerStream.h"
#include "Property.h"
#include "Value.h"
#include "StringValue.h"
#include "NumberValue.h"
#include "BooleanValue.h"
#include "Stylesheet.h"
#include "Parser.h"
#include "ParseException.h"
#include "Matcher.h"
#include "Matches.h"
#include "Match.h"

#include <string>

using std::string;
using std::exception;

using namespace Dezel;
using namespace Dezel::Style;

@interface StylePropertyTest : XCTestCase

@end

@implementation StylePropertyTest

- (void)setUp {

}

- (void)tearDown {

}

- (void)testPropertyInsertion {

	try {

		PropertyList properties;

		auto prop1 = new Property("prop1");
		prop1->appendValue(new StringValue("value1"));

		auto prop2 = new Property("prop2");
		prop2->appendValue(new StringValue("value2"));

		auto prop3 = new Property("prop3");
		prop3->appendValue(new StringValue("value3"));

		auto prop4 = new Property("prop4");
		prop4->appendValue(new StringValue("value4"));

		properties.add(prop1);
		properties.add(prop2);
		properties.add(prop3);
		properties.add(prop4);

		XCTAssertEqual(properties.size(), 4);
		XCTAssertEqual(properties.get(0)->getName(), "prop1");
		XCTAssertEqual(properties.get(1)->getName(), "prop2");
		XCTAssertEqual(properties.get(2)->getName(), "prop3");
		XCTAssertEqual(properties.get(3)->getName(), "prop4");

		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(0)->getValues().at(0))->getValue(), "value1");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(1)->getValues().at(0))->getValue(), "value2");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(2)->getValues().at(0))->getValue(), "value3");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(3)->getValues().at(0))->getValue(), "value4");

		XCTAssertEqual(properties.get("prop1")->getName(), "prop1");
		XCTAssertEqual(properties.get("prop2")->getName(), "prop2");
		XCTAssertEqual(properties.get("prop3")->getName(), "prop3");
		XCTAssertEqual(properties.get("prop4")->getName(), "prop4");

		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get("prop1")->getValues().at(0))->getValue(), "value1");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get("prop2")->getValues().at(0))->getValue(), "value2");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get("prop3")->getValues().at(0))->getValue(), "value3");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get("prop4")->getValues().at(0))->getValue(), "value4");

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testPropertyInsertionWithExistingProperty {

	try {

		PropertyList properties;

		auto prop1 = new Property("prop1");
		prop1->appendValue(new StringValue("value1"));

		auto prop2 = new Property("prop2");
		prop2->appendValue(new StringValue("value2"));

		auto prop3 = new Property("prop3");
		prop3->appendValue(new StringValue("value3"));

		auto prop4 = new Property("prop4");
		prop4->appendValue(new StringValue("value4"));

		properties.add(prop1);
		properties.add(prop2);
		properties.add(prop3);
		properties.add(prop4);

		auto newProp3 = new Property("prop3");
		newProp3->appendValue(new StringValue("super-value3"));

		properties.add(newProp3);

		XCTAssertEqual(properties.size(), 4);
		XCTAssertEqual(properties.get(0)->getName(), "prop1");
		XCTAssertEqual(properties.get(1)->getName(), "prop2");
		XCTAssertEqual(properties.get(2)->getName(), "prop4");
		XCTAssertEqual(properties.get(3)->getName(), "prop3");

		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(0)->getValues().at(0))->getValue(), "value1");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(1)->getValues().at(0))->getValue(), "value2");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(2)->getValues().at(0))->getValue(), "value4");
		
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(3)->getValues().at(0))->getValue(), "super-value3");

		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get("prop1")->getValues().at(0))->getValue(), "value1");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get("prop2")->getValues().at(0))->getValue(), "value2");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get("prop4")->getValues().at(0))->getValue(), "value4");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get("prop3")->getValues().at(0))->getValue(), "super-value3");

		auto newProp2 = new Property("prop2");
		newProp2->appendValue(new StringValue("super-value2"));

		properties.add(newProp2);

		XCTAssertEqual(properties.size(), 4);
		XCTAssertEqual(properties.get(0)->getName(), "prop1");
		XCTAssertEqual(properties.get(1)->getName(), "prop4");
		XCTAssertEqual(properties.get(2)->getName(), "prop3");
		XCTAssertEqual(properties.get(3)->getName(), "prop2");

		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(0)->getValues().at(0))->getValue(), "value1");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(1)->getValues().at(0))->getValue(), "value4");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(2)->getValues().at(0))->getValue(), "super-value3");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(3)->getValues().at(0))->getValue(), "super-value2");

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testPropertyMerging {

	try {

		PropertyList properties;

		auto prop1 = new Property("prop1");
		prop1->appendValue(new StringValue("value1"));

		auto prop2 = new Property("prop2");
		prop2->appendValue(new StringValue("value2"));

		auto prop3 = new Property("prop3");
		prop3->appendValue(new StringValue("value3"));

		auto prop4 = new Property("prop4");
		prop4->appendValue(new StringValue("value4"));

		properties.add(prop1);
		properties.add(prop2);
		properties.add(prop3);
		properties.add(prop4);

		PropertyList merge;

		auto newProp2 = new Property("prop2");
		auto newProp3 = new Property("prop3");
		newProp2->appendValue(new StringValue("super-value2"));
		newProp3->appendValue(new StringValue("super-value3"));

		merge.add(newProp2);
		merge.add(newProp3);

		properties.merge(merge);

		XCTAssertEqual(properties.size(), 4);
		XCTAssertEqual(properties.get(0)->getName(), "prop1");
		XCTAssertEqual(properties.get(1)->getName(), "prop4");
		XCTAssertEqual(properties.get(2)->getName(), "prop2");
		XCTAssertEqual(properties.get(3)->getName(), "prop3");

		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(0)->getValues().at(0))->getValue(), "value1");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(1)->getValues().at(0))->getValue(), "value4");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(2)->getValues().at(0))->getValue(), "super-value2");
		XCTAssertEqual(reinterpret_cast<StringValue*>(properties.get(3)->getValues().at(0))->getValue(), "super-value3");

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

@end
