#import <XCTest/XCTest.h>

#include "TokenizerStream.h"

#include <string>

using std::string;
using Dezel::Style::TokenizerStream;

static bool isASCII(char c) {
	return !(c & ~0x7F);
}

static bool isAlpha(char c) {
	return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
}

static bool isDigit(char c) {
	return c >= '0' && c <= '9';
}

static bool isNameStart(char c) {
	return isAlpha(c) || c == '_';
}

static bool isAnything(char c) {
	return true;
}

static bool isNothing(char c) {
	return false;
}

@interface TokenizerStreamTest : XCTestCase {
	string input;
}
@end

@implementation TokenizerStreamTest

- (void)setUp {
	input = "ABC def { } 123";;
}

- (void)tearDown {

}

- (void)testRead {
	TokenizerStream stream(input);
	char c = stream.read();
	XCTAssertEqual(c, 'A');
}

- (void)testReadAlpha {
	TokenizerStream stream(input);
	XCTAssertEqual(stream.read<isAlpha>(),"ABC");
	XCTAssertEqual(stream.read(), ' ');
	XCTAssertEqual(stream.read<isAnything>(), "def { } 123");
}

- (void)testReadDigit {
	TokenizerStream stream(input);
	XCTAssertEqual(stream.read<isDigit>(), "");
	XCTAssertEqual(stream.read(), 'A');
}

- (void)testPeekAlpha {
	TokenizerStream stream(input);
	XCTAssertEqual(stream.peek<isAlpha>(), true);
}

- (void)testNextDigit {
	TokenizerStream stream(input);
	XCTAssertEqual(stream.next<isDigit>(), true);
	XCTAssertEqual(stream.read(), '1');
	XCTAssertEqual(stream.next<isNothing>(), false);
	XCTAssertEqual(stream.read(), '2');
}

- (void)testBackAlpha {
	TokenizerStream stream(input);
	stream.next(static_cast<unsigned>(15));
	XCTAssertEqual(stream.read(), '3');
	XCTAssertEqual(stream.prev<isAlpha>(), true);
	XCTAssertEqual(stream.read(), 'f');
}

- (void)testSkipAlpha {
	TokenizerStream stream(input);
	XCTAssertEqual(stream.skip<isAlpha>(), true);
	XCTAssertEqual(stream.read(), ' ');
}

@end
