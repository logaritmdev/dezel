#import <XCTest/XCTest.h>

#include "Stylesheet.h"
#include "Descriptor.h"
#include "Selector.h"
#include "Fragment.h"
#include "Importance.h"
#include "Tokenizer.h"
#include "TokenizerStream.h"
#include "Parser.h"
#include "ParseException.h"

using namespace Dezel;
using namespace Dezel::Style;

@interface StylesheetTest : XCTestCase
- (Stylesheet*)parse:(string)source;
@end

@implementation StylesheetTest

- (Stylesheet*)parse:(string)source {

	auto stylesheet = new Stylesheet();

	try {

		TokenizerStream stream(source);
		Tokenizer tokenizer(stream);
		Parser parser(stylesheet, &tokenizer);

	} catch (ParseException &e) {
		[NSException raise:@"ParseException" format: @"%s", e.what()];
	}

	return stylesheet;
}

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testParser {

	string source = R""""(

		Window {
			background-color: white;
		}

		Screen {

			prop1: value;

			Button {

				prop2: value;

				#label {
					prop3: value;
				}

				@style the-style {

					prop5: value;

					@state the-state {
						prop6: value;
					}
				}

				@state the-state {
					prop4: value;
				}
			}
		}

		Nested Type {
			prop7: value;
		}

	)"""";

	auto descriptors = [self parse:source]->getRootDescriptors();

	// TODO
	// Test properties
	// Test weights

	XCTAssertEqual(descriptors.size(), 3);

	// Window

	auto window = descriptors[0];

	XCTAssertEqual(window->getSelector()->getHead(), window->getSelector()->getTail());
	XCTAssertEqual(window->getSelector()->getHead()->getType(), "Window");
	XCTAssertEqual(window->getSelector()->getHead()->getName(), "");
	XCTAssertEqual(window->getSelector()->getHead()->getState(), "");
	XCTAssertEqual(window->getSelector()->getHead()->getStyle(), "");

	// Screen

	auto screen = descriptors[1];

	XCTAssertEqual(screen->getSelector()->getHead(), screen->getSelector()->getTail());
	XCTAssertEqual(screen->getSelector()->getHead()->getType(), "Screen");
	XCTAssertEqual(screen->getSelector()->getHead()->getName(), "");
	XCTAssertEqual(screen->getSelector()->getHead()->getState(), "");
	XCTAssertEqual(screen->getSelector()->getHead()->getStyle(), "");

	XCTAssertEqual(screen->getChildDescriptors().size(), 1);

	// Screen -> Button

	auto button = screen->getChildDescriptors().at(0);

	XCTAssertEqual(button->getSelector()->getHead(), button->getSelector()->getTail());
	XCTAssertEqual(button->getSelector()->getHead()->getType(), "Button");
	XCTAssertEqual(button->getSelector()->getHead()->getName(), "");
	XCTAssertEqual(button->getSelector()->getHead()->getState(), "");
	XCTAssertEqual(button->getSelector()->getHead()->getStyle(), "");

	XCTAssertEqual(button->getChildDescriptors().size(), 1);
	XCTAssertEqual(button->getStyleDescriptors().size(), 1);
	XCTAssertEqual(button->getStateDescriptors().size(), 1);

	// Screen -> Button -> #label

	auto label = button->getChildDescriptors().at(0);

	XCTAssertEqual(label->getSelector()->getHead(), label->getSelector()->getTail());
	XCTAssertEqual(label->getSelector()->getHead()->getType(), "");
	XCTAssertEqual(label->getSelector()->getHead()->getName(), "label");
	XCTAssertEqual(label->getSelector()->getHead()->getState(), "");
	XCTAssertEqual(label->getSelector()->getHead()->getStyle(), "");

	auto style = button->getStyleDescriptors().at(0);

	XCTAssertEqual(style->getSelector()->getHead(), style->getSelector()->getTail());
	XCTAssertEqual(style->getSelector()->getHead()->getType(), "");
	XCTAssertEqual(style->getSelector()->getHead()->getName(), "");
	XCTAssertEqual(style->getSelector()->getHead()->getState(), "");
	XCTAssertEqual(style->getSelector()->getHead()->getStyle(), "the-style");

	auto state = button->getStateDescriptors().at(0);

	XCTAssertEqual(state->getSelector()->getHead(), state->getSelector()->getTail());
	XCTAssertEqual(state->getSelector()->getHead()->getType(), "");
	XCTAssertEqual(state->getSelector()->getHead()->getName(), "");
	XCTAssertEqual(state->getSelector()->getHead()->getState(), "the-state");
	XCTAssertEqual(state->getSelector()->getHead()->getStyle(), "");
}

@end
