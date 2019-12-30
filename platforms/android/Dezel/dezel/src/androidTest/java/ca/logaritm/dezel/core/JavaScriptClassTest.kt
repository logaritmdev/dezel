package ca.logaritm.dezel.core

import ca.logaritm.dezel.classes.ClassTemplateTestClass
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class JavaScriptClassTest {

	private var context: JavaScriptContext = JavaScriptContext()

	@Before
	fun beforeTest() {
		this.context.dispose()
		this.context = JavaScriptContext()
	}

	@Test
	fun testClassTemplate() {

		var didCallConstructor = false
		var didCallFunction = false
		var didCallGetter = false
		var didCallSetter = false

		ClassTemplateTestClass.testConstructorCallback = fun(callback: JavaScriptFunctionCallback) {
			didCallConstructor = true
		}

		ClassTemplateTestClass.testFunctionCallback = fun(callback: JavaScriptFunctionCallback) {
			didCallFunction = true
		}

		ClassTemplateTestClass.testPropertyGetterCallback = fun(callback: JavaScriptGetterCallback) {
			didCallGetter = true
		}

		ClassTemplateTestClass.testPropertySetterCallback = fun(callback: JavaScriptSetterCallback) {
			didCallSetter = true
		}

		val obj = this.construct(ClassTemplateTestClass::class.java)
		obj.callMethod("testFunction")
		obj.property("testProperty", 10.0)
		obj.property("testProperty").dispose()
		obj.dispose()

		Assert.assertTrue(didCallConstructor)
		Assert.assertTrue(didCallFunction)
		Assert.assertTrue(didCallGetter)
		Assert.assertTrue(didCallSetter)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	fun construct(type: Class<*>): JavaScriptValue {
		val target = context.createReturnValue()
		val constructor = context.createClass(type)
		constructor.construct(null, target)
		constructor.dispose()
		return target
	}
}
