package ca.logaritm.dezel.core

/**
 * @class JavaScriptPropertyBooleanValue
 * @super JavaScriptPropertyValue
 * @since 0.7.0
 */
open class JavaScriptPropertyBooleanValue(boolean: Boolean): JavaScriptPropertyValue(JavaScriptPropertyType.BOOLEAN) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property value
	 * @since 0.7.0
	 * @hidden
	 */
	private var value: Boolean

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {
		this.value = boolean
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override fun toString(): String {
		return if (this.value) "true" else "false"
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	override fun toNumber(): Double {
		return if (this.value) 1.0 else 0.0
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override fun toBoolean(): Boolean {
		return this.value
	}
}