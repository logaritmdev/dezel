import XCTest
import Dezel

class JavaScriptValueTest: XCTestCase {

	private var context: JavaScriptContext = JavaScriptContext()

	override func setUp() {
		super.setUp()
		self.context.dispose()
		self.context = JavaScriptContext()
	}

	func testEquality() {

		let null1 = self.context.createNull()
		let null2 = self.context.createNull()

		XCTAssertTrue(null1.equals(null2))

		null1.dispose()
		null2.dispose()

		let undefined1 = self.context.createUndefined()
		let undefined2 = self.context.createUndefined()

		XCTAssertTrue(undefined1.equals(undefined2))

		undefined1.dispose()
		undefined2.dispose()

		let boolean1 = self.context.createBoolean(true)
		let boolean2 = self.context.createBoolean(true)
		let boolean3 = self.context.createBoolean(false)

		XCTAssertTrue(boolean1.equals(boolean: true))
		XCTAssertTrue(boolean1.equals(boolean2))
		XCTAssertFalse(boolean1.equals(boolean3))

		boolean1.dispose()
		boolean2.dispose()
		boolean3.dispose()

		let string1 = self.context.createString("a")
		let string2 = self.context.createString("a")
		let string3 = self.context.createString("b")

		XCTAssertTrue(string1.equals(string: "a"))
		XCTAssertTrue(string1.equals(string2))
		XCTAssertFalse(string1.equals(string3))

		string1.dispose()
		string2.dispose()
		string3.dispose()

		let number1 = self.context.createNumber(1)
		let number2 = self.context.createNumber(1)
		let number3 = self.context.createNumber(2)

		XCTAssertTrue(number1.equals(number: 1))
		XCTAssertTrue(number1.equals(number2))
		XCTAssertFalse(number1.equals(number3))

		number1.dispose()
		number2.dispose()
		number3.dispose()

		let obj1 = self.context.createEmptyObject()
		let obj2 = self.context.createEmptyObject()

		XCTAssertFalse(obj1.equals(obj2))

		obj1.dispose()
		obj2.dispose()
	}

	func testPropertyDefinition() {

		let obj = self.context.createEmptyObject()
		let num = self.context.createNumber(10)

		var didCallGetter = false
		var didCallSetter = false

		func getter(callback: JavaScriptGetterCallback) {
			didCallGetter = true
		}

		func setter(callback: JavaScriptSetterCallback) {
			didCallSetter = true
		}

		obj.defineProperty("property", value: nil, getter: getter, setter: setter, writable: false, enumerable: false, configurable: false)
		obj.property("property").dispose()
		obj.property("property", value: num)
		obj.dispose()
		num.dispose()

		XCTAssertTrue(didCallGetter)
		XCTAssertTrue(didCallSetter)
	}

	func testPropertiesWithValues() {

		let src = self.context.createEmptyObject()
		let obj = self.context.createEmptyObject()

		src.property("key1", value: obj)
		src.property("key2", value: obj)
		src.property("key2", value: nil)

		let res1 = src.property("key1")
		let res2 = src.property("key2")
		let res3 = src.property("keyX")

		src.dispose()

		XCTAssertTrue(res1.equals(obj))
		XCTAssertTrue(res2.isNull)
		XCTAssertTrue(res3.isUndefined)

		res3.dispose()
		res2.dispose()
		res1.dispose()
		obj.dispose()
	}

	func testPropertiesWithString() {

		let obj = self.context.createEmptyObject()

		obj.property("key1", string: "val1")

		let res = obj.property("key1")

		XCTAssert(res.isString)
		XCTAssertEqual(obj.property("key1").string, "val1")
		XCTAssertEqual(obj.property("keyX").string, "undefined")

		res.dispose()
		obj.dispose()
	}

	func testPropertiesWithNumber() {

		let obj = self.context.createEmptyObject()

		obj.property("key1", number: 10)

		let res = obj.property("key1")

		XCTAssert(res.isNumber)
		XCTAssertEqual(obj.property("key1").number, 10)
		XCTAssertEqual(obj.property("keyX").number.isNaN, true)

		res.dispose()
		obj.dispose()
	}

	func testPropertiesWithBoolean() {

		let obj = self.context.createEmptyObject()

		obj.property("key1", boolean: true)

		let res = obj.property("key1")

		XCTAssert(res.isBoolean)
		XCTAssertEqual(obj.property("key1").boolean, true)
		XCTAssertEqual(obj.property("keyX").boolean, false)

		res.dispose()
		obj.dispose()
	}

	func testPropertiesAtIndexWithValues() {

		let src = self.context.createEmptyObject()
		let obj = self.context.createEmptyObject()

		src.property(0, value: obj)

		let res1 = src.property(0)
		let res2 = src.property(1)

		src.dispose()

		XCTAssertTrue(res1.equals(obj))
		XCTAssertTrue(res2.isUndefined)

		res2.dispose()
		res1.dispose()
		obj.dispose()
	}

