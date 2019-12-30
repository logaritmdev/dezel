package ca.logaritm.dezel.core

import ca.logaritm.dezel.classes.ValueClass
import org.junit.Assert
import org.junit.Before
import org.junit.Test

public class JavaScriptValueTest {

	private var context: JavaScriptContext = JavaScriptContext()

	@Before
	fun beforeTest() {
		this.context.dispose()
		this.context = JavaScriptContext()
	}

	@Test
	fun testEquality() {

		val null1 = this.context.createNull()
		val null2 = this.context.createNull()

		Assert.assertTrue(null1.equals(null2))

		null1.dispose()
		null2.dispose()

		val undefined1 = this.context.createUndefined()
		val undefined2 = this.context.createUndefined()

		Assert.assertTrue(undefined1.equals(undefined2))

		undefined1.dispose()
		undefined2.dispose()

		val boolean1 = this.context.createBoolean(true)
		val boolean2 = this.context.createBoolean(true)
		val boolean3 = this.context.createBoolean(false)

		Assert.assertTrue(boolean1.equals(true))
		Assert.assertTrue(boolean1.equals(boolean2))
		Assert.assertFalse(boolean1.equals(boolean3))

		boolean1.dispose()
		boolean2.dispose()
		boolean3.dispose()

		val string1 = this.context.createString("a")
		val string2 = this.context.createString("a")
		val string3 = this.context.createString("b")

		Assert.assertTrue(string1.equals("a"))
		Assert.assertTrue(string1.equals(string2))
		Assert.assertFalse(string1.equals(string3))

		string1.dispose()
		string2.dispose()
		string3.dispose()

		val number1 = this.context.createNumber(1.0)
		val number2 = this.context.createNumber(1.0)
		val number3 = this.context.createNumber(2.0)

		Assert.assertTrue(number1.equals(1.0))
		Assert.assertTrue(number1.equals(number2))
		Assert.assertFalse(number1.equals(number3))

		number1.dispose()
		number2.dispose()
		number3.dispose()

		val obj1 = this.context.createEmptyObject()
		val obj2 = this.context.createEmptyObject()

		Assert.assertFalse(obj1.equals(obj2))

		obj1.dispose()
		obj2.dispose()
	}

	@Test
	fun testPropertyDefinition() {

		val obj = this.context.createEmptyObject()
		val num = this.context.createNumber(10.0)

		var didCallGetter = false
		var didCallSetter = false

		val getter = fun(callback: JavaScriptGetterCallback) {
			didCallGetter = true
		}

		val setter = fun(callback: JavaScriptSetterCallback) {
			didCallSetter = true
		}

		obj.defineProperty("property", null, getter, setter, false, false, false)

		obj.property("property").dispose()
		obj.property("property", num)
		obj.dispose()
		num.dispose()

		Assert.assertTrue(didCallGetter)
		Assert.assertTrue(didCallSetter)
	}

	@Test
	fun testPropertiesWithValues() {

		val src = this.context.createEmptyObject()
		val obj = this.context.createEmptyObject()

		src.property("key1", obj)
		src.property("key2", obj)
		src.property("key2", null)

		val res1 = src.property("key1")
		val res2 = src.property("key2")
		val res3 = src.property("keyX")

		src.dispose()

		Assert.assertTrue(res1.equals(obj))
		Assert.assertTrue(res2.isNull)
		Assert.assertTrue(res3.isUndefined)

		res3.dispose()
		res2.dispose()
		res1.dispose()
		obj.dispose()
	}

	@Test
	fun testPropertiesWithString() {

		val obj = this.context.createEmptyObject()

		obj.property("key1", "val1")

		val res = obj.property("key1")

		Assert.assertTrue(res.isString)
		Assert.assertEquals(obj.property("key1").string, "val1")
		Assert.assertEquals(obj.property("keyX").string, "undefined")

		res.dispose()
		obj.dispose()
	}

