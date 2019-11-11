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
#include "Match.h"

#include <string>

using std::string;
using std::exception;

using namespace Dezel;
using namespace Dezel::Style;

@interface MatcherTest : XCTestCase {
	Display* display;
	DisplayNode* window;
	DisplayNode* screen;
}

- (Stylesheet*)parse:(string)source;

@end

@implementation MatcherTest

- (Stylesheet*)parse:(string)source {

	auto stylesheet = new Stylesheet();

	TokenizerStream stream(source);
	Tokenizer tokenizer(stream);
	Parser parser(stylesheet, &tokenizer);

	return stylesheet;
}

- (void)setUp {

	display = new Display();
	display->setViewportWidth(320);
	display->setViewportHeight(480);

	window = new DisplayNode(display, "Window View");
	screen = new DisplayNode(display, "Screen Component View");

	display->setWindow(window);
}

- (void)tearDown {
	delete display;
	delete window;
	delete screen;
}

- (void)testSimpleTypeMatch
{
	try {

		string source = R""""(

			Button {
				property: value;
			}

		)"""";

		vector<Match> matches;

		auto stylesheet = [self parse:source];

		auto button = new DisplayNode(display, "Button Component View");

		window->appendChild(screen);
		screen->appendChild(button);

		Matcher matcher;

		matches.clear();
		matcher.match(button, matches, stylesheet->getRuleDescriptors());

		XCTAssertEqual(matches.size(), 1);

		XCTAssertEqual(matches[0].getDescriptor()->getSelector()->getTail()->getType(), "Button");

		XCTAssertEqual(matches[0].importance.type, 3);
		XCTAssertEqual(matches[0].importance.name, 0);
		XCTAssertEqual(matches[0].importance.style, 0);
		XCTAssertEqual(matches[0].importance.state, 0);

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testInheritedTypeMatch
{
	try {

		string source = R""""(

			Button {
				property: value;
			}

			View {
				property: value;
			}

		)"""";

		vector<Match> matches;

		auto stylesheet = [self parse:source];

		auto button = new DisplayNode(display, "Button Component View");

		window->appendChild(screen);
		screen->appendChild(button);

		Matcher matcher;

		matches.clear();
		matcher.match(button, matches, stylesheet->getRuleDescriptors());

		XCTAssertEqual(matches.size(), 2);

		XCTAssertEqual(matches[0].getDescriptor()->getSelector()->getTail()->getType(), "View");

		XCTAssertEqual(matches[0].importance.type, 1);
		XCTAssertEqual(matches[0].importance.name, 0);
		XCTAssertEqual(matches[0].importance.style, 0);
		XCTAssertEqual(matches[0].importance.state, 0);

		XCTAssertEqual(matches[1].getDescriptor()->getSelector()->getTail()->getType(), "Button");

		XCTAssertEqual(matches[1].importance.type, 3);
		XCTAssertEqual(matches[1].importance.name, 0);
		XCTAssertEqual(matches[1].importance.style, 0);
		XCTAssertEqual(matches[1].importance.state, 0);

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testNestedTypeMatch
{
	try {

		string source = R""""(

			Button {
				property: value;
			}

			View {
				property: value;
			}

			Screen {

				property: value;

				Button {
					property: value;
				}
			}

		)"""";

		vector<Match> matches;

		auto stylesheet = [self parse:source];

		auto button = new DisplayNode(display, "Button Component View");

		window->appendChild(screen);
		screen->appendChild(button);

		Matcher matcher;

		matches.clear();
		matcher.match(button, matches, stylesheet->getRuleDescriptors());

		XCTAssertEqual(matches.size(), 3);

		XCTAssertEqual(matches[0].getDescriptor()->getSelector()->getTail()->getType(), "View");

		XCTAssertEqual(matches[0].importance.type, 1);
		XCTAssertEqual(matches[0].importance.name, 0);
		XCTAssertEqual(matches[0].importance.style, 0);
		XCTAssertEqual(matches[0].importance.state, 0);

		XCTAssertEqual(matches[1].getDescriptor()->getSelector()->getTail()->getType(), "Button");

		XCTAssertEqual(matches[1].importance.type, 3);
		XCTAssertEqual(matches[1].importance.name, 0);
		XCTAssertEqual(matches[1].importance.style, 0);
		XCTAssertEqual(matches[1].importance.state, 0);

		XCTAssertEqual(matches[2].getDescriptor()->getSelector()->getTail()->getType(), "Button");
		XCTAssertEqual(matches[2].getDescriptor()->getParent()->getSelector()->getTail()->getType(), "Screen");

		XCTAssertEqual(matches[2].importance.type, 6);
		XCTAssertEqual(matches[2].importance.name, 0);
		XCTAssertEqual(matches[2].importance.style, 0);
		XCTAssertEqual(matches[2].importance.state, 0);

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testNestedOpaqueTypeMatch
{
	try {

		string source = R""""(

			Button {
				property: value;
			}

			View {
				property: value;
			}

			Screen {

				property: value;

				Button {
					property: value;
				}

				Slider {
					Button {
						property: value;
					}
				}
			}

		)"""";

		vector<Match> matches;

		auto stylesheet = [self parse:source];

		auto button = new DisplayNode(display, "Button Component View");
		auto slider = new DisplayNode(display, "Slider Component View");
		auto handle = new DisplayNode(display, "Button Component View");

		slider->setOpaque();

		window->appendChild(screen);
		screen->appendChild(button);
		screen->appendChild(slider);
		slider->appendChild(handle);

		Matcher matcher;

		matches.clear();
		matcher.match(button, matches, stylesheet->getRuleDescriptors());

		XCTAssertEqual(matches.size(), 3);

		XCTAssertEqual(matches[0].getDescriptor()->getSelector()->getTail()->getType(), "View");

		XCTAssertEqual(matches[0].importance.type, 1);
		XCTAssertEqual(matches[0].importance.name, 0);
		XCTAssertEqual(matches[0].importance.style, 0);
		XCTAssertEqual(matches[0].importance.state, 0);

		XCTAssertEqual(matches[1].getDescriptor()->getSelector()->getTail()->getType(), "Button");

		XCTAssertEqual(matches[1].importance.type, 3);
		XCTAssertEqual(matches[1].importance.name, 0);
		XCTAssertEqual(matches[1].importance.style, 0);
		XCTAssertEqual(matches[1].importance.state, 0);

		XCTAssertEqual(matches[2].getDescriptor()->getSelector()->getTail()->getType(), "Button");
		XCTAssertEqual(matches[2].getDescriptor()->getParent()->getSelector()->getTail()->getType(), "Screen");

		XCTAssertEqual(matches[2].importance.type, 6);
		XCTAssertEqual(matches[2].importance.name, 0);
		XCTAssertEqual(matches[2].importance.style, 0);
		XCTAssertEqual(matches[2].importance.state, 0);

		matches.clear();
		matcher.match(handle, matches, stylesheet->getRuleDescriptors());

		XCTAssertEqual(matches.size(), 3);

		XCTAssertEqual(matches[0].getDescriptor()->getSelector()->getTail()->getType(), "View");

		XCTAssertEqual(matches[0].importance.type, 1);
		XCTAssertEqual(matches[0].importance.name, 0);
		XCTAssertEqual(matches[0].importance.style, 0);
		XCTAssertEqual(matches[0].importance.state, 0);

		XCTAssertEqual(matches[1].getDescriptor()->getSelector()->getTail()->getType(), "Button");
		XCTAssertEqual(matches[1].getDescriptor()->getParent(), nullptr);

		XCTAssertEqual(matches[1].importance.type, 3);
		XCTAssertEqual(matches[1].importance.name, 0);
		XCTAssertEqual(matches[1].importance.style, 0);
		XCTAssertEqual(matches[1].importance.state, 0);

		XCTAssertEqual(matches[2].getDescriptor()->getSelector()->getTail()->getType(), "Button");
		XCTAssertEqual(matches[2].getDescriptor()->getParent()->getSelector()->getTail()->getType(), "Slider");
		XCTAssertEqual(matches[2].getDescriptor()->getParent()->getParent()->getSelector()->getTail()->getType(), "Screen");

		XCTAssertEqual(matches[2].importance.type, 9);
		XCTAssertEqual(matches[2].importance.name, 0);
		XCTAssertEqual(matches[2].importance.style, 0);
		XCTAssertEqual(matches[2].importance.state, 0);

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testNameMatch {

	try {

		string source = R""""(

			Button {

				#label {
					property: value;
				}

				#image {
					property: value;
				}
			}

		)"""";

		auto stylesheet = [self parse:source];

		vector<Match> matches;

		auto button = new DisplayNode(display, "Button Component View");
		auto label  = new DisplayNode(display, "Label TextView");
		auto image  = new DisplayNode(display, "Image ImageView");

		label->setName("label");
		image->setName("image");

		window->appendChild(screen);
		screen->appendChild(button);
		button->appendChild(label);
		button->appendChild(image);

		Matcher matcher;

		matches.clear();
		matcher.match(label, matches, stylesheet->getRuleDescriptors());

		XCTAssertEqual(matches.size(), 1);

		XCTAssertEqual(matches[0].getDescriptor()->getSelector()->getTail()->getName(), "label");

		XCTAssertEqual(matches[0].importance.type, 4);
		XCTAssertEqual(matches[0].importance.name, 1);
		XCTAssertEqual(matches[0].importance.style, 0);
		XCTAssertEqual(matches[0].importance.state, 0);

		matches.clear();
		matcher.match(image, matches, stylesheet->getRuleDescriptors());

		XCTAssertEqual(matches.size(), 1);

		XCTAssertEqual(matches[0].getDescriptor()->getSelector()->getTail()->getName(), "image");

		XCTAssertEqual(matches[0].importance.type, 4);
		XCTAssertEqual(matches[0].importance.name, 1);
		XCTAssertEqual(matches[0].importance.style, 0);
		XCTAssertEqual(matches[0].importance.state, 0);

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testStyleMatch {

	try {

		string source = R""""(

			Button {

				#label {
					property: default-value;
				}

				#image {
					property: default-value;
				}

				@style styled {

					#label {
						property: super-value;
					}

					#image {
						property: super-value;
					}
				}
			}

		)"""";

		auto stylesheet = [self parse:source];

		vector<Match> matches;

		auto button = new DisplayNode(display, "Button Component View");
		auto label  = new DisplayNode(display, "Label TextView");
		auto image  = new DisplayNode(display, "Image ImageView");

		button->appendStyle("styled");

		label->setName("label");
		image->setName("image");

		window->appendChild(screen);
		screen->appendChild(button);
		button->appendChild(label);
		button->appendChild(image);

		Matcher matcher;

		matches.clear();
		matcher.match(label, matches, stylesheet->getRuleDescriptors());

		XCTAssertEqual(matches.size(), 2);

		XCTAssertEqual(matches[0].getDescriptor()->getSelector()->getTail()->getName(), "label");

		XCTAssertEqual(matches[0].importance.type, 4);
		XCTAssertEqual(matches[0].importance.name, 1);
		XCTAssertEqual(matches[0].importance.style, 0);
		XCTAssertEqual(matches[0].importance.state, 0);

		XCTAssertEqual(matches[1].getDescriptor()->getSelector()->getTail()->getName(), "label");
		XCTAssertEqual(matches[1].getDescriptor()->getSelector()->getParent()->getTail()->getStyle(), "styled");

		XCTAssertEqual(matches[1].importance.type, 5);
		XCTAssertEqual(matches[1].importance.name, 1);
		XCTAssertEqual(matches[1].importance.style, 1);
		XCTAssertEqual(matches[1].importance.state, 0);

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testStateMatch {

	try {

		string source = R""""(

			Button {

				#label {
					property: default-value;
				}

				#image {
					property: default-value;
				}

				@state pressed {

					#label {
						property: super-value;
					}

					#image {
						property: super-value;
					}
				}
			}

		)"""";

		auto stylesheet = [self parse:source];

		vector<Match> matches;

		auto button = new DisplayNode(display, "Button Component View");
		auto label  = new DisplayNode(display, "Label TextView");
		auto image  = new DisplayNode(display, "Image ImageView");

		button->appendState("pressed");

		label->setName("label");
		image->setName("image");

		window->appendChild(screen);
		screen->appendChild(button);
		button->appendChild(label);
		button->appendChild(image);

		Matcher matcher;

		matches.clear();
		matcher.match(label, matches, stylesheet->getRuleDescriptors());

		XCTAssertEqual(matches.size(), 2);

		XCTAssertEqual(matches[1].getDescriptor()->getSelector()->getTail()->getName(), "label");
		XCTAssertEqual(matches[1].getDescriptor()->getSelector()->getParent()->getTail()->getState(), "pressed");

		XCTAssertEqual(matches[1].importance.type, 5);
		XCTAssertEqual(matches[1].importance.name, 1);
		XCTAssertEqual(matches[1].importance.style, 0);
		XCTAssertEqual(matches[1].importance.state, 1);

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

- (void)testNestedStyleAndStateMatch {

	try {

		string source = R""""(

			Button {

				#label {
					property: default-value;
				}

				#image {
					property: default-value;
				}

				@state pressed {

					#label {
						property: pressed-value;
					}

					#image {
						property: pressed-value;
					}
				}

				@style styled {

					@state pressed {

						#label {
							property: styled-pressed-value;
						}

						#image {
							property: styled-pressed-value;
						}
					}
				}
			}

		)"""";

		auto stylesheet = [self parse:source];

		vector<Match> matches;

		auto button = new DisplayNode(display, "Button Component View");
		auto label  = new DisplayNode(display, "Label TextView");
		auto image  = new DisplayNode(display, "Image ImageView");

		button->appendState("pressed");
		button->appendStyle("styled");

		label->setName("label");
		image->setName("image");

		window->appendChild(screen);
		screen->appendChild(button);
		button->appendChild(label);
		button->appendChild(image);

		Matcher matcher;

		matches.clear();
		matcher.match(label, matches, stylesheet->getRuleDescriptors());

		XCTAssertEqual(matches.size(), 3);

		XCTAssertEqual(matches[0].importance.type, 4);
		XCTAssertEqual(matches[0].importance.name, 1);
		XCTAssertEqual(matches[0].importance.style, 0);
		XCTAssertEqual(matches[0].importance.state, 0);

	} catch (exception &e) {
		[NSException raise:@"Exception" format: @"%s", e.what()];
	}
}

@end
