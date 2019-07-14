import XCTest
import Dezel

class JavaScriptGetterTest: XCTestCase {

	private var context: JavaScriptContext = JavaScriptContext()

	override func setUp() {
		super.setUp()
		self.context.dispose()
		self.context = JavaScriptContext()
		self.context.setup()
	}

	func testCallback() {

		var didCallCallback = false
		var expectedCallee: JavaScriptValue?
		var expectedObject: JavaScriptValue?

		func getter(callback: JavaScriptGetterCallback) {
			expectedCallee = callback.callee
			expectedObject = callback.target
			didCallCallback = true
		}

		let obj = self.context.createEmptyObject()

		self.defineGetter(getter, target: obj).property("property").dispose()

		XCTAssertNotNil(expectedCallee)
		XCTAssertNotNil(expectedObject)
		XCTAssertTrue(obj.equals(expectedObject!))

		expectedCallee!.dispose()
		expectedObject!.dispose()

		obj.dispose()

		XCTAssertTrue(didCallCallback)
	}

	func testReturnValue() {

		func getter(callback: JavaScriptGetterCallback) {
			callback.returns(callback.context.createString(""))
		}

		let obj = self.defineGetter(getter, target: nil)

		let result = obj.property("property")
		XCTAssertTrue(result.isString)
		result.dispose()

		obj.dispose()
	}

	func testReturnValueWithString() {

		func getter(callback: JavaScriptGetterCallback) {
			callback.returns(string: "")
		}

		let obj = self.defineGetter(getter, target: nil)

		let result = obj.property("property")
		XCTAssertTrue(result.isString)
		result.dispose()

		obj.dispose()
	}

	func testReturnValueWithNumber() {

		func getter(callback: JavaScriptGetterCallback) {
			callback.returns(number: 10)
		}

		let obj = self.defineGetter(getter, target: nil)

		let result = obj.property("property")
		XCTAssertTrue(result.isNumber)
		result.dispose()

		obj.dispose()
	}

	func testReturnValueWithBoolean() {

		func getter(callback: JavaScriptGetterCallback) {
			callback.returns(boolean: true)
		}

		let obj = self.defineGetter(getter, target: nil)

		let result = obj.property("property")
		XCTAssertTrue(result.isBoolean)
		result.dispose()

		obj.dispose()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	internal func defineSetter(_ setter: @escaping JavaScriptSetterHandler, target: JavaScriptValue?) -> JavaScriptValue {

		var obj = target
		if (obj == nil) {
			obj = self.context.createEmptyObject()
		}

		obj!.defineProperty("property", value: nil, getter: nil, setter: setter, writable: false, enumerable: false, configurable: false)

		return obj!
	}

	internal func defineGetter(_ getter: @escaping JavaScriptGetterHandler, target: JavaScriptValue?) -> JavaScriptValue {

		var obj = target
		if (obj == nil) {
			obj = self.context.createEmptyObject()
		}

		obj!.defineProperty("property", value: nil, getter: getter, setter: nil, writable: false, enumerable: false, configurable: false)

		return obj!
	}
}
