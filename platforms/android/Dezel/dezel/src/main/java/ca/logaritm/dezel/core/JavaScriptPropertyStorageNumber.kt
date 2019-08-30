package ca.logaritm.dezel.core

import ca.logaritm.dezel.extension.type.toStr

/**
 * @class JavaScriptPropertyStorageNumber
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyStorageNumber(value: Double, unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE): JavaScriptPropertyStorage(JavaScriptPropertyType.NUMBER, unit) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property value
	 * @since 0.7.0
	 * @hidden
	 */
	private var value: Double

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {
		this.value = value
	}

	/**
	 * @inherited
	 * @method toString
	 * @since 0.7.0
	 */
	override fun toString(): String {

		val string = StringBuilder(this.value.toStr())

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
	 * @inherited
	 * @method toNumber
	 * @since 0.7.0
	 */
	override fun toNumber(): Double {
		return this.value
	}

	/**
	 * @inherited
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override fun toBoolean(): Boolean {
		return this.value > 0
	}
}