import Dezel

class JavaScriptTestObject: JavaScriptObject {

	static var testJavaScriptFunctionCallback: JavaScriptFunctionHandler?
	static var testJavaScriptGetterCallback: JavaScriptGetterHandler?
	static var testJavaScriptSetterCallback: JavaScriptSetterHandler?

	@objc open func jsFunction_testFunction(callback: JavaScriptFunctionCallback) {
		JavaScriptTestObject.testJavaScriptFunctionCallback?(callback)
	}

	@objc open func jsGet_testProperty(callback: JavaScriptGetterCallback) {
		JavaScriptTestObject.testJavaScriptGetterCallback?(callback)
	}

	@objc open func jsSet_testProperty(callback: JavaScriptSetterCallback) {
		JavaScriptTestObject.testJavaScriptSetterCallback?(callback)
	}
}
