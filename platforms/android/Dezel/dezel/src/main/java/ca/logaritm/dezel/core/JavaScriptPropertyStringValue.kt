package ca.logaritm.dezel.core

import ca.logaritm.dezel.extension.type.toNumber

/**
 * @class JavaScriptPropertyStringValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyStringValue(value: String): JavaScriptPropertyValue(JavaScriptPropertyType.STRING) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property data
	 * @since 0.7.0
	 * @hidden
	 */
	private var value: String

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
		return this.value
	}

	/**
	 * @inherited
	 * @method toNumber
	 * @since 0.7.0
	 */
	override fun toNumber(): Double {
		return this.value.toNumber()
	}

	/**
	 * @inherited
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override fun toBoolean(): Boolean {
		return this.value.isEmpty() == false
	}
}