import Dezel

class JavaScriptContextTestClassA: JavaScriptClass {
	@objc override func jsFunction_constructor(callback:JavaScriptFunctionCallback) {
		JavaScriptContextTest.testConstructorACallback?(callback)
	}
}
