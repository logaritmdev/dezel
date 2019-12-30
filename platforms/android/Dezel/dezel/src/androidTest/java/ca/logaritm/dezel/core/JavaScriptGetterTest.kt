package ca.logaritm.dezel.core

import org.junit.Assert
import org.junit.Before
import org.junit.Test

class JavaScriptGetterTest {

	private var context: JavaScriptContext = JavaScriptContext()

	@Before
	fun beforeTest() {
		this.context.dispose()
		this.context = JavaScriptContext()
	}

	@Test
	fun testCallback() {

		var didCallCallback = false
		var expectedCallee: JavaScriptValue? = null
		var expectedObject: JavaScriptValue? = null

		val getter = fun(callback: JavaScriptGetterCallback) {
			expectedCallee = callback.callee
			expectedObject = callback.target
			didCallCallback = true
		}

		val obj = this.context.createEmptyObject()

		this.defineGetter(getter, obj).property("property").dispose()

		Assert.assertNotNull(expectedCallee)
		Assert.assertNotNull(expectedObject)
		Assert.assertTrue(obj.equals(expectedObject!!))

		Assert.assertTrue(didCallCallback)

		expectedCallee?.dispose()
		expectedObject?.dispose()

		obj.dispose()
	}

	@Test
	fun testReturnValue() {

		val getter = fun(callback: JavaScriptGetterCallback) {
			val string = callback.context.createString("")
			callback.returns(string)
		}

		val obj = this.defineGetter(getter, null)

		val result = obj.property("property")
		Assert.assertTrue(result.isString)
		result.dispose()

		obj.dispose()
	}

	@Test
	fun testReturnValueWithString() {

		val getter = fun(callback: JavaScriptGetterCallback) {
			callback.returns("")
		}

		val obj = this.defineGetter(getter, null)

		val result = obj.property("property")
		Assert.assertTrue(result.isString)
		result.dispose()

		obj.dispose()
	}

	@Test
	fun testReturnValueWithNumber() {

		val getter = fun(callback: JavaScriptGetterCallback) {
			callback.returns(10.0)
		}

		val obj = this.defineGetter(getter, null)

		val result = obj.property("property")

		Assert.assertTrue(result.isNumber)
		result.dispose()

		obj.dispose()
	}

	@Test
	fun testReturnValueWithBoolean() {

		val getter = fun(callback: JavaScriptGetterCallback) {
			callback.returns(true)
		}

		val obj = this.defineGetter(getter, null)

		val result = obj.property("property")
		Assert.assertTrue(result.isBoolean)
		result.dispose()

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
			target = this.context.createEmptyObject()
		}

		target.defineProperty("property", null, getter, null, false, false, false)

		return target
	}
}