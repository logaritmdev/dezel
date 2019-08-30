package ca.logaritm.dezel.classes

import ca.logaritm.dezel.core.*

class ObjectTemplateTestClass(context: JavaScriptContext) : JavaScriptObject(context) {

	companion object {
		var testFunctionCallback: JavaScriptFunctionHandler? = null
		var testPropertyGetterCallback: JavaScriptGetterHandler? = null
		var testPropertySetterCallback: JavaScriptSetterHandler? = null
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