	func testPropertiesAtIndexWithString() {

		let obj = self.context.createEmptyObject()

		obj.property(0, string: "val1")

		let res = obj.property(0)

		XCTAssert(res.isString)
		XCTAssertEqual(obj.property(0).string, "val1")
		XCTAssertEqual(obj.property(3).string, "undefined")

		res.dispose()
		obj.dispose()
	}

	func testPropertiesAtIndexWithNumber() {

		let obj = self.context.createEmptyObject()

		obj.property(0, number: 10)

		let res = obj.property(0)

		XCTAssert(res.isNumber)
		XCTAssertEqual(obj.property(0).number, 10)
		XCTAssertEqual(obj.property(3).number.isNaN, true)

		res.dispose()
		obj.dispose()
	}

	func testPropertiesAtIndexWithBoolean() {

		let obj = self.context.createEmptyObject()

		obj.property(0, boolean: true)

		let res = obj.property(0)

		XCTAssert(res.isBoolean)
		XCTAssertEqual(obj.property(0).boolean, true)
		XCTAssertEqual(obj.property(3).boolean, false)

		res.dispose()
		obj.dispose()
	}

	func testCall() {

		let obj = self.context.createEmptyObject()
		let argument1 = self.context.createNumber(10)
		let argument2 = self.context.createString("a")

		var didCallCallback = false
		var expectedCallee: JavaScriptValue?
		var expectedObject: JavaScriptValue?
		var expectedContext: JavaScriptContext?

		func callback(callback: JavaScriptFunctionCallback) {

			expectedCallee = callback.callee
			expectedObject = callback.target
			expectedContext = context

			XCTAssertEqual(callback.arguments, 2)

			let arg0 = callback.argument(0)
			let arg1 = callback.argument(1)

			XCTAssertTrue(arg0.isNumber)
			XCTAssertTrue(arg1.isString)

			arg1.dispose()
			arg0.dispose()

			didCallCallback = true
		}

		let value1 = self.context.createFunction(callback)
		let value2 = self.context.createFunction(callbackReturnNull)
		let value3 = self.context.createFunction(callbackReturnUndefined)
		let value4 = self.context.createFunction(callbackReturnBoolean)
		let value5 = self.context.createFunction(callbackReturnNumber)
		let value6 = self.context.createFunction(callbackReturnString)
		let value7 = self.context.createFunction(callbackReturnObject)

		let res1 = context.createReturnValue()
		let res2 = context.createReturnValue()
		let res3 = context.createReturnValue()
		let res4 = context.createReturnValue()
		let res5 = context.createReturnValue()
		let res6 = context.createReturnValue()
		let res7 = context.createReturnValue()

		value1.call([argument1, argument2], target: obj, result: res1)

		argument1.dispose()
		argument2.dispose()

		XCTAssertTrue(expectedCallee!.equals(value1))
		XCTAssertTrue(expectedCallee!.isFunction)
		XCTAssertTrue(expectedObject!.equals(obj))
		XCTAssertTrue(expectedObject!.isObject)
		XCTAssertTrue(expectedContext! === self.context)

		expectedCallee?.dispose()
		expectedObject?.dispose()

		obj.dispose()

		value2.call(nil, target: nil, result: res2)
		value3.call(nil, target: nil, result: res3)
		value4.call(nil, target: nil, result: res4)
		value5.call(nil, target: nil, result: res5)
		value6.call(nil, target: nil, result: res6)
		value7.call(nil, target: nil, result: res7)

		value1.dispose()
		value2.dispose()
		value3.dispose()
		value4.dispose()
		value5.dispose()
		value6.dispose()
		value7.dispose()

		XCTAssertTrue(res1.isUndefined)
		XCTAssertTrue(res2.isNull)
		XCTAssertTrue(res3.isUndefined)
		XCTAssertTrue(res4.isBoolean)
		XCTAssertTrue(res5.isNumber)
		XCTAssertTrue(res6.isString)
		XCTAssertTrue(res7.isObject)

		res1.dispose()
		res2.dispose()
		res3.dispose()
		res4.dispose()
		res5.dispose()
		res6.dispose()
		res7.dispose()

		XCTAssertTrue(didCallCallback)
	}

	func testCallWithoutArguments() {

		let obj = self.context.createEmptyObject()
		let argument1 = self.context.createNumber(10)
		let argument2 = self.context.createString("a")

		var didCallCallback = false

		func callback(callback: JavaScriptFunctionCallback) {
			XCTAssertEqual(callback.arguments, 0)
			didCallCallback = true
		}

		let function = self.context.createFunction(callback)
		function.call()
		function.dispose()

		argument2.dispose()
		argument1.dispose()
		obj.dispose()

		XCTAssertTrue(didCallCallback)
	}

