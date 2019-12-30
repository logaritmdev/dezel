package ca.logaritm.dezel.core

import android.util.Log
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class JavaScriptPropertyTest {

	private var context: JavaScriptContext = JavaScriptContext()

	@Before
	fun beforeTest() {
		this.context.dispose()
		this.context = JavaScriptContext()
	}
	
	@Test
	fun testPropertyCreatedWithNull() {

		val property = JavaScriptProperty()

		Assert.assertEquals(property.type, JavaScriptPropertyType.NULL)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.NONE)

		Assert.assertEquals(property.isNull, true)
		Assert.assertEquals(property.isString, false)
		Assert.assertEquals(property.isNumber, false)
		Assert.assertEquals(property.isBoolean, false)
		Assert.assertEquals(property.isObject, false)
		Assert.assertEquals(property.isArray, false)

		Assert.assertEquals(property.string, "")
		Assert.assertEquals(property.number, 0.0, 0.0)
		Assert.assertEquals(property.boolean, false)
	}

	@Test
	fun testPropertyCreateWithString() {

		val property = JavaScriptProperty("test")

		Assert.assertEquals(property.type, JavaScriptPropertyType.STRING)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.NONE)

		Assert.assertEquals(property.isNull, false)
		Assert.assertEquals(property.isString, true)
		Assert.assertEquals(property.isNumber, false)
		Assert.assertEquals(property.isBoolean, false)
		Assert.assertEquals(property.isObject, false)
		Assert.assertEquals(property.isArray, false)

		Assert.assertEquals(property.string, "test")
		Assert.assertEquals(property.number.isNaN(), true)
		Assert.assertEquals(property.boolean, true)
	}

	@Test
	fun testPropertyCreatedWithNumber() {

		val property = JavaScriptProperty(14.0)

		Assert.assertEquals(property.type, JavaScriptPropertyType.NUMBER)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.NONE)

		Assert.assertEquals(property.isNull, false)
		Assert.assertEquals(property.isString, false)
		Assert.assertEquals(property.isNumber, true)
		Assert.assertEquals(property.isBoolean, false)
		Assert.assertEquals(property.isObject, false)
		Assert.assertEquals(property.isArray, false)

		Assert.assertEquals(property.string, "14")
		Assert.assertEquals(property.number, 14.0, 0.0)
		Assert.assertEquals(property.boolean, true)
	}

	@Test
	fun testPropertyCreatedWithNumberAndUnit() {

		val property = JavaScriptProperty(14.0, JavaScriptPropertyUnit.PX)

		Assert.assertEquals(property.type, JavaScriptPropertyType.NUMBER)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.PX)

		Assert.assertEquals(property.isNull, false)
		Assert.assertEquals(property.isString, false)
		Assert.assertEquals(property.isNumber, true)
		Assert.assertEquals(property.isBoolean, false)
		Assert.assertEquals(property.isObject, false)
		Assert.assertEquals(property.isArray, false)

		Assert.assertEquals(property.string, "14px")
		Assert.assertEquals(property.number, 14.0, 0.0)
		Assert.assertEquals(property.boolean, true)
	}

	@Test
	fun testPropertyCreatedWithBoolean() {

		val property = JavaScriptProperty(true)

		Assert.assertEquals(property.type, JavaScriptPropertyType.BOOLEAN)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.NONE)

		Assert.assertEquals(property.isNull, false)
		Assert.assertEquals(property.isString, false)
		Assert.assertEquals(property.isNumber, false)
		Assert.assertEquals(property.isBoolean, true)
		Assert.assertEquals(property.isObject, false)
		Assert.assertEquals(property.isArray, false)

		Assert.assertEquals(property.string, "true")
		Assert.assertEquals(property.number, 1.0, 0.0)
		Assert.assertEquals(property.boolean, true)
	}

	@Test
	fun testPropertyStringConversion() {

		val n1 = JavaScriptProperty(5.0)
		val n2 = JavaScriptProperty(5.5)
		val n3 = JavaScriptProperty(-5.0)
		val n4 = JavaScriptProperty(-5.5)

		Assert.assertEquals(n1.string, "5")
		Assert.assertEquals(n2.string, "5.5")
		Assert.assertEquals(n3.string, "-5")
		Assert.assertEquals(n4.string, "-5.5")

		val npx = JavaScriptProperty(5.0, JavaScriptPropertyUnit.PX)
		val npc = JavaScriptProperty(5.0, JavaScriptPropertyUnit.PC)
		val nvw = JavaScriptProperty(5.0, JavaScriptPropertyUnit.VW)
		val nvh = JavaScriptProperty(5.0, JavaScriptPropertyUnit.VH)
		val npw = JavaScriptProperty(5.0, JavaScriptPropertyUnit.PW)
		val nph = JavaScriptProperty(5.0, JavaScriptPropertyUnit.PH)
		val ncw = JavaScriptProperty(5.0, JavaScriptPropertyUnit.CW)
		val nch = JavaScriptProperty(5.0, JavaScriptPropertyUnit.CH)

		Assert.assertEquals(npx.string, "5px")
		Assert.assertEquals(npc.string, "5%")
		Assert.assertEquals(nvw.string, "5vw")
		Assert.assertEquals(nvh.string, "5vh")
		Assert.assertEquals(npw.string, "5pw")
		Assert.assertEquals(nph.string, "5ph")
		Assert.assertEquals(ncw.string, "5cw")
		Assert.assertEquals(nch.string, "5ch")

		val b1 = JavaScriptProperty(true)
		val b2 = JavaScriptProperty(false)

		Assert.assertEquals(b1.string, "true")
		Assert.assertEquals(b2.string, "false")
	}

	@Test
	fun testPropertyNumberConversion() {

		val s1 = JavaScriptProperty("5.0")
		val s2 = JavaScriptProperty("5.5")
		val s3 = JavaScriptProperty("-5.0")
		val s4 = JavaScriptProperty("-5.5")

		Assert.assertEquals(s1.number, 5.0, 0.0)
		Assert.assertEquals(s2.number, 5.5, 0.0)
		Assert.assertEquals(s3.number, -5.0, 0.0)
		Assert.assertEquals(s4.number, -5.5, 0.0)

		val b1 = JavaScriptProperty(true)
		val b2 = JavaScriptProperty(false)

		Assert.assertEquals(b1.number, 1.0, 0.0)
		Assert.assertEquals(b2.number, 0.0, 0.0)
	}

	@Test
	fun testPropertyBooleanConversion() {

		val s1 = JavaScriptProperty("5.0")
		val s2 = JavaScriptProperty("0.0")
		val s3 = JavaScriptProperty("")
		val s4 = JavaScriptProperty("value")

		Assert.assertEquals(s1.boolean, true)
		Assert.assertEquals(s2.boolean, true)
		Assert.assertEquals(s3.boolean, false)
		Assert.assertEquals(s4.boolean, true)

		val b1 = JavaScriptProperty(5.0)
		val b2 = JavaScriptProperty(0.0)

		Assert.assertEquals(b1.boolean, true)
		Assert.assertEquals(b2.boolean, false)
	}

	@Test
	fun testResetWithJavaScriptStringValue() {

		val value = this.context.createString("test")

		val property = JavaScriptProperty()

		property.reset(value)

		Assert.assertEquals(property.type, JavaScriptPropertyType.STRING)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.NONE)

		Assert.assertEquals(property.string, "test")
		Assert.assertEquals(property.number.isNaN(), true)
		Assert.assertEquals(property.boolean, true)

		Assert.assertEquals(property.toHandle(this.context), value.handle)
	}

	@Test
	fun testResetWithJavaScriptStringWithUnitValue() {

		val px = this.context.createString("15px")
		val pc = this.context.createString("15%")
		val vw = this.context.createString("15vw")
		val vh = this.context.createString("15vh")
		val pw = this.context.createString("15pw")
		val ph = this.context.createString("15ph")
		val cw = this.context.createString("15cw")
		val ch = this.context.createString("15ch")

		val property = JavaScriptProperty()

		property.reset(px)

		Assert.assertEquals(property.type, JavaScriptPropertyType.NUMBER)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.PX)

		Assert.assertEquals(property.string, "15px")
		Assert.assertEquals(property.number, 15.0, 0.0)
		Assert.assertEquals(property.boolean, true)

		Assert.assertEquals(property.toHandle(this.context), px.handle)

		property.reset(pc)

		Assert.assertEquals(property.type, JavaScriptPropertyType.NUMBER)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.PC)

		Assert.assertEquals(property.string, "15%")
		Assert.assertEquals(property.number, 15.0, 0.0)
		Assert.assertEquals(property.boolean, true)

		Assert.assertEquals(property.toHandle(this.context), pc.handle)

		property.reset(vw)

		Assert.assertEquals(property.type, JavaScriptPropertyType.NUMBER)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.VW)

		Assert.assertEquals(property.string, "15vw")
		Assert.assertEquals(property.number, 15.0, 0.0)
		Assert.assertEquals(property.boolean, true)

		Assert.assertEquals(property.toHandle(this.context), vw.handle)

		property.reset(vh)

		Assert.assertEquals(property.type, JavaScriptPropertyType.NUMBER)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.VH)

		Assert.assertEquals(property.string, "15vh")
		Assert.assertEquals(property.number, 15.0, 0.0)
		Assert.assertEquals(property.boolean, true)

		Assert.assertEquals(property.toHandle(this.context), vh.handle)

		property.reset(pw)

		Assert.assertEquals(property.type, JavaScriptPropertyType.NUMBER)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.PW)

		Assert.assertEquals(property.string, "15pw")
		Assert.assertEquals(property.number, 15.0, 0.0)
		Assert.assertEquals(property.boolean, true)

		Assert.assertEquals(property.toHandle(this.context), pw.handle)

		property.reset(ph)

		Assert.assertEquals(property.type, JavaScriptPropertyType.NUMBER)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.PH)

		Assert.assertEquals(property.string, "15ph")
		Assert.assertEquals(property.number, 15.0, 0.0)
		Assert.assertEquals(property.boolean, true)

		Assert.assertEquals(property.toHandle(this.context), ph.handle)

		property.reset(cw)

		Assert.assertEquals(property.type, JavaScriptPropertyType.NUMBER)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.CW)

		Assert.assertEquals(property.string, "15cw")
		Assert.assertEquals(property.number, 15.0, 0.0)
		Assert.assertEquals(property.boolean, true)

		Assert.assertEquals(property.toHandle(this.context), cw.handle)

		property.reset(ch)

		Assert.assertEquals(property.type, JavaScriptPropertyType.NUMBER)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.CH)

		Assert.assertEquals(property.string, "15ch")
		Assert.assertEquals(property.number, 15.0, 0.0)
		Assert.assertEquals(property.boolean, true)

		Assert.assertEquals(property.toHandle(this.context), ch.handle)
	}

	@Test
	fun testResetWithJavaScriptNumberValue() {

		val value = this.context.createNumber(15.0)

		val property = JavaScriptProperty()

		property.reset(value)

		Assert.assertEquals(property.type, JavaScriptPropertyType.NUMBER)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.NONE)

		Assert.assertEquals(property.string, "15")
		Assert.assertEquals(property.number, 15.0, 0.0)
		Assert.assertEquals(property.boolean, true)

		Assert.assertEquals(property.toHandle(this.context), value.handle)
	}

	@Test
	fun testResetWithJavaScriptBooleanValue() {

		val value = this.context.createBoolean(true)

		val property = JavaScriptProperty()

		property.reset(value)

		Assert.assertEquals(property.type, JavaScriptPropertyType.BOOLEAN)
		Assert.assertEquals(property.unit, JavaScriptPropertyUnit.NONE)

		Assert.assertEquals(property.string, "true")
		Assert.assertEquals(property.number, 1.0, 0.0)
		Assert.assertEquals(property.boolean, true)

		Assert.assertEquals(property.toHandle(this.context), value.handle)
	}

	@Test
	fun testChangeCallback() {

		var called = false

		val property = JavaScriptProperty() { value ->
			called = true
		}

		property.reset("test")

		Assert.assertTrue(called)
	}

	@Test
	fun testChangeCallbackWithTypes() {

		var called = 0

		val property = JavaScriptProperty() { value ->
			called += 1
		}

		property.reset("test")
		property.reset("test")
		property.reset(10.0)
		property.reset(10.0, JavaScriptPropertyUnit.PX)
		property.reset(10.0, JavaScriptPropertyUnit.PX)
		property.reset(true)
		property.reset(true)

		Assert.assertEquals(called, 4)
	}
}
