import XCTest
import Dezel

class JavaScriptContextTest: XCTestCase {

	internal static var testJavaScriptFunctionCallback: JavaScriptFunctionHandler? = nil
	internal static var testConstructorACallback: JavaScriptFunctionHandler? = nil
	internal static var testConstructorBCallback: JavaScriptFunctionHandler? = nil
	internal static var testJavaScriptGetterCallback: JavaScriptGetterHandler? = nil
	internal static var testJavaScriptSetterCallback: JavaScriptSetterHandler? = nil

	private var context: JavaScriptContext = JavaScriptContext()

	override func setUp() {
		super.setUp()
		self.context.dispose()
		self.context = JavaScriptContext()
		self.context.setup()
	}

	func testValueCreateWithNull() {
		let value = self.context.createNull()
		XCTAssertTrue(value.isNull)
		value.dispose()
	}

	func testValueCreatedWithUndefined() {
		let value = self.context.createUndefined()
		XCTAssertTrue(value.isUndefined)
		value.dispose()
	}

	func testValueCreatedWithBoolean() {
		let value = self.context.createBoolean(true)
		XCTAssertTrue(value.isBoolean)
		XCTAssertEqual(value.boolean, true)
		value.dispose()
	}

	func testValueCreatedWithString() {
		let value = self.context.createString("foo")
		XCTAssertTrue(value.isString)
		XCTAssertEqual(value.string, "foo")
		value.dispose()
	}

	func testValueCreatedWithNumber() {
		let value = self.context.createNumber(10.0)
		XCTAssertTrue(value.isNumber)
		XCTAssertEqual(value.number, 10.0)
		value.dispose()
	}

	func testValueCreatedWithObject() {
		let value = self.context.createEmptyObject()
		XCTAssertTrue(value.isObject)
		value.dispose()
	}

	func testValueCreatedWithFunction() {
		let value = self.context.createFunction({ (callback: JavaScriptFunctionCallback) in })
		XCTAssertTrue(value.isFunction)
		value.dispose()
	}

	func testEvaluation() {
		self.context.evaluate("1 + 2")
	}

	func testGlobalVariables() {

		let object = self.context.createEmptyObject()
		self.context.global.property("value", value: object)
		let result = self.context.global.property("value")
		XCTAssertTrue(object.equals(result))
		result.dispose();
		object.dispose()

		self.context.global.property("value", string: "test")
		XCTAssertEqual(self.context.global.property("value").string, "test")

		self.context.global.property("value", number: 10)
		XCTAssertEqual(self.context.global.property("value").number, 10)

		self.context.global.property("value", boolean: true)
		XCTAssertEqual(self.context.global.property("value").boolean, true)

		self.context.global.property("value", value: nil)
		XCTAssertEqual(self.context.global.property("value").string, "null")
	}

	func testJavaScriptClassCreation() {
		let classA = self.context.createClass(JavaScriptContextTestClassA.self)
		classA.dispose()
	}


	func testExceptionHandler() {

		var didCallExceptionHandler = false

		self.context.handleError { error in
			didCallExceptionHandler = true
		}

		self.context.evaluate("a + b")

		XCTAssertTrue(didCallExceptionHandler)
	}
}
