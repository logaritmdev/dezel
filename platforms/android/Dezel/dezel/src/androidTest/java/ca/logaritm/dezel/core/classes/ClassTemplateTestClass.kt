package ca.logaritm.dezel.classes

import ca.logaritm.dezel.core.*

class ClassTemplateTestClass(context: JavaScriptContext) : JavaScriptClass(context) {

	companion object {
		var testConstructorCallback: JavaScriptFunctionHandler? = null
		var testFunctionCallback: JavaScriptFunctionHandler? = null
		var testPropertyGetterCallback: JavaScriptGetterHandler? = null
		var testPropertySetterCallback: JavaScriptSetterHandler? = null
	}

	override fun jsFunction_constructor(callback: JavaScriptFunctionCallback) {
		super.jsFunction_constructor(callback)
		testConstructorCallback?.invoke(callback)
	}

	@Suppress("unused")
	fun jsFunction_testFunction(callback: JavaScriptFunctionCallback) {
		testFunctionCallback?.invoke(callback)
	}

	@Suppress("unused")
	fun jsGet_testProperty(callback: JavaScriptGetterCallback) {
		testPropertyGetterCallback?.invoke(callback)
	}

	@Suppress("unused")
	fun jsSet_testProperty(callback: JavaScriptSetterCallback) {
		testPropertySetterCallback?.invoke(callback)
	}
}