	func testCallMethod() {

		let obj = self.context.createEmptyObject()
		let argument1 = self.context.createNumber(10)
		let argument2 = self.context.createString("a")

		var didCallCallback = false
		var expectedCallee: JavaScriptValue? = nil
		var expectedObject: JavaScriptValue? = nil
		var expectedContext: JavaScriptContext? = nil

		func callback(callback: JavaScriptFunctionCallback) {

			expectedCallee = callback.callee
			expectedObject = callback.target
			expectedContext = context

			XCTAssertEqual(callback.arguments, 2)

			let arg0 = callback.argument(0)
			let arg1 = callback.argument(1)

			XCTAssertTrue(callback.argument(0).isNumber)
			XCTAssertTrue(callback.argument(1).isString)

			arg1.dispose()
			arg0.dispose()

			didCallCallback = true
		}

		let value1 = self.context.createFunction(callback)
		let value2 = self.context.createFunction(callbackReturnNull)
		let value3 = self.context.createFunction(callbackReturnUndefined)
		let value4 = self.context.createFunction(callbackReturnBoolean)
		let value5 = self.context.createFunction(callbackReturnNumber)
		let value6 = self.context.createFunction(callbackReturnString)
		let value7 = self.context.createFunction(callbackReturnObject)

		obj.property("method1", value: value1)
		obj.property("method2", value: value2)
		obj.property("method3", value: value3)
		obj.property("method4", value: value4)
		obj.property("method5", value: value5)
		obj.property("method6", value: value6)
		obj.property("method7", value: value7)

		let res1 = context.createReturnValue()
		let res2 = context.createReturnValue()
		let res3 = context.createReturnValue()
		let res4 = context.createReturnValue()
		let res5 = context.createReturnValue()
		let res6 = context.createReturnValue()
		let res7 = context.createReturnValue()

		obj.callMethod("method1", arguments: [argument1, argument2], result: res1)

		XCTAssertTrue(expectedCallee!.equals(value1))
		XCTAssertTrue(expectedCallee!.isFunction)
		XCTAssertTrue(expectedObject!.equals(obj))
		XCTAssertTrue(expectedObject!.isObject)
		XCTAssertTrue(expectedContext! === self.context)

		expectedCallee?.dispose()
		expectedObject?.dispose()

		value1.dispose()
		value2.dispose()
		value3.dispose()
		value4.dispose()
		value5.dispose()
		value6.dispose()
		value7.dispose()

		obj.callMethod("method2", arguments: [], result: res2)
		obj.callMethod("method3", arguments: [], result: res3)
		obj.callMethod("method4", arguments: [], result: res4)
		obj.callMethod("method5", arguments: [], result: res5)
		obj.callMethod("method6", arguments: [], result: res6)
		obj.callMethod("method7", arguments: [], result: res7)
		obj.dispose()

		XCTAssertTrue(res1.isUndefined)
		XCTAssertTrue(res2.isNull)
		XCTAssertTrue(res3.isUndefined)
		XCTAssertTrue(res4.isBoolean)
		XCTAssertTrue(res5.isNumber)
		XCTAssertTrue(res6.isString)
		XCTAssertTrue(res7.isObject)

		res1.dispose()
		res2.dispose()
		res3.dispose()
		res4.dispose()
		res5.dispose()
		res6.dispose()
		res7.dispose()

		XCTAssertTrue(didCallCallback)
	}

	func testCallMethodWithoutArguments() {

		let obj = self.context.createEmptyObject()
		let argument1 = self.context.createNumber(10)
		let argument2 = self.context.createString("a")

		var didCallCallback = false

		func callback(callback: JavaScriptFunctionCallback) {
			XCTAssertEqual(callback.arguments, 0)
			didCallCallback = true
		}

		let value = self.context.createFunction(callback)
		obj.property("method1", value: value)
		obj.callMethod("method1")
		obj.dispose()

		value.dispose()
		argument2.dispose()
		argument1.dispose()

		XCTAssertTrue(didCallCallback)
	}

