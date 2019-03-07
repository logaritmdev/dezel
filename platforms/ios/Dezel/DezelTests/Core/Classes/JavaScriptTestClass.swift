import Dezel

class JavaScriptTestClass: JavaScriptClass {

	static var testConstructorCallback: JavaScriptFunctionHandler?
	static var testJavaScriptFunctionCallback: JavaScriptFunctionHandler?
	static var testJavaScriptGetterCallback: JavaScriptGetterHandler?
	static var testJavaScriptSetterCallback: JavaScriptSetterHandler?

	@objc override func jsFunction_constructor(callback: JavaScriptFunctionCallback) {
		JavaScriptTestClass.testConstructorCallback?(callback)
	}

	@objc func jsFunction_testFunction(callback: JavaScriptFunctionCallback) {
		JavaScriptTestClass.testJavaScriptFunctionCallback?(callback)
	}

	@objc func jsGet_testProperty(callback: JavaScriptGetterCallback) {
		JavaScriptTestClass.testJavaScriptGetterCallback?(callback)
	}

	@objc func jsSet_testProperty(callback: JavaScriptSetterCallback) {
		JavaScriptTestClass.testJavaScriptSetterCallback?(callback)
	}
}
