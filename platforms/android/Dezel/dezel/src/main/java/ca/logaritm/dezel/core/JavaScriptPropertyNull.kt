package ca.logaritm.dezel.core

/**
 * @class JavaScriptPropertyNull
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyNull(context: JavaScriptContext): JavaScriptPropertyData(context) {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {
		private var instance: JavaScriptPropertyNull? = null

		public fun instance(context: JavaScriptContext): JavaScriptPropertyNull {

			if (this.instance == null) {
				this.instance = JavaScriptPropertyNull(context)
			}

			return this.instance!!
		}
	}

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
	private val type: JavaScriptPropertyType = JavaScriptPropertyType.NULL

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
	private val string: String = "null"

	/**
	 * @property number
	 * @since 0.7.0
	 * @hidden
	 */
	private val number: Double = 0.0

	/**
	 * @property boolean
	 * @since 0.7.0
	 * @hidden
	 */
	private val boolean: Boolean = false

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
		return this.context.jsnull
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
		return value.isNull
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