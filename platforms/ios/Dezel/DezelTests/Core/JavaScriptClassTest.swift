import XCTest
import Dezel

class JavaScriptClassTest: XCTestCase {

	private var context: JavaScriptContext = JavaScriptContext()

	override func setUp() {
		super.setUp()
		self.context.dispose()
		self.context = JavaScriptContext()
	}

	func testJavaScriptClass() {

		var didCallConstructor = false
		var didCallFunction = false
		var didCallGetter = false
		var didCallSetter = false

		JavaScriptTestClass.testConstructorCallback = { callback in
			didCallConstructor = true
		}

		JavaScriptTestClass.testJavaScriptFunctionCallback = { callback in
			didCallFunction = true
		}

		JavaScriptTestClass.testJavaScriptGetterCallback = { callback in
			didCallGetter = true
		}

		JavaScriptTestClass.testJavaScriptSetterCallback = { callback in
			didCallSetter = true
		}

		let obj = self.constructJavaScriptClass(JavaScriptTestClass.self)

		obj.callMethod("testFunction")
		obj.property("testProperty", number: 10)
		obj.property("testProperty").dispose()
		obj.dispose()

		XCTAssertTrue(didCallConstructor)
		XCTAssertTrue(didCallFunction)
		XCTAssertTrue(didCallGetter)
		XCTAssertTrue(didCallSetter)
	}

	internal func constructJavaScriptClass(_ cls: AnyClass) -> JavaScriptValue {
		let obj = self.context.createReturnValue()
		let constructor = self.context.createClass(cls);
		constructor.construct(nil, result: obj)
		constructor.dispose()
		return obj;
	}
}