	func testConstruct() {

		let argument1 = self.context.createNumber(10)
		let argument2 = self.context.createString("a")

		var didCallCallback = false
		var expectedCallee: JavaScriptValue?
		var expectedObject: JavaScriptValue?
		var expectedContext: JavaScriptContext?

		func callback(callback: JavaScriptFunctionCallback) {

			expectedCallee = callback.callee
			expectedObject = callback.target
			expectedContext = context

			XCTAssertEqual(callback.arguments, 2)

			let arg0 = callback.argument(0)
			let arg1 = callback.argument(1)

			XCTAssertTrue(arg0.isNumber)
			XCTAssertTrue(arg1.isString)

			arg1.dispose()
			arg0.dispose()

			didCallCallback = true
		}

		let value1 = self.context.createFunction(callback)
		let value2 = self.context.createFunction(callbackReturnNull)
		let value3 = self.context.createFunction(callbackReturnUndefined)
		let value4 = self.context.createFunction(callbackReturnBoolean)
		let value5 = self.context.createFunction(callbackReturnString)
		let value6 = self.context.createFunction(callbackReturnNumber)
		let value7 = self.context.createFunction(callbackReturnObject)

		let res1 = self.context.createReturnValue()
		let res2 = self.context.createReturnValue()
		let res3 = self.context.createReturnValue()
		let res4 = self.context.createReturnValue()
		let res5 = self.context.createReturnValue()
		let res6 = self.context.createReturnValue()
		let res7 = self.context.createReturnValue()

		value1.construct([argument1, argument2], result: res1)

		argument2.dispose()
		argument1.dispose()

		XCTAssertTrue(expectedCallee!.isFunction)
		XCTAssertTrue(expectedObject!.isObject)
		XCTAssertTrue(expectedContext! === self.context)

		expectedCallee?.dispose()
		expectedObject?.dispose()

		value2.construct(nil, result: res2)
		value3.construct(nil, result: res3)
		value4.construct(nil, result: res4)
		value5.construct(nil, result: res5)
		value6.construct(nil, result: res6)
		value7.construct(nil, result: res7)

		value1.dispose()
		value2.dispose()
		value3.dispose()
		value4.dispose()
		value5.dispose()
		value6.dispose()
		value7.dispose()

		XCTAssertEqual(res1.isObject, true)
		XCTAssertEqual(res2.isObject, true)
		XCTAssertEqual(res3.isObject, true)
		XCTAssertEqual(res4.isObject, true)
		XCTAssertEqual(res5.isObject, true)
		XCTAssertEqual(res6.isObject, true)
		XCTAssertEqual(res7.isObject, true)

		res1.dispose()
		res2.dispose()
		res3.dispose()
		res4.dispose()
		res5.dispose()
		res6.dispose()
		res7.dispose()

		XCTAssertTrue(didCallCallback)
	}

	func testConstructWithoutArguments() {

		var didCallCallback = false

		func callback(callback: JavaScriptFunctionCallback) {
			XCTAssertEqual(callback.arguments, 0)
			didCallCallback = true
		}

		let function = self.context.createFunction(callback)
		function.construct()
		function.dispose()

		XCTAssertTrue(didCallCallback)
	}

	func testPrototypes() {

		let src = self.context.createEmptyObject()
		let obj = self.context.createEmptyObject()

		let res1 = src.prototype()
		src.prototype(obj)
		let res2 = src.prototype()

		src.dispose()

		XCTAssertTrue(res1.isObject)
		XCTAssertTrue(res2.isObject)
		XCTAssertTrue(res1.equals(obj) == false)
		XCTAssertTrue(res2.equals(obj))

		obj.dispose()
		res2.dispose()
		res1.dispose()
	}

	func testCast() {

		let res = self.context.createReturnValue()
		let obj = self.context.createClass(JavaScriptWatEmptyClass.self)

		obj.construct(nil, result: res)

		if let _ = res.cast(JavaScriptWatEmptyClass.self) {
			XCTAssertTrue(true)
			return
		}

		XCTFail()
	}

	/**
	 * @since 0.1.0
	 */
	func testFinalizer() {
		/*
		let expectation = self.expectation(description:"Finalized")

		var finalized = false
		let finalizer = {
			finalized = true

		}

		for _ in 1...1500 {
			self.context.createEmptyObject().setFinalizer(finalizer)
			self.context.garbageCollect()
		}

		for _ in 1...60 {
			self.context.garbageCollect()
			sleep(1)
		}

		XCTAssertTrue(finalized)
		*/
	}
}

func callbackReturnNull(callback: JavaScriptFunctionCallback) {
	callback.returns(callback.context.createNull())
}

func callbackReturnUndefined(callback: JavaScriptFunctionCallback) {
	callback.returns(callback.context.createUndefined())
}

func callbackReturnBoolean(callback: JavaScriptFunctionCallback) {
	callback.returns(callback.context.createBoolean(true))
}

func callbackReturnNumber(callback: JavaScriptFunctionCallback) {
	callback.returns(callback.context.createNumber(10))
}

func callbackReturnString(callback: JavaScriptFunctionCallback) {
	callback.returns(callback.context.createString("a"))
}

func callbackReturnObject(callback: JavaScriptFunctionCallback) {
	callback.returns(callback.context.createEmptyObject())
}