	@Test
	fun testPropertiesWithNumber() {

		val obj = this.context.createEmptyObject()

		obj.property("key1", 10.0)

		val res = obj.property("key1")

		Assert.assertTrue(res.isNumber)
		Assert.assertEquals(obj.property("key1").number, 10.0, 0.0)
		Assert.assertEquals(obj.property("keyX").number, java.lang.Double.NaN, 0.0)

		res.dispose()
		obj.dispose()
	}

	@Test
	fun testPropertiesWithBoolean() {

		val obj = this.context.createEmptyObject()

		obj.property("key1", true)

		val res = obj.property("key1")

		Assert.assertTrue(res.isBoolean)
		Assert.assertEquals(obj.property("key1").boolean, true)
		Assert.assertEquals(obj.property("keyX").boolean, false)

		res.dispose()
		obj.dispose()
	}

	@Test
	fun testPropertiesAtIndexWithValues() {

		val src = this.context.createEmptyObject()
		val obj = this.context.createEmptyObject()

		src.property(0, obj)

		val res1 = src.property(0)
		val res2 = src.property(1)

		src.dispose()

		Assert.assertTrue(res1.equals(obj))
		Assert.assertTrue(res2.isUndefined)

		res2.dispose()
		res1.dispose()
		obj.dispose()
	}

	@Test
	fun testPropertiesAtIndexWithString() {

		val obj = this.context.createEmptyObject()

		obj.property(0, "val1")

		val res = obj.property(0)

		Assert.assertTrue(res.isString)
		Assert.assertEquals(obj.property(0).string, "val1")
		Assert.assertEquals(obj.property(3).string, "undefined")

		res.dispose()
		obj.dispose()
	}

	@Test
	fun testPropertiesAtIndexWithNumber() {

		val obj = this.context.createEmptyObject()

		obj.property(0, 10.0)

		val res = obj.property(0)

		Assert.assertTrue(res.isNumber)
		Assert.assertEquals(obj.property(0).number, 10.0, 0.0)
		Assert.assertEquals(obj.property(3).number, java.lang.Double.NaN, 0.0)

		res.dispose()
		obj.dispose()
	}

	@Test
	fun testPropertiesAtIndexWithBoolean() {

		val obj = this.context.createEmptyObject()

		obj.property(0, true)

		val res = obj.property(0)

		Assert.assertTrue(res.isBoolean)
		Assert.assertEquals(obj.property(0).boolean, true)
		Assert.assertEquals(obj.property(3).boolean, false)

		res.dispose()
		obj.dispose()
	}

	@Test
	fun testCall() {

		val obj = this.context.createEmptyObject()
		val argument1 = this.context.createNumber(10.0)
		val argument2 = this.context.createString("a")

		var didCallCallback = false
		var expectedCallee: JavaScriptValue? = null
		var expectedObject: JavaScriptValue? = null
		var expectedContext: JavaScriptContext? = null

		val callback = fun(callback: JavaScriptFunctionCallback) {

			Assert.assertEquals(callback.arguments, 2)

			expectedCallee = callback.callee
			expectedObject = callback.target
			expectedContext = callback.context

			val arg0 = callback.argument(0)
			val arg1 = callback.argument(1)

			Assert.assertTrue(arg0.isNumber)
			Assert.assertTrue(arg1.isString)

			arg1.dispose()
			arg0.dispose()

			didCallCallback = true
		}

		val value1 = this.context.createFunction(callback)
		val value2 = this.context.createFunction(returnNullFunction)
		val value3 = this.context.createFunction(returnUndefinedFunction)
		val value4 = this.context.createFunction(returnBooleanFunction)
		val value5 = this.context.createFunction(returnNumberFunction)
		val value6 = this.context.createFunction(returnStringFunction)
		val value7 = this.context.createFunction(returnObjectFunction)

		val res1 = context.createReturnValue()
		val res2 = context.createReturnValue()
		val res3 = context.createReturnValue()
		val res4 = context.createReturnValue()
		val res5 = context.createReturnValue()
		val res6 = context.createReturnValue()
		val res7 = context.createReturnValue()

		value1.call(arrayOf(argument1, argument2), obj, res1)

		argument1.dispose()
		argument2.dispose()

		Assert.assertTrue(expectedCallee!!.equals(value1))
		Assert.assertTrue(expectedCallee!!.isFunction)
		Assert.assertTrue(expectedObject!!.equals(obj))
		Assert.assertTrue(expectedObject!!.isObject)
		Assert.assertTrue(expectedContext == this.context)

		expectedCallee?.dispose()
		expectedObject?.dispose()

		obj.dispose()

		value2.call(null, null, res2)
		value3.call(null, null, res3)
		value4.call(null, null, res4)
		value5.call(null, null, res5)
		value6.call(null, null, res6)
		value7.call(null, null, res7)

		value1.dispose()
		value2.dispose()
		value3.dispose()
		value4.dispose()
		value5.dispose()
		value6.dispose()
		value7.dispose()

		Assert.assertTrue(res1.isUndefined)
		Assert.assertTrue(res2.isNull)
		Assert.assertTrue(res3.isUndefined)
		Assert.assertTrue(res4.isBoolean)
		Assert.assertTrue(res5.isNumber)
		Assert.assertTrue(res6.isString)
		Assert.assertTrue(res7.isObject)

		res1.dispose()
		res2.dispose()
		res3.dispose()
		res4.dispose()
		res5.dispose()
		res6.dispose()
		res7.dispose()

		Assert.assertTrue(didCallCallback)
	}

