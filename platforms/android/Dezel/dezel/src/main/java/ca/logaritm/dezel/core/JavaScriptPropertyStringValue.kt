package ca.logaritm.dezel.core

import ca.logaritm.dezel.extension.type.toNumber

/**
 * @class JavaScriptPropertyStringValue
 * @super JavaScriptPropertyValue
 * @since 0.7.0
 */
open class JavaScriptPropertyStringValue(value: String): JavaScriptPropertyValue(JavaScriptPropertyType.STRING) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property value
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
	 */
	init {
		this.value = value
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override fun toString(): String {
		return this.value
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	override fun toNumber(): Double {
		return this.value.toNumber()
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override fun toBoolean(): Boolean {
		return this.value.isEmpty() == false
	}
}