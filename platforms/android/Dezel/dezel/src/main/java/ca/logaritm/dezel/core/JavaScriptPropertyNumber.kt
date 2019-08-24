package ca.logaritm.dezel.core

/**
 * @class JavaScriptPropertyNumber
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyNumber(context: JavaScriptContext, number: Double, unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE): JavaScriptPropertyData(context) {

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
	private val type: JavaScriptPropertyType = JavaScriptPropertyType.NUMBER

	/**
	 * @property unit
	 * @since 0.7.0
	 * @hidden
	 */
	private val unit: JavaScriptPropertyUnit = unit

	/**
	 * @property string
	 * @since 0.7.0
	 * @hidden
	 */
	private val string: String by lazy {
		Conversion.toString(this.number)
	}

	/**
	 * @property number
	 * @since 0.7.0
	 * @hidden
	 */
	private val number: Double = number

	/**
	 * @property boolean
	 * @since 0.7.0
	 * @hidden
	 */
	private val boolean: Boolean by lazy {
		Conversion.toBoolean(this.number)
	}

	/**
	 * @property jsValue
	 * @since 0.7.0
	 * @hidden
	 */
	private val jsValue: JavaScriptValue by lazy {
		when (unit) {
			JavaScriptPropertyUnit.NONE -> this.context.createNumber(number)
			JavaScriptPropertyUnit.PX   -> this.context.createString(this.string + "px")
			JavaScriptPropertyUnit.PC   -> this.context.createString(this.string + "%")
			JavaScriptPropertyUnit.VW   -> this.context.createString(this.string + "vw")
			JavaScriptPropertyUnit.VH   -> this.context.createString(this.string + "vh")
			JavaScriptPropertyUnit.PW   -> this.context.createString(this.string + "pw")
			JavaScriptPropertyUnit.PH   -> this.context.createString(this.string + "ph")
			JavaScriptPropertyUnit.CW   -> this.context.createString(this.string + "cw")
			JavaScriptPropertyUnit.CH   -> this.context.createString(this.string + "ch")
			JavaScriptPropertyUnit.DEG  -> this.context.createString(this.string + "deg")
			JavaScriptPropertyUnit.RAD  -> this.context.createString(this.string + "rad")
		}
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
		return value.isNumber && value.number == this.number
	}

	/**
	 * @inherited
	 * @method equal
	 * @since 0.7.0
	 */
	override fun equal(string: String): Boolean {
		return false
	}

	/**
	 * @inherited
	 * @method equal
	 * @since 0.7.0
	 */
	override fun equal(number: Double): Boolean {
		return this.number == number
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