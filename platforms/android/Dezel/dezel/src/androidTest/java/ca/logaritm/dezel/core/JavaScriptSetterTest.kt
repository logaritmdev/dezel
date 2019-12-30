package ca.logaritm.dezel.core

import org.junit.Assert
import org.junit.Before
import org.junit.Test

class JavaScriptSetterTest {

	private var context: JavaScriptContext = JavaScriptContext()

	@Before
	fun beforeTest() {
		this.context.dispose()
		this.context = JavaScriptContext()
	}

	@Test
	fun testCallback() {

		val obj = this.context.createEmptyObject()

		var didCallCallback = false
		var expectedCallee: JavaScriptValue? = null
		var expectedObject: JavaScriptValue? = null

		this.defineSetter(fun(callback: JavaScriptSetterCallback) {
			expectedCallee = callback.callee
			expectedObject = callback.target
			didCallCallback = true
		}, obj).property("property", 10.0)

		Assert.assertNotNull(expectedCallee)
		Assert.assertNotNull(expectedObject)
		Assert.assertTrue(obj.equals(expectedObject!!))

		expectedCallee?.dispose()
		expectedObject?.dispose()

		obj.dispose()

		Assert.assertTrue(didCallCallback)
	}

	@Test
	fun testValue() {

		val setter = fun(callback: JavaScriptSetterCallback) {
			Assert.assertTrue(callback.value.isString)
		}

		val obj = this.defineSetter(setter, null)

		val value = this.context.createString("")
		obj.property("property", value)
		value.dispose()

		obj.dispose()
	}

	@Test
	fun testValueAsString() {

		val setter = fun(callback: JavaScriptSetterCallback) {
			Assert.assertEquals(callback.value.string, "")
		}

		val obj = this.defineSetter(setter, null)
		obj.property("property", "")
		obj.dispose()
	}

	@Test
	fun testValueAsNumber() {

		val setter = fun(callback: JavaScriptSetterCallback) {
			Assert.assertEquals(callback.value.number, 10.0, 0.0)
		}

		val obj = this.defineSetter(setter, null)
		obj.property("property", 10.0)
		obj.dispose()
	}

	@Test
	fun testValueAsBoolean() {

		val setter = fun(callback: JavaScriptSetterCallback) {
			Assert.assertEquals(callback.value.boolean, true)
		}

		val obj = this.defineSetter(setter, null)
		obj.property("property", true)
		obj.dispose()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	fun defineSetter(setter: JavaScriptSetterHandler, target: JavaScriptValue?): JavaScriptValue {

		var target = target
		if (target == null) {
			target = context.createEmptyObject()
		}

		target.defineProperty("property", null, null, setter, false, false, false)

		return target
	}

	fun defineGetter(getter: JavaScriptGetterHandler, target: JavaScriptValue?): JavaScriptValue {

		var target = target
		if (target == null) {
			target = context.createEmptyObject()
		}

		target.defineProperty("property", null, getter, null, false, false, false)

		return target
	}
}

