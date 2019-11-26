#import <XCTest/XCTest.h>
#include "Display.h"
#include "DisplayNode.h"
#include "Tokenizer.h"
#include "TokenizerStream.h"
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
#include "PropertyRef.h"

#include <string>

using std::string;
using std::exception;

using namespace Dezel;
using namespace Dezel::Style;

static vector<PropertyRef> buttonProperties;
static vector<PropertyRef> labelProperties;
static vector<PropertyRef> imageProperties;

static void buttonUpdateCallback(DisplayNodeRef node, PropertyRef property, const char* name)
{
	buttonProperties.push_back(property);
}

static void labelUpdateCallback(DisplayNodeRef node, PropertyRef property, const char* name)
{
	labelProperties.push_back(property);
}

static void imageUpdateCallback(DisplayNodeRef node, PropertyRef property, const char* name)
{
	imageProperties.push_back(property);
}

@interface StyleResolverTest : XCTestCase {
	Display* display;
	DisplayNode* window;
	DisplayNode* screen;
}

- (Stylesheet*)parse:(string)source;

@end

@implementation StyleResolverTest

- (Stylesheet*)parse:(string)source {
	auto stylesheet = new Stylesheet();
	Parser::parse(stylesheet, source);
	return stylesheet;
}

- (void)setUp {

	display = new Display();
	display->setViewportWidth(320);
	display->setViewportHeight(480);

	window = new DisplayNode(display, "Window View");
	screen = new DisplayNode(display, "Screen Component View");

	display->setWindow(window);

	buttonProperties.clear();
	labelProperties.clear();
	imageProperties.clear();
}

- (void)tearDown {
	delete display;
	delete window;
	delete screen;
}

