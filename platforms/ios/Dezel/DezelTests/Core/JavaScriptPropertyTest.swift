import XCTest
import Dezel

class JavaScriptPropertyTest: XCTestCase {

	private var context: JavaScriptContext = JavaScriptContext()

	override func setUp() {
		super.setUp()
		self.context.dispose()
		self.context = JavaScriptContext()
	}

	func testPropertyCreatedWithNull() {

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

	func testPropertyCreateWithString() {

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

	func testPropertyCreatedWithNumber() {

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

	func testPropertyCreatedWithNumberAndUnit() {

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

	func testPropertyCreatedWithBoolean() {

		let property = JavaScriptProperty(boolean: true)

		XCTAssertEqual(property.type, .boolean)
		XCTAssertEqual(property.unit, .none)

		XCTAssertEqual(property.isNull, false)
		XCTAssertEqual(property.isString, false)
		XCTAssertEqual(property.isNumber, false)
		XCTAssertEqual(property.isBoolean, true)
		XCTAssertEqual(property.isObject, false)
		XCTAssertEqual(property.isArray, false)

		XCTAssertEqual(property.string, "true")
		XCTAssertEqual(property.number, 1.0)
		XCTAssertEqual(property.boolean, true)
	}

	func testPropertyStringConversion() {

		let n1 = JavaScriptProperty(number: 5.0)
		let n2 = JavaScriptProperty(number: 5.5)
		let n3 = JavaScriptProperty(number: -5.0)
		let n4 = JavaScriptProperty(number: -5.5)

		XCTAssertEqual(n1.string, "5")
		XCTAssertEqual(n2.string, "5.5")
		XCTAssertEqual(n3.string, "-5")
		XCTAssertEqual(n4.string, "-5.5")

		let npx = JavaScriptProperty(number: 5.0, unit: .px)
		let npc = JavaScriptProperty(number: 5.0, unit: .pc)
		let nvw = JavaScriptProperty(number: 5.0, unit: .vw)
		let nvh = JavaScriptProperty(number: 5.0, unit: .vh)
		let npw = JavaScriptProperty(number: 5.0, unit: .pw)
		let nph = JavaScriptProperty(number: 5.0, unit: .ph)
		let ncw = JavaScriptProperty(number: 5.0, unit: .cw)
		let nch = JavaScriptProperty(number: 5.0, unit: .ch)

		XCTAssertEqual(npx.string, "5px")
		XCTAssertEqual(npc.string, "5%")
		XCTAssertEqual(nvw.string, "5vw")
		XCTAssertEqual(nvh.string, "5vh")
		XCTAssertEqual(npw.string, "5pw")
		XCTAssertEqual(nph.string, "5ph")
		XCTAssertEqual(ncw.string, "5cw")
		XCTAssertEqual(nch.string, "5ch")

		let b1 = JavaScriptProperty(boolean: true)
		let b2 = JavaScriptProperty(boolean: false)

		XCTAssertEqual(b1.string, "true")
		XCTAssertEqual(b2.string, "false")
	}

	func testPropertyNumberConversion() {

		let s1 = JavaScriptProperty(string: "5.0")
		let s2 = JavaScriptProperty(string: "5.5")
		let s3 = JavaScriptProperty(string: "-5.0")
		let s4 = JavaScriptProperty(string: "-5.5")

		XCTAssertEqual(s1.number, 5)
		XCTAssertEqual(s2.number, 5.5)
		XCTAssertEqual(s3.number, -5)
		XCTAssertEqual(s4.number, -5.5)

		let b1 = JavaScriptProperty(boolean: true)
		let b2 = JavaScriptProperty(boolean: false)

		XCTAssertEqual(b1.number, 1.0)
		XCTAssertEqual(b2.number, 0.0)
	}

	func testPropertyBooleanConversion() {

		let s1 = JavaScriptProperty(string: "5.0")
		let s2 = JavaScriptProperty(string: "0.0")
		let s3 = JavaScriptProperty(string: "")
		let s4 = JavaScriptProperty(string: "value")

		XCTAssertEqual(s1.boolean, true)
		XCTAssertEqual(s2.boolean, true)
		XCTAssertEqual(s3.boolean, false)
		XCTAssertEqual(s4.boolean, true)

		let b1 = JavaScriptProperty(number: 5.0)
		let b2 = JavaScriptProperty(number: 0.0)

		XCTAssertEqual(b1.boolean, true)
		XCTAssertEqual(b2.boolean, false)
	}

	func testResetWithJavaScriptStringValue() {

		let value = self.context.createString("test")

		let property = JavaScriptProperty()

		property.reset(value)

		XCTAssertEqual(property.type, .string)
		XCTAssertEqual(property.unit, .none)

		XCTAssertEqual(property.string, "test")
		XCTAssertEqual(property.number.isNaN, true)
		XCTAssertEqual(property.boolean, true)

		XCTAssertEqual(property.toHandle(self.context), value.handle)
	}

	func testResetWithJavaScriptStringWithUnitValue() {

		let px = self.context.createString("15px")
		let pc = self.context.createString("15%")
		let vw = self.context.createString("15vw")
		let vh = self.context.createString("15vh")
		let pw = self.context.createString("15pw")
		let ph = self.context.createString("15ph")
		let cw = self.context.createString("15cw")
		let ch = self.context.createString("15ch")

		let property = JavaScriptProperty()

		property.reset(px, parse: true)

		XCTAssertEqual(property.type, .number)
		XCTAssertEqual(property.unit, .px)

		XCTAssertEqual(property.string, "15px")
		XCTAssertEqual(property.number, 15)
		XCTAssertEqual(property.boolean, true)

		XCTAssertEqual(property.toHandle(self.context), px.handle)

		property.reset(pc, parse: true)

		XCTAssertEqual(property.type, .number)
		XCTAssertEqual(property.unit, .pc)

		XCTAssertEqual(property.string, "15%")
		XCTAssertEqual(property.number, 15)
		XCTAssertEqual(property.boolean, true)

		XCTAssertEqual(property.toHandle(self.context), pc.handle)

		property.reset(vw, parse: true)

		XCTAssertEqual(property.type, .number)
		XCTAssertEqual(property.unit, .vw)

		XCTAssertEqual(property.string, "15vw")
		XCTAssertEqual(property.number, 15)
		XCTAssertEqual(property.boolean, true)

		XCTAssertEqual(property.toHandle(self.context), vw.handle)

		property.reset(vh, parse: true)

		XCTAssertEqual(property.type, .number)
		XCTAssertEqual(property.unit, .vh)

		XCTAssertEqual(property.string, "15vh")
		XCTAssertEqual(property.number, 15)
		XCTAssertEqual(property.boolean, true)

		XCTAssertEqual(property.toHandle(self.context), vh.handle)

		property.reset(pw, parse: true)

		XCTAssertEqual(property.type, .number)
		XCTAssertEqual(property.unit, .pw)

		XCTAssertEqual(property.string, "15pw")
		XCTAssertEqual(property.number, 15)
		XCTAssertEqual(property.boolean, true)

		XCTAssertEqual(property.toHandle(self.context), pw.handle)

		property.reset(ph, parse: true)

		XCTAssertEqual(property.type, .number)
		XCTAssertEqual(property.unit, .ph)

		XCTAssertEqual(property.string, "15ph")
		XCTAssertEqual(property.number, 15)
		XCTAssertEqual(property.boolean, true)

		XCTAssertEqual(property.toHandle(self.context), ph.handle)

		property.reset(cw, parse: true)

		XCTAssertEqual(property.type, .number)
		XCTAssertEqual(property.unit, .cw)

		XCTAssertEqual(property.string, "15cw")
		XCTAssertEqual(property.number, 15)
		XCTAssertEqual(property.boolean, true)

		XCTAssertEqual(property.toHandle(self.context), cw.handle)

		property.reset(ch, parse: true)

		XCTAssertEqual(property.type, .number)
		XCTAssertEqual(property.unit, .ch)

		XCTAssertEqual(property.string, "15ch")
		XCTAssertEqual(property.number, 15)
		XCTAssertEqual(property.boolean, true)

		XCTAssertEqual(property.toHandle(self.context), ch.handle)
	}

	func testResetWithJavaScriptNumberValue() {

		let value = self.context.createNumber(15.0)

		let property = JavaScriptProperty()

		property.reset(value)

		XCTAssertEqual(property.type, .number)
		XCTAssertEqual(property.unit, .none)

		XCTAssertEqual(property.string, "15")
		XCTAssertEqual(property.number, 15)
		XCTAssertEqual(property.boolean, true)

		XCTAssertEqual(property.toHandle(self.context), value.handle)
	}

	func testResetWithJavaScriptBooleanValue() {

		let value = self.context.createBoolean(true)

		let property = JavaScriptProperty()

		property.reset(value)

		XCTAssertEqual(property.type, .boolean)
		XCTAssertEqual(property.unit, .none)

		XCTAssertEqual(property.string, "true")
		XCTAssertEqual(property.number, 1)
		XCTAssertEqual(property.boolean, true)

		XCTAssertEqual(property.toHandle(self.context), value.handle)
	}

	func testChangeCallback() {

		let expectation = self.expectation(description: "Called")

		let property = JavaScriptProperty() { value in
			expectation.fulfill()
		}

		property.reset("test")

		self.wait(for: [expectation], timeout: 1.0)
	}

	func testChangeCallbackWithTypes() {

		var called = 0

		let property = JavaScriptProperty() { value in
			called += 1
		}

		property.reset("test")
		property.reset("test")
		property.reset(10.0)
		property.reset(10.0, unit: .px)
		property.reset(10.0, unit: .px)
		property.reset(true)
		property.reset(true)

		XCTAssertEqual(called, 4)
	}
}
