import Dezel

class JavaScriptTestClass: JavaScriptClass {

	static var testConstructorCallback: JavaScriptFunctionHandler?
	static var testJavaScriptFunctionCallback: JavaScriptFunctionHandler?
	static var testJavaScriptGetterCallback: JavaScriptGetterHandler?
	static var testJavaScriptSetterCallback: JavaScriptSetterHandler?

	@objc override func jsFunction_constructor(callback: JavaScriptFunctionCallback) {
		super.jsFunction_constructor(callback: callback)
		JavaScriptTestClass.testConstructorCallback?(callback)
	}

	@objc open func jsFunction_testFunction(callback: JavaScriptFunctionCallback) {
		JavaScriptTestClass.testJavaScriptFunctionCallback?(callback)
	}

	@objc open func jsGet_testProperty(callback: JavaScriptGetterCallback) {
		JavaScriptTestClass.testJavaScriptGetterCallback?(callback)
	}

	@objc open func jsSet_testProperty(callback: JavaScriptSetterCallback) {
		JavaScriptTestClass.testJavaScriptSetterCallback?(callback)
	}
}
