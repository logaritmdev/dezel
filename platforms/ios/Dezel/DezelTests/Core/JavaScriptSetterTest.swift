import XCTest
import Dezel

class JavaScriptSetterTest: XCTestCase {

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

		let obj = self.context.createEmptyObject()

		self.defineSetter({ (callback: JavaScriptSetterCallback) in
			expectedCallee = callback.callee
			expectedObject = callback.target
			didCallCallback = true
		}, target: obj).property("property", number: 10)

		XCTAssertNotNil(expectedCallee)
		XCTAssertNotNil(expectedObject)
		XCTAssertTrue(obj.equals(expectedObject!))

		expectedCallee?.dispose()
		expectedObject?.dispose()

		obj.dispose()

		XCTAssertTrue(didCallCallback)
	}

	func testValue() {

		func setter(callback: JavaScriptSetterCallback) {
			XCTAssertTrue(callback.value.isString)
		}

		let obj = self.defineSetter(setter, target: nil)

		let value = self.context.createString("")
		obj.property("property", value: value)
		value.dispose()

		obj.dispose()
	}

	func testValueAsString() {

		func setter(callback: JavaScriptSetterCallback) {
			XCTAssertEqual(callback.value.string, "")
		}

		let obj = self.defineSetter(setter, target: nil)
		obj.property("property", string: "")
		obj.dispose()
	}

	func testValueAsNumber() {

		func setter(callback: JavaScriptSetterCallback) {
			XCTAssertEqual(callback.value.number, 10)
		}

		let obj = self.defineSetter(setter, target: nil)
		obj.property("property", number: 10)
		obj.dispose()
	}

	func testValueAsBoolean() {

		func setter(callback: JavaScriptSetterCallback) {
			XCTAssertEqual(callback.value.boolean, true)
		}

		let obj = self.defineSetter(setter, target: nil)
		obj.property("property", boolean: true)
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
