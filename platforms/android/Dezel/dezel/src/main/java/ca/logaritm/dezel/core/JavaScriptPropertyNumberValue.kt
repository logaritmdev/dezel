package ca.logaritm.dezel.core

import ca.logaritm.dezel.extension.type.toStr

/**
 * @class JavaScriptPropertyNumberValue
 * @super JavaScriptPropertyValue
 * @since 0.7.0
 */
open class JavaScriptPropertyNumberValue(value: Double, unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE): JavaScriptPropertyValue(JavaScriptPropertyType.NUMBER, unit) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property value
	 * @since 0.7.0
	 * @hidden
	 */
	private var data: Double

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {
		this.data = value
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override fun toString(): String {

		val string = StringBuilder(this.data.toStr())

		when (this.unit) {
			JavaScriptPropertyUnit.PX  -> string.append("px")
			JavaScriptPropertyUnit.PC  -> string.append("%")
			JavaScriptPropertyUnit.VW  -> string.append("vw")
			JavaScriptPropertyUnit.VH  -> string.append("vh")
			JavaScriptPropertyUnit.PW  -> string.append("pw")
			JavaScriptPropertyUnit.PH  -> string.append("ph")
			JavaScriptPropertyUnit.CW  -> string.append("cw")
			JavaScriptPropertyUnit.CH  -> string.append("ch")
			JavaScriptPropertyUnit.DEG -> string.append("deg")
			JavaScriptPropertyUnit.RAD -> string.append("rad")
			else                       -> {}
		}

		return string.toString()
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	override fun toNumber(): Double {
		return this.data
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override fun toBoolean(): Boolean {
		return this.data > 0
	}
}