- (void)testTypeResolution {

	try {

		string source = R""""(

			Button {
				button-prop-1: value1;
				button-prop-2: value2;
			}

		)"""";

		auto stylesheet = [self parse:source];

		auto button = new DisplayNode(display, "Button Component View");

		window->appendChild(screen);
		screen->appendChild(button);

		display->setStylesheet(stylesheet);

		button->setUpdateCallback(buttonUpdateCallback);
		button->resolve();

		XCTAssertEqual(buttonProperties.size(), 2);

		if (buttonProperties.size() == 2) {
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[0]), "buttonProp1"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[1]), "buttonProp2"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[0], 0), "value1"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[1], 0), "value2"), 0);
		}

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testStyleResolution {

	try {

		string source = R""""(

			Button {

				button-prop-1: value1;
				button-prop-2: value2;

				@style a-style {
					button-prop-2: super-value-2;
					button-prop-3: value3;
					button-prop-4: value4;
				}
			}

		)"""";

		auto stylesheet = [self parse:source];

		vector<Match> matches;

		auto button = new DisplayNode(display, "Button Component View");

		window->appendChild(screen);
		screen->appendChild(button);

		display->setStylesheet(stylesheet);

		button->setUpdateCallback(buttonUpdateCallback);
		button->resolve();

		XCTAssertEqual(buttonProperties.size(), 2);

		if (buttonProperties.size() == 2) {
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[0]), "buttonProp1"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[1]), "buttonProp2"), 0);
		}

		buttonProperties.clear();

		button->appendStyle("a-style");
		button->resolve();

		XCTAssertEqual(buttonProperties.size(), 3);

		if (buttonProperties.size() == 3) {
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[0]), "buttonProp2"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[1]), "buttonProp3"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[2]), "buttonProp4"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[0], 0), "super-value-2"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[1], 0), "value3"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[2], 0), "value4"), 0);
		}

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testStateResolution {

	try {

		string source = R""""(

			Button {

				button-prop-1: value1;
				button-prop-2: value2;

				@state a-state {
					button-prop-2: super-value-2;
					button-prop-3: value3;
					button-prop-4: value4;
				}
			}

		)"""";

		auto stylesheet = [self parse:source];

		vector<Match> matches;

		auto button = new DisplayNode(display, "Button Component View");

		window->appendChild(screen);
		screen->appendChild(button);

		display->setStylesheet(stylesheet);

		button->setUpdateCallback(buttonUpdateCallback);
		button->resolve();

		XCTAssertEqual(buttonProperties.size(), 2);

		if (buttonProperties.size() == 2) {
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[0]), "buttonProp1"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[1]), "buttonProp2"), 0);
		}

		buttonProperties.clear();

		button->appendState("a-state");
		button->resolve();

		XCTAssertEqual(buttonProperties.size(), 3);

		if (buttonProperties.size() == 3) {
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[0]), "buttonProp2"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[1]), "buttonProp3"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[2]), "buttonProp4"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[0], 0), "super-value-2"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[1], 0), "value3"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[2], 0), "value4"), 0);
		}

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testNestedStateResolution {

	try {

		string source = R""""(

			Button {

				button-prop-1: value1;
				button-prop-2: value2;

				#label {
					label-prop-1: value1;
					label-prop-2: value2;
				}

				#image {
					image-prop-1: value1;
					image-prop-2: value2;
					image-prop-3: value3;
				}

				@state a-state {

					button-prop-2: super-value2;
					button-prop-3: super-value3;

					#label {
						label-prop-1: super-value1;
						label-prop-2: super-value2;
					}

					#image {
						image-prop-2: super-value2;
					}
				}
			}

		)"""";

		auto stylesheet = [self parse:source];

		vector<Match> matches;

		auto button = new DisplayNode(display, "Button Component View");
		auto label = new DisplayNode(display, "Label TextView");
		auto image = new DisplayNode(display, "Image ImageView");

		label->setName("label");
		image->setName("image");

		window->appendChild(screen);
		screen->appendChild(button);
		button->appendChild(label);
		button->appendChild(image);

		display->setStylesheet(stylesheet);

		button->setUpdateCallback(buttonUpdateCallback);
		label->setUpdateCallback(labelUpdateCallback);
		image->setUpdateCallback(imageUpdateCallback);

		button->resolve();

		XCTAssertEqual(buttonProperties.size(), 2);

		if (buttonProperties.size() == 2) {
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[0]), "buttonProp1"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[1]), "buttonProp2"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[0], 0), "value1"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[1], 0), "value2"), 0);
		}

		XCTAssertEqual(labelProperties.size(), 2);

		if (labelProperties.size() == 2) {
			XCTAssertEqual(strcmp(PropertyGetName(labelProperties[0]), "labelProp1"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(labelProperties[1]), "labelProp2"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(labelProperties[0], 0), "value1"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(labelProperties[1], 0), "value2"), 0);
		}

		XCTAssertEqual(imageProperties.size(), 3);

		if (imageProperties.size() == 3) {
			XCTAssertEqual(strcmp(PropertyGetName(imageProperties[0]), "imageProp1"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(imageProperties[1]), "imageProp2"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(imageProperties[2]), "imageProp3"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(imageProperties[0], 0), "value1"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(imageProperties[1], 0), "value2"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(imageProperties[2], 0), "value3"), 0);
		}

		buttonProperties.clear();
		labelProperties.clear();
		imageProperties.clear();

		button->appendState("a-state");
		button->resolve();

		XCTAssertEqual(buttonProperties.size(), 2);

		if (buttonProperties.size() == 2) {
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[0]), "buttonProp2"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(buttonProperties[1]), "buttonProp3"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[0], 0), "super-value2"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(buttonProperties[1], 0), "super-value3"), 0);
		}

		XCTAssertEqual(labelProperties.size(), 2);

		if (labelProperties.size() == 2) {
			XCTAssertEqual(strcmp(PropertyGetName(labelProperties[0]), "labelProp1"), 0);
			XCTAssertEqual(strcmp(PropertyGetName(labelProperties[1]), "labelProp2"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(labelProperties[0], 0), "super-value1"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(labelProperties[1], 0), "super-value2"), 0);
		}

		XCTAssertEqual(imageProperties.size(), 1);

		if (imageProperties.size() == 1) {
			XCTAssertEqual(strcmp(PropertyGetName(imageProperties[0]), "imageProp2"), 0);
			XCTAssertEqual(strcmp(PropertyGetValueAsString(imageProperties[0], 0), "super-value2"), 0);
		}

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

@end
