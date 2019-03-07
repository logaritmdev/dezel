import XCTest
import Dezel

class JavaScriptObjectTest: XCTestCase {

	private var context: JavaScriptContext = JavaScriptContext()

    override func setUp() {
		super.setUp()
		self.context.dispose()
		self.context = JavaScriptContext()
		self.context.initialize()
    }

	func testObjectTemplate() {

        var didCallFunction = false
        var didCallGetter = false
        var didCallSetter = false

		JavaScriptTestObject.testJavaScriptFunctionCallback = { callback in
			didCallFunction = true
		}

		JavaScriptTestObject.testJavaScriptGetterCallback = { callback in
			didCallGetter = true
		}

		JavaScriptTestObject.testJavaScriptSetterCallback = { callback in
			didCallSetter = true
		}

		let object = self.context.createObject(JavaScriptTestObject.self)
		object.callMethod("testFunction")
		object.property("testProperty", number:10)
		object.property("testProperty").dispose()
		object.dispose()

		XCTAssertTrue(didCallFunction)
		XCTAssertTrue(didCallGetter)
		XCTAssertTrue(didCallSetter)
	}
}
