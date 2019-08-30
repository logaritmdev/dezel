package ca.logaritm.dezel.core

/**
 * @class JavaScriptPropertyStorageBoolean
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyStorageBoolean(boolean: Boolean): JavaScriptPropertyStorage(JavaScriptPropertyType.BOOLEAN) {

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
	 * @hidden
	 */
	init {
		this.value = boolean
	}

	/**
	 * @inherited
	 * @method toString
	 * @since 0.7.0
	 */
	override fun toString(): String {
		return if (this.value) "true" else "false"
	}

	/**
	 * @inherited
	 * @method toNumber
	 * @since 0.7.0
	 */
	override fun toNumber(): Double {
		return if (this.value) 1.0 else 0.0
	}

	/**
	 * @inherited
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override fun toBoolean(): Boolean {
		return this.value
	}
}