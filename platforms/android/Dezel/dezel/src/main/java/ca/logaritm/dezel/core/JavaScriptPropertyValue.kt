package ca.logaritm.dezel.core

/**
 * @class JavaScriptPropertyValue
 * @since 0.7.0
 */
open class JavaScriptPropertyValue(type: JavaScriptPropertyType = JavaScriptPropertyType.NULL, unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE, value: JavaScriptValue? = null) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property type
	 * @since 0.7.0
	 */
	public var type: JavaScriptPropertyType = JavaScriptPropertyType.NULL

	/**
	 * @property unit
	 * @since 0.7.0
	 */
	public var unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE

	/**
	 * @property string
	 * @since 0.7.0
	 */
	public val string: String by lazy {
		this.toString()
	}

	/**
	 * @property number
	 * @since 0.7.0
	 */
	public val number: Double by lazy {
		this.toNumber()
	}

	/**
	 * @property boolean
	 * @since 0.7.0
	 */
	public val boolean: Boolean by lazy {
		this.toBoolean()
	}

	/**
	 * @property value
	 * @since 0.7.0
	 * @hidden
	 */
	private var value: JavaScriptValue? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {

		this.type = type
		this.unit = unit

		/*
		 * The data parameter is the JavaScript value given initialy. It's
		 * useful to keep a reference instead of recreating a JavaScript value
		 * from the primitive values.
		 */

		this.value = value
	}

	/**
	 * @method store
	 * @since 0.7.0
	 */
	open fun store(value: JavaScriptValue?) {
		this.value = value
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override fun toString(): String {
		return ""
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	open fun toNumber(): Double {
		return 0.0
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	open fun toBoolean(): Boolean {
		return false
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	open fun equals(value: JavaScriptValue): Boolean {
		return this.value?.equals(value) ?: false
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	open fun equals(value: String): Boolean {
		return this.type == JavaScriptPropertyType.STRING && this.string == value
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	open fun equals(value: Double): Boolean {
		return this.type == JavaScriptPropertyType.NUMBER && this.number == value
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	open fun equals(value: Double, unit: JavaScriptPropertyUnit): Boolean {
		return this.type == JavaScriptPropertyType.NUMBER && this.number == value && this.unit == unit
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	open fun equals(value: Boolean): Boolean {
		return this.type == JavaScriptPropertyType.BOOLEAN && this.boolean == value
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	open fun <T> cast(type: Class<T>): T? {
		return this.value?.cast(type)
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method toJs
	 * @since 0.7.0
	 * @hidden
	 */
	internal fun toHandle(context: JavaScriptContext): Long? {

		val value = this.value
		if (value != null) {
			return value.toHandle(context)
		}

		if (this.unit == JavaScriptPropertyUnit.NONE) {

			when (this.type) {
				JavaScriptPropertyType.NULL    -> this.value = context.jsnull
				JavaScriptPropertyType.STRING  -> this.value = context.createString(this.string)
				JavaScriptPropertyType.NUMBER  -> this.value = context.createNumber(this.number)
				JavaScriptPropertyType.BOOLEAN -> this.value = context.createBoolean(this.boolean)
				else                           -> {}
			}

		} else {

			this.value = context.createString(this.string)

		}

		return this.value?.toHandle(context)
	}
}
