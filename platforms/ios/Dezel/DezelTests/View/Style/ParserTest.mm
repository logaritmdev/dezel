#import <XCTest/XCTest.h>

#include "Tokenizer.h"
#include "TokenizerStream.h"
#include "Stylesheet.h"
#include "Parser.h"

#include <string>

using std::string;
using Dezel::Style::Tokenizer;
using Dezel::Style::TokenizerStream;
using Dezel::Style::Stylesheet;
using Dezel::Style::Parser;

@interface ParserTest : XCTestCase

@end

@implementation ParserTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testParsing {

	string input = R""""(

	$var: test wat "dasda" 1px;

	NavigationBarButton,
	SegmentedBarButton {

		content-orientation: horizontal
		content-disposition: center
		content-arrangement: center
		height: 30px;
		padding-left: 12px;
		padding-right: 12px;
		width: wrap;

		some-value: max(2, 14px $test, 4)

		.image {
			height: wrap;
			width: wrap;
		}

		& .patate {
			height: wrap;
			width: wrap;
		}

		&:pressed,
		&:selected {

			.image {
				opacity: 0.5;
			}

			.label {
				opacity: 0.5;
			}
		}

	}
	)"""";

	TokenizerStream stream(input);
	Tokenizer tokenizer(stream);
	Stylesheet* stylesheet = new Stylesheet();
	Parser parser(stylesheet, &tokenizer);
}

/*		& .potato {

	.image {
		opacity: 0.5;
	}

	.label {
		opacity: 0.5;
	}
}

&:pressed {

	.image {
		opacity: 0.5;
	}

	.label {
		opacity: 0.5;
	}
}*/

@end
