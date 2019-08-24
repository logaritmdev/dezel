package ca.logaritm.dezel.core

/**
 * @class JavaScriptPropertyData
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyString(context: JavaScriptContext, string: String): JavaScriptPropertyData(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @property value
	 * @since 0.7.0
	 */
	override var value: JavaScriptValue? = null

	/**
	 * @property type
	 * @since 0.7.0
	 * @hidden
	 */
	private val type: JavaScriptPropertyType = JavaScriptPropertyType.STRING

	/**
	 * @property unit
	 * @since 0.7.0
	 * @hidden
	 */
	private val unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE

	/**
	 * @property string
	 * @since 0.7.0
	 * @hidden
	 */
	private val string: String = string

	/**
	 * @property number
	 * @since 0.7.0
	 * @hidden
	 */
	private val number: Double by lazy {
		Conversion.toNumber(this.string)
	}

	/**
	 * @property boolean
	 * @since 0.7.0
	 * @hidden
	 */
	private val boolean: Boolean by lazy {
		Conversion.toBoolean(this.string)
	}

	/**
	 * @property jsValue
	 * @since 0.7.0
	 * @hidden
	 */
	private val jsValue: JavaScriptValue by lazy {
		this.context.createString(this.string)
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
		return this.value ?: this.jsValue
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
		return value.isString && value.string == this.string
	}

	/**
	 * @inherited
	 * @method equal
	 * @since 0.7.0
	 */
	override fun equal(string: String): Boolean {
		return this.string == string
	}

	/**
	 * @inherited
	 * @method equal
	 * @since 0.7.0
	 */
	override fun equal(number: Double): Boolean {
		return false
	}

	/**
	 * @inherited
	 * @method equal
	 * @since 0.7.0
	 */
	override fun equal(boolean: Boolean): Boolean {
		return false
	}
}