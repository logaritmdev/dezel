package ca.logaritm.dezel

import ca.logaritm.dezel.core.*

internal class ContextTestObject(context: JavaScriptContext) : JavaScriptObject(context) {

	@Suppress("unused")
	fun jsFunction_testFunction(callback: JavaScriptFunctionCallback) {
		JavaScriptContextTest.testFunctionCallback?.invoke(callback)
	}

	@Suppress("unused")
	fun jsGet_testProperty(callback: JavaScriptGetterCallback) {
		JavaScriptContextTest.testPropertyGetterCallback?.invoke(callback)
	}

	@Suppress("unused")
	fun jsSet_testProperty(callback: JavaScriptSetterCallback) {
		JavaScriptContextTest.testPropertySetterCallback?.invoke(callback)
	}
}