	@Test
	fun testCallWithoutArguments() {

		val obj = this.context.createEmptyObject()
		val argument1 = this.context.createNumber(10.0)
		val argument2 = this.context.createString("a")

		var didCallCallback = false

		val callback = fun(callback: JavaScriptFunctionCallback) {
			Assert.assertEquals(callback.arguments, 0)
			didCallCallback = true
		}

		val function = this.context.createFunction(callback)
		function.call()
		function.dispose()

		argument2.dispose()
		argument1.dispose()
		obj.dispose()

		Assert.assertTrue(didCallCallback)
	}

	@Test
	fun testCallMethod() {

		val obj = this.context.createEmptyObject()
		val argument1 = this.context.createNumber(10.0)
		val argument2 = this.context.createString("a")

		var didCallCallback = false
		var expectedCallee: JavaScriptValue? = null
		var expectedObject: JavaScriptValue? = null
		var expectedContext: JavaScriptContext? = null

		val callback = fun(callback: JavaScriptFunctionCallback) {

			expectedCallee = callback.callee
			expectedObject = callback.target
			expectedContext = context

			Assert.assertEquals(callback.arguments, 2)

			val arg0 = callback.argument(0)
			val arg1 = callback.argument(1)

			Assert.assertTrue(arg0.isNumber)
			Assert.assertTrue(arg1.isString)

			arg1.dispose()
			arg0.dispose()

			didCallCallback = true
		}

		val value1 = this.context.createFunction(callback)
		val value2 = this.context.createFunction(returnNullFunction)
		val value3 = this.context.createFunction(returnUndefinedFunction)
		val value4 = this.context.createFunction(returnBooleanFunction)
		val value5 = this.context.createFunction(returnNumberFunction)
		val value6 = this.context.createFunction(returnStringFunction)
		val value7 = this.context.createFunction(returnObjectFunction)

		obj.property("method1", value1)
		obj.property("method2", value2)
		obj.property("method3", value3)
		obj.property("method4", value4)
		obj.property("method5", value5)
		obj.property("method6", value6)
		obj.property("method7", value7)

		val res1 = context.createReturnValue()
		val res2 = context.createReturnValue()
		val res3 = context.createReturnValue()
		val res4 = context.createReturnValue()
		val res5 = context.createReturnValue()
		val res6 = context.createReturnValue()
		val res7 = context.createReturnValue()

		obj.callMethod("method1", arrayOf(argument1, argument2), res1)

		argument2.dispose()
		argument1.dispose()

		Assert.assertTrue(expectedCallee!!.equals(value1))
		Assert.assertTrue(expectedCallee!!.isFunction)
		Assert.assertTrue(expectedObject!!.equals(obj))
		Assert.assertTrue(expectedObject!!.isObject)
		Assert.assertTrue(expectedContext == this.context)

		expectedCallee?.dispose()
		expectedObject?.dispose()

		value1.dispose()
		value2.dispose()
		value3.dispose()
		value4.dispose()
		value5.dispose()
		value6.dispose()
		value7.dispose()

		obj.callMethod("method2", null, res2)
		obj.callMethod("method3", null, res3)
		obj.callMethod("method4", null, res4)
		obj.callMethod("method5", null, res5)
		obj.callMethod("method6", null, res6)
		obj.callMethod("method7", null, res7)
		obj.dispose()

		Assert.assertTrue(res1.isUndefined)
		Assert.assertTrue(res2.isNull)
		Assert.assertTrue(res3.isUndefined)
		Assert.assertTrue(res4.isBoolean)
		Assert.assertTrue(res5.isNumber)
		Assert.assertTrue(res6.isString)
		Assert.assertTrue(res7.isObject)

		res1.dispose()
		res2.dispose()
		res3.dispose()
		res4.dispose()
		res5.dispose()
		res6.dispose()
		res7.dispose()

		Assert.assertTrue(didCallCallback)
	}

