package ca.logaritm.dezel

import ca.logaritm.dezel.core.*

internal class ContextTestClassA(context: JavaScriptContext) : JavaScriptClass(context) {

	override fun jsFunction_constructor(callback: JavaScriptFunctionCallback) {
		JavaScriptContextTest.testConstructorACallback?.invoke(callback)
	}

	fun jsFunction_testFunction(callback: JavaScriptFunctionCallback) {
		JavaScriptContextTest.testFunctionCallback?.invoke(callback)
	}

	fun jsGet_testProperty(callback: JavaScriptGetterCallback) {
		JavaScriptContextTest.testPropertyGetterCallback?.invoke(callback)
	}

	fun jsSet_testProperty(callback: JavaScriptSetterCallback) {
		JavaScriptContextTest.testPropertySetterCallback?.invoke(callback)
	}
}
