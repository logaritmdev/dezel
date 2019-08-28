package ca.logaritm.dezel.core

/**
 * @class JavaScriptPropertyData
 * @since 0.7.0
 * @hidden
 */
abstract class JavaScriptPropertyData(context: JavaScriptContext) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The JavaScript context.
	 * @property context
	 * @since 0.7.0
	 */
	public val context: JavaScriptContext = context

	/**
	 * Indicate whether the property is null.
	 * @property isNull
	 * @since 0.7.0
	 */
	public val isNull: Boolean
		get() = this.type() == JavaScriptPropertyType.NULL

	/**
	 * Indicate whether the property is a string.
	 * @property isString
	 * @since 0.7.0
	 */
	public val isString: Boolean
		get() = this.type() == JavaScriptPropertyType.STRING

	/**
	 * Convenience property to indicate whether the property is a number.
	 * @property isNumber
	 * @since 0.7.0
	 */
	public val isNumber: Boolean
		get() = this.type() == JavaScriptPropertyType.NUMBER

	/**
	 * Convenience property to indicate whether the property is a boolean.
	 * @property isBoolean
	 * @since 0.7.0
	 */
	public val isBoolean: Boolean
		get() = this.type() == JavaScriptPropertyType.BOOLEAN

	/**
	 * The existing JavaScript value.
	 * @property value
	 * @since 0.7.0
	 */
	abstract var value: JavaScriptValue?

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Returns the data type.
	 * @method type
	 * @since 0.7.0
	 */
	abstract fun type(): JavaScriptPropertyType

	/**
	 * Returns the data unit.
	 * @method unit
	 * @since 0.7.0
	 */
	abstract fun unit(): JavaScriptPropertyUnit

	/**
	 * Returns the data as a JavaScript value.
	 * @method value
	 * @since 0.7.0
	 */
	abstract fun value(): JavaScriptValue

	/**
	 * Returns the data as a string.
	 * @method string
	 * @since 0.7.0
	 */
	abstract fun string(): String

	/**
	 * Returns the data as a number.
	 * @method number
	 * @since 0.7.0
	 */
	abstract fun number(): Double

	/**
	 * Returns the data as a boolean.
	 * @method boolean
	 * @since 0.7.0
	 */
	abstract fun boolean(): Boolean

	/**
	 * Check data equality.
	 * @method equal
	 * @since 0.7.0
	 */
	abstract fun equal(value: JavaScriptValue): Boolean

	/**
	 * Check data equality.
	 * @method equal
	 * @since 0.7.0
	 */
	abstract fun equal(string: String): Boolean

	/**
	 * Check data equality.
	 * @method equal
	 * @since 0.7.0
	 */
	abstract fun equal(number: Double): Boolean

	/**
	 * Check data equality.
	 * @method equal
	 * @since 0.7.0
	 */
	abstract fun equal(boolean: Boolean): Boolean
}