	@Test
	fun testCallMethodWithoutArguments() {

		val obj = this.context.createEmptyObject()
		val argument1 = this.context.createNumber(10.0)
		val argument2 = this.context.createString("a")

		var didCallCallback = false

		val callback = fun(callback: JavaScriptFunctionCallback) {
			Assert.assertEquals(callback.arguments, 0)
			didCallCallback = true
		}

		val value = this.context.createFunction(callback)
		obj.property("method1", value)
		obj.callMethod("method1")
		obj.dispose()

		value.dispose()
		argument2.dispose()
		argument1.dispose()

		Assert.assertTrue(didCallCallback)
	}

	@Test
	fun testConstruct() {

		val argument1 = this.context.createNumber(10.0)
		val argument2 = this.context.createString("a")

		var didCallCallback = false
		var expectedCallee: JavaScriptValue? = null
		var expectedObject: JavaScriptValue? = null
		var expectedContext: JavaScriptContext? = null

		val callback = fun(callback: JavaScriptFunctionCallback) {

			expectedCallee = callback.callee
			expectedObject = callback.target
			expectedContext = context

			val arg0 = callback.argument(0)
			val arg1 = callback.argument(1)

			Assert.assertEquals(callback.arguments, 2)
			Assert.assertTrue(arg0.isNumber)
			Assert.assertTrue(arg1.isString)

			arg1.dispose()
			arg0.dispose()

			didCallCallback = true
		}

		val value1 = this.context.createFunction(callback)
		val value2 = this.context.createFunction(returnNullFunction)
		val value3 = this.context.createFunction(returnUndefinedFunction)
		val value4 = this.context.createFunction(returnBooleanFunction)
		val value5 = this.context.createFunction(returnStringFunction)
		val value6 = this.context.createFunction(returnNumberFunction)
		val value7 = this.context.createFunction(returnObjectFunction)

		val res1 = this.context.createReturnValue()
		val res2 = this.context.createReturnValue()
		val res3 = this.context.createReturnValue()
		val res4 = this.context.createReturnValue()
		val res5 = this.context.createReturnValue()
		val res6 = this.context.createReturnValue()
		val res7 = this.context.createReturnValue()

		value1.construct(arrayOf(argument1, argument2), res1)



		argument2.dispose()
		argument1.dispose()

		Assert.assertTrue(expectedCallee!!.isFunction)
		Assert.assertTrue(expectedObject!!.isObject)
		Assert.assertTrue(expectedContext == this.context)

		expectedCallee?.dispose()
		expectedObject?.dispose()

		value2.construct(null, res2)
		value3.construct(null, res3)
		value4.construct(null, res4)
		value5.construct(null, res5)
		value6.construct(null, res6)
		value7.construct(null, res7)

		value1.dispose()
		value2.dispose()
		value3.dispose()
		value4.dispose()
		value5.dispose()
		value6.dispose()
		value7.dispose()

		Assert.assertEquals(res1.isObject, true)
		Assert.assertEquals(res2.isObject, true)
		Assert.assertEquals(res3.isObject, true)
		Assert.assertEquals(res4.isObject, true)
		Assert.assertEquals(res5.isObject, true)
		Assert.assertEquals(res6.isObject, true)
		Assert.assertEquals(res7.isObject, true)

		res1.dispose()
		res2.dispose()
		res3.dispose()
		res4.dispose()
		res5.dispose()
		res6.dispose()
		res7.dispose()

		Assert.assertTrue(didCallCallback)
	}

	@Test
	fun testConstructWithoutArguments() {

		var didCallCallback = false

		val callback = fun(callback: JavaScriptFunctionCallback) {
			Assert.assertEquals(callback.arguments, 0)
			didCallCallback = true
		}

		val function = this.context.createFunction(callback)
		function.construct()
		function.dispose()

		Assert.assertTrue(didCallCallback)
	}

	@Test
	fun testPrototypes() {

		val src = this.context.createEmptyObject()
		val obj = this.context.createEmptyObject()

		val res1 = src.prototype()
		src.prototype(obj)
		val res2 = src.prototype()

		src.dispose()

		Assert.assertTrue(res1.isObject)
		Assert.assertTrue(res2.isObject)
		Assert.assertTrue(res1.equals(obj) == false)
		Assert.assertTrue(res2.equals(obj))

		obj.dispose()
		res2.dispose()
		res1.dispose()
	}

	@Test
	fun testAttributes() {
		// TODO
//        val obj = this.context.createEmptyObject()
//
//        val key1 = Any()
//        val key2 = Any()
//        val toValue = Any()
//
//        obj.attribute(key1, toValue)
//
//        Assert.assertEquals(obj.attribute(key1), toValue)
//        Assert.assertEquals(obj.attribute(key2), null)
//
//        obj.deleteAttribute(key1)
//
//        Assert.assertEquals(obj.attribute(key1), null)
	}

	@Test
	fun testCast() {

		val res = context.createReturnValue()
		val obj = context.createClass(ValueClass::class.java)

		obj.construct(null, res)

		val instance = res.cast(ValueClass::class.java)

		if (instance != null) {
			Assert.assertTrue(true)
			return
		}

		Assert.fail()
	}

	@Test
	fun testFinalizer() {
		/*
	TODO:FIND HOW TO TEST THIS
		final CountDownLatch signal = new CountDownLatch(1);

		final JavaScriptValueTest self = this;

		for (int i = 0; i < 100; i++) {

			JavaScriptValue object = layout.createEmptyObject();

			object.setFinalizeCallback(new Finalize() {
				@Override
				public void execute() {
					assertTrue(true);
					signal.countDown();
				}
			});

			object.dispose();

			layout.garbageCollect();
		}

		try {
			signal.await();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		*/
	}

	//--------------------------------------------------------------------------
	// Utility
	//--------------------------------------------------------------------------

	private var returnNullFunction = fun(callback: JavaScriptFunctionCallback) {
		callback.returns(callback.context.createNull())
	}

	private var returnUndefinedFunction = fun(callback: JavaScriptFunctionCallback) {
		callback.returns(callback.context.createUndefined())
	}

	private var returnBooleanFunction = fun(callback: JavaScriptFunctionCallback) {
		callback.returns(callback.context.createBoolean(true))
	}

	private var returnNumberFunction = fun(callback: JavaScriptFunctionCallback) {
		callback.returns(callback.context.createNumber(10.0))
	}

	private var returnStringFunction = fun(callback: JavaScriptFunctionCallback) {
		callback.returns(callback.context.createString("a"))
	}

	private var returnObjectFunction = fun(callback: JavaScriptFunctionCallback) {
		callback.returns(callback.context.createEmptyObject())
	}
}
