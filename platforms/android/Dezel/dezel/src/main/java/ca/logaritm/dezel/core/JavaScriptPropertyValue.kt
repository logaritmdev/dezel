package ca.logaritm.dezel.core

/**
 * @class JavaScriptPropertyValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyValue(context: JavaScriptContext, value: JavaScriptValue) : JavaScriptPropertyData(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @property value
	 * @since 0.7.0
	 */
	override var value: JavaScriptValue? = value

	/**
	 * @property type
	 * @since 0.7.0
	 * @hidden
	 */
	private val type: JavaScriptPropertyType by lazy {
		JavaScriptPropertyType.from(value)
	}

	/**
	 * @inherited
	 * @property unit
	 * @since 0.7.0
	 */
	private val unit: JavaScriptPropertyUnit by lazy {
		JavaScriptPropertyUnit.NONE
	}

	/**
	 * @inherited
	 * @property string
	 * @since 0.7.0
	 */
	private val string: String by lazy {
		value.string
	}

	/**
	 * @inherited
	 * @property number
	 * @since 0.7.0
	 */
	private val number: Double by lazy {
		value.number
	}

	/**
	 * @inherited
	 * @property boolean
	 * @since 0.7.0
	 */
	private val boolean: Boolean by lazy {
		value.boolean
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Returns the data type.
	 * @method type
	 * @since 0.7.0
	 */
	override fun type(): JavaScriptPropertyType {
		return this.type
	}

	/**
	 * Returns the data unit.
	 * @method unit
	 * @since 0.7.0
	 */
	override fun unit(): JavaScriptPropertyUnit {
		return this.unit
	}

	/**
	 * Returns the data as a JavaScript value.
	 * @method getValue
	 * @since 0.7.0
	 */
	override fun value(): JavaScriptValue {
		return this.value!!
	}

	/**
	 * Returns the data as a string.
	 * @method string
	 * @since 0.7.0
	 */
	override fun string(): String {
		return this.string
	}

	/**
	 * Returns the data as a number.
	 * @method number
	 * @since 0.7.0
	 */
	override fun number(): Double {
		return this.number
	}

	/**
	 * Returns the data as a boolean.
	 * @method boolean
	 * @since 0.7.0
	 */
	override fun boolean(): Boolean {
		return this.boolean
	}

	/**
	 * @inherited
	 * @method equal
	 * @since 0.7.0
	 */
	override fun equal(value: JavaScriptValue): Boolean {
		return value.equals(value)
	}

	/**
	 * @inherited
	 * @method equal
	 * @since 0.7.0
	 */
	override fun equal(string: String): Boolean {
		return this.value!!.isString && this.value!!.string == string
	}

	/**
	 * @inherited
	 * @method equal
	 * @since 0.7.0
	 */
	override fun equal(number: Double): Boolean {
		return this.value!!.isNumber && this.value!!.number == number
	}

	/**
	 * @inherited
	 * @method equal
	 * @since 0.7.0
	 */
	override fun equal(boolean: Boolean): Boolean {
		return this.value!!.isBoolean && this.value!!.boolean == boolean
	}
}