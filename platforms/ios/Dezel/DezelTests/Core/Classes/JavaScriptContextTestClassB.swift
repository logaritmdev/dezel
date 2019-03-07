import Dezel

class JavaScriptContextTestClassB: JavaScriptClass {
	@objc override func jsFunction_constructor(callback: JavaScriptFunctionCallback) {
		JavaScriptContextTest.testConstructorBCallback?(callback)
	}
}
