package ca.logaritm.dezel.core

import org.junit.Assert
import org.junit.Before
import org.junit.Test

class JavaScriptFunctionTest {

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

		this.call(fun(callback: JavaScriptFunctionCallback) {
			expectedObject = callback.target
			expectedCallee = callback.callee
			didCallCallback = true
		}, obj).dispose()

		Assert.assertNotNull(expectedCallee)
		Assert.assertNotNull(expectedObject)
		Assert.assertTrue(obj.equals(expectedObject!!))

		expectedCallee?.dispose()
		expectedObject?.dispose()

		obj.dispose()

		Assert.assertTrue(didCallCallback)
	}

	@Test
	fun testArguments() {

		val fn = this.context.createFunction(fun(callback: JavaScriptFunctionCallback) {

			Assert.assertEquals(callback.arguments, 3)

			val arg0 = callback.argument(0)
			val arg1 = callback.argument(1)
			val arg2 = callback.argument(2)

			Assert.assertTrue(arg0.isString)
			Assert.assertTrue(arg1.isNumber)
			Assert.assertTrue(arg2.isBoolean)

			arg0.dispose()
			arg1.dispose()
			arg2.dispose()

			Assert.assertEquals(callback.argument(0).string, "")
			Assert.assertEquals(callback.argument(1).number, 10.0, 0.0)
			Assert.assertEquals(callback.argument(2).boolean, true)
		})

		val arg0 = this.context.createString("")
		val arg1 = this.context.createNumber(10.0)
		val arg2 = this.context.createBoolean(true)

		fn.call(arrayOf(arg0, arg1, arg2), null, null)
		fn.dispose()

		arg0.dispose()
		arg1.dispose()
		arg2.dispose()
	}

	@Test
	fun testReturnValue() {

		val function = fun(callback: JavaScriptFunctionCallback) {
			val value = callback.context.createNumber(10.0)
			callback.returns(value)
			value.dispose()
		}

		val result = this.call(function, null)
		Assert.assertTrue(result.isNumber)
		result.dispose()
	}

	@Test
	fun testReturnValueWithString() {

		val function = fun(callback: JavaScriptFunctionCallback) {
			callback.returns("")
		}

		val result = this.call(function, null)
		Assert.assertTrue(result.isString)
		result.dispose()
	}

	@Test
	fun testReturnValueWithNumber() {

		val function = fun(callback: JavaScriptFunctionCallback) {
			callback.returns(10.0)
		}

		val result = this.call(function, null)
		Assert.assertTrue(result.isNumber)
		result.dispose()
	}

	@Test
	fun testReturnValueWithBoolean() {

		val function = fun(callback: JavaScriptFunctionCallback) {
			callback.returns(true)
		}

		val result = this.call(function, null)
		Assert.assertTrue(result.isBoolean)
		result.dispose()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	private fun call(fn: JavaScriptFunctionHandler, target: JavaScriptValue?): JavaScriptValue {
		val result = context.createReturnValue()
		val function = context.createFunction(fn)
		function.call(null, target, result)
		function.dispose()
		return result
	}
}
