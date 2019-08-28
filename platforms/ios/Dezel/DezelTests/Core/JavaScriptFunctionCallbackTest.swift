import XCTest
import Dezel

class JavaScriptFunctionCallbackTest: XCTestCase {

	private var context: JavaScriptContext = JavaScriptContext()

	override func setUp() {
		super.setUp()
		self.context.dispose()
		self.context = JavaScriptContext()
		self.context.setup()
	}

	func testCallback() {

		let obj = self.context.createEmptyObject()

		var didCallCallback = false
		var expectedObject: JavaScriptValue?
		var expectedCallee: JavaScriptValue?

		self.call({ callback in
			expectedObject = callback.target
			expectedCallee = callback.callee
			didCallCallback = true
		}, target: obj).dispose()

		XCTAssertNotNil(expectedCallee)
		XCTAssertNotNil(expectedObject)
		XCTAssertTrue(obj.equals(expectedObject!))

		expectedCallee?.dispose()
		expectedObject?.dispose()

		obj.dispose()

		XCTAssertTrue(didCallCallback)
	}

	func testArguments() {

		let function = self.context.createFunction({ callback in

			XCTAssertEqual(callback.arguments, 3)

			let arg0 = callback.argument(0)
			let arg1 = callback.argument(1)
			let arg2 = callback.argument(2)

			XCTAssertTrue(arg0.isString)
			XCTAssertTrue(arg1.isNumber)
			XCTAssertTrue(arg2.isBoolean)

			arg0.dispose()
			arg1.dispose()
			arg2.dispose()

			XCTAssertEqual(callback.argument(0).string, "")
			XCTAssertEqual(callback.argument(1).number, 10.0)
			XCTAssertEqual(callback.argument(2).boolean, true)
		})

		let arg0 = self.context.createString("")
		let arg1 = self.context.createNumber(10)
		let arg2 = self.context.createBoolean(true)

		function.call([arg0, arg1, arg2], target: nil, result: nil)
		function.dispose()
	}

	func testReturnValue() {

		func function (callback: JavaScriptFunctionCallback) {
			callback.returns(callback.context.createNumber(10))
		}

		let result = self.call(function, target: nil)
		XCTAssertTrue(result.isNumber)
		result.dispose()
	}

	func testReturnValueWithString() {

		func function (callback: JavaScriptFunctionCallback) {
			callback.returns("")
		}

		let result = self.call(function, target: nil)
		XCTAssertTrue(result.isString)
		result.dispose()
	}

	func testReturnValueWithNumber() {

		func function (callback: JavaScriptFunctionCallback) {
			callback.returns(10)
		}

		let result = self.call(function, target: nil)
		XCTAssertTrue(result.isNumber)
		result.dispose()
	}

	func testReturnValueWithBoolean() {

		func function (callback: JavaScriptFunctionCallback) {
			callback.returns(true)
		}

		let result = self.call(function, target: nil)
		XCTAssertTrue(result.isBoolean)
		result.dispose()
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	internal func call(_ fn: @escaping JavaScriptFunctionHandler, target: JavaScriptValue?) -> JavaScriptValue {
		let result = self.context.createReturnValue()
		let function = self.context.createFunction(fn)
		function.call(nil, target: target, result: result)
		function.dispose()
		return result
	}
}
