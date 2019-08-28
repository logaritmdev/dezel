import XCTest
import Dezel

class JavaScriptPropertyTest: XCTestCase {

	private var context: JavaScriptContext = JavaScriptContext()

	override func setUp() {
		super.setUp()
		self.context.dispose()
		self.context = JavaScriptContext()
		self.context.setup()
	}

	func testPropertyNullCreation() {

		let property = JavaScriptProperty()

		XCTAssertEqual(property.type, .null)
		XCTAssertEqual(property.unit, .none)

		XCTAssertEqual(property.isNull, true)
		XCTAssertEqual(property.isString, false)
		XCTAssertEqual(property.isNumber, false)
		XCTAssertEqual(property.isBoolean, false)
		XCTAssertEqual(property.isObject, false)
		XCTAssertEqual(property.isArray, false)

		XCTAssertEqual(property.string, "")
		XCTAssertEqual(property.number, 0.0)
		XCTAssertEqual(property.boolean, false)
	}

	func testPropertyStringCreation() {

		let property = JavaScriptProperty(string: "test")

		XCTAssertEqual(property.type, .string)
		XCTAssertEqual(property.unit, .none)

		XCTAssertEqual(property.isNull, false)
		XCTAssertEqual(property.isString, true)
		XCTAssertEqual(property.isNumber, false)
		XCTAssertEqual(property.isBoolean, false)
		XCTAssertEqual(property.isObject, false)
		XCTAssertEqual(property.isArray, false)

		XCTAssertEqual(property.string, "test")
		XCTAssertEqual(property.number.isNaN, true)
		XCTAssertEqual(property.boolean, true)
	}

	func testPropertyNumberCreation() {

		let property = JavaScriptProperty(number: 14.0)

		XCTAssertEqual(property.type, .number)
		XCTAssertEqual(property.unit, .none)

		XCTAssertEqual(property.isNull, false)
		XCTAssertEqual(property.isString, false)
		XCTAssertEqual(property.isNumber, true)
		XCTAssertEqual(property.isBoolean, false)
		XCTAssertEqual(property.isObject, false)
		XCTAssertEqual(property.isArray, false)

		XCTAssertEqual(property.string, "14")
		XCTAssertEqual(property.number, 14.0)
		XCTAssertEqual(property.boolean, true)
	}

	func testPropertyNumberWithUnitCreation() {

		let property = JavaScriptProperty(number: 14.0, unit: .px)

		XCTAssertEqual(property.type, .number)
		XCTAssertEqual(property.unit, .px)

		XCTAssertEqual(property.isNull, false)
		XCTAssertEqual(property.isString, false)
		XCTAssertEqual(property.isNumber, true)
		XCTAssertEqual(property.isBoolean, false)
		XCTAssertEqual(property.isObject, false)
		XCTAssertEqual(property.isArray, false)

		XCTAssertEqual(property.string, "14px")
		XCTAssertEqual(property.number, 14.0)
		XCTAssertEqual(property.boolean, true)
	}

	func testPropertyBooleanCreation() {

		let p1 = JavaScriptProperty(boolean: true)

		XCTAssertEqual(p1.type, .boolean)
		XCTAssertEqual(p1.unit, .none)

		XCTAssertEqual(p1.isNull, false)
		XCTAssertEqual(p1.isString, false)
		XCTAssertEqual(p1.isNumber, false)
		XCTAssertEqual(p1.isBoolean, true)
		XCTAssertEqual(p1.isObject, false)
		XCTAssertEqual(p1.isArray, false)

		XCTAssertEqual(p1.string, "true")
		XCTAssertEqual(p1.number, 1.0)
		XCTAssertEqual(p1.boolean, true)

		let p2 = JavaScriptProperty(boolean: false)

		XCTAssertEqual(p2.type, .boolean)
		XCTAssertEqual(p2.unit, .none)

		XCTAssertEqual(p2.isNull, false)
		XCTAssertEqual(p2.isString, false)
		XCTAssertEqual(p2.isNumber, false)
		XCTAssertEqual(p2.isBoolean, true)
		XCTAssertEqual(p2.isObject, false)
		XCTAssertEqual(p2.isArray, false)

		XCTAssertEqual(p2.string, "false")
		XCTAssertEqual(p2.number, 0.0)
		XCTAssertEqual(p2.boolean, false)
	}
}
