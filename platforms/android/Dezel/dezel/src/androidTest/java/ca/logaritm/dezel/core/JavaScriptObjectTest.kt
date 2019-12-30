package ca.logaritm.dezel.core

import ca.logaritm.dezel.classes.ObjectTemplateTestClass
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class JavaScriptObjectTest {

	private var context: JavaScriptContext = JavaScriptContext()

	@Before
	fun beforeTest() {
		this.context.dispose()
		this.context = JavaScriptContext()
	}

	@Test
	fun testObjectTemplate() {

		var didCallFunction = false
		var didCallGetter = false
		var didCallSetter = false

		ObjectTemplateTestClass.testFunctionCallback = fun(callback: JavaScriptFunctionCallback) {
			didCallFunction = true
		}

		ObjectTemplateTestClass.testPropertyGetterCallback = fun(callback: JavaScriptGetterCallback) {
			didCallGetter = true
		}

		ObjectTemplateTestClass.testPropertySetterCallback = fun(callback: JavaScriptSetterCallback) {
			didCallSetter = true
		}

		val obj = this.context.createObject(ObjectTemplateTestClass::class.java)
		obj.callMethod("testFunction")
		obj.property("testProperty", 10.0)
		obj.property("testProperty").dispose()
		obj.dispose()

		Assert.assertTrue(didCallFunction)
		Assert.assertTrue(didCallGetter)
		Assert.assertTrue(didCallSetter)
	}
}
