package ca.logaritm.dezel.core

import ca.logaritm.dezel.ContextTestClassA
import ca.logaritm.dezel.ContextTestObject
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class JavaScriptContextTest {

	private var context: JavaScriptContext = JavaScriptContext()
	private var expectedCallee: JavaScriptValue? = null
	private var expectedObject: JavaScriptValue? = null
	private var expectedContext: JavaScriptContext? = null

	@Before
	fun beforeTest() {
		this.context.dispose()
		this.context = JavaScriptContext()
		this.expectedCallee = null
		this.expectedObject = null
		this.expectedContext = null
	}

	@Test
	fun testValueCreateWithNull() {
		val value = this.context.createNull()
		Assert.assertTrue(value.isNull)
		value.dispose()
	}

	@Test
	fun testValueCreatedWithUndefined() {
		val value = this.context.createUndefined()
		Assert.assertTrue(value.isUndefined)
		value.dispose()
	}

	@Test
	fun testValueCreatedWithBoolean() {
		val value = this.context.createBoolean(true)
		Assert.assertTrue(value.isBoolean)
		Assert.assertEquals(value.boolean, true)
		value.dispose()
	}

	@Test
	fun testValueCreatedWithString() {
		val value = this.context.createString("foo")
		Assert.assertTrue(value.isString)
		Assert.assertEquals(value.string, "foo")
		value.dispose()
	}

	@Test
	fun testValueCreatedWithNumber() {
		val value = this.context.createNumber(10.0)
		Assert.assertTrue(value.isNumber)
		Assert.assertEquals(value.number, 10.0, 0.0)
		value.dispose()
	}

	@Test
	fun testValueCreatedWithObject() {
		val value = this.context.createEmptyObject()
		Assert.assertTrue(value.isObject)
		value.dispose()
	}

	@Test
	fun testValueCreatedWithFunction() {
		val value = this.context.createFunction(fun(callback: JavaScriptFunctionCallback) {})
		Assert.assertTrue(value.isFunction)
		value.dispose()
	}

	@Test
	fun testEvaluation() {
		this.context.evaluate("1 + 2")
	}

	@Test
	fun testGlobalVariables() {

		val obj = this.context.createEmptyObject()
		this.context.global.property("value", obj)
		val result = this.context.global.property("value")
		Assert.assertTrue(obj.equals(result))
		result.dispose()
		obj.dispose()

		this.context.global.property("value", "test_string")
		Assert.assertEquals(this.context.global.property("value").string, "test_string")

		this.context.global.property("value", 10.0)
		Assert.assertEquals(this.context.global.property("value").number, 10.0, 0.0)

		this.context.global.property("value", true)
		Assert.assertEquals(this.context.global.property("value").boolean, true)

		this.context.global.property("value", null)
		Assert.assertEquals(this.context.global.property("value").string, "null")
	}

	@Test
	fun testBridgedObjectCreation() {
		val objectA = this.context.createObject(ContextTestObject::class.java)
		objectA.dispose()
	}

	@Test
	fun testClassTemplateCreation() {
		val classA = this.context.createClass(ContextTestClassA::class.java)
		classA.dispose()
	}

	@Test
	fun testAttributes() {

		val value = Object()

		this.context.attribute("key1", value)

		Assert.assertEquals(this.context.attribute("key1"), value)
		Assert.assertEquals(this.context.attribute("key2"), null)

		this.context.attribute("key1", null)

		Assert.assertEquals(this.context.attribute("key1"), null)
	}

	@Test
	fun testExceptionHandler() {

		var didCallExceptionHandler = false

		this.context.handleError { error ->
			didCallExceptionHandler = true
		}

		this.context.evaluate("a + b")

		Assert.assertTrue(didCallExceptionHandler)
	}

	companion object {
		var testFunctionCallback: JavaScriptFunctionHandler? = null
		var testConstructorACallback: JavaScriptFunctionHandler? = null
		var testConstructorBCallback: JavaScriptFunctionHandler? = null
		var testPropertyGetterCallback: JavaScriptGetterHandler? = null
		var testPropertySetterCallback: JavaScriptSetterHandler? = null
	}
}
