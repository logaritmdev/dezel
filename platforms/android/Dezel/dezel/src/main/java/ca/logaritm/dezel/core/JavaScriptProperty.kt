package ca.logaritm.dezel.core

/**
 * A clazz checked handle with optional unit.
 * @class JavaScriptProperty
 * @since 0.7.0
 */
open class JavaScriptProperty private constructor(context: JavaScriptContext) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The property's JavaScript context.
	 * @property context
	 * @since 0.7.0
	 */
	public val context: JavaScriptContext = context

	/**
	 * The property's type.
	 * @property type
	 * @since 0.7.0
	 */
	public val type: JavaScriptPropertyType
		get() = this.property.type()

	/**
	 * The property's unit.
	 * @property unit
	 * @since 0.7.0
	 */
	public val unit: JavaScriptPropertyUnit
		get() = this.property.unit()

	/**
	 * The property's JavaScript value.
	 * @property value
	 * @since 0.7.0
	 */
	public val value: JavaScriptValue
		get() = this.property.value()

	/**
	 * The property's string value.
	 * @property string
	 * @since 0.7.0
	 */
	public val string: String
		get() = this.property.string()

	/**
	 * The property's number value.
	 * @property number
	 * @since 0.7.0
	 */
	public val number: Double
		get() = this.property.number()

	/**
	 * The property's boolean value.
	 * @property boolean
	 * @since 0.7.0
	 */
	public val boolean: Boolean
		get() = this.property.boolean()

	/**
	 * Indicate whether the property is null.
	 * @property isNull
	 * @since 0.7.0
	 */	
	public val isNull: Boolean
		get() = this.type == JavaScriptPropertyType.NULL

	/**
	 * Indicate whether the property is a string.
	 * @property isString
	 * @since 0.7.0
	 */
	public val isString: Boolean
		get() = this.type == JavaScriptPropertyType.STRING

	/**
	 * Indicate whether the property is a number.
	 * @property isNumber
	 * @since 0.7.0
	 */
	public val isNumber: Boolean
		get() = this.type == JavaScriptPropertyType.NUMBER

	/**
	 * Indicate whether the property is a boolean.
	 * @property isBoolean
	 * @since 0.7.0
	 */
	public val isBoolean: Boolean
		get() = this.type == JavaScriptPropertyType.BOOLEAN

	/**
	 * Indicate whether the property is an object.
	 * @property isObject
	 * @since 0.7.0
	 */
	public val isObject: Boolean
		get() = this.type == JavaScriptPropertyType.OBJECT

	/**
	 * Indicate whether the property is an object.
	 * @property isArray
	 * @since 0.7.0
	 */
	public val isArray: Boolean
		get() = this.type == JavaScriptPropertyType.ARRAY

	/**
	 * @property property
	 * @since 0.7.0
	 * @hidden
	 */
	internal lateinit var property: JavaScriptPropertyData

	/**
	 * @property listener
	 * @since 0.7.0
	 * @hidden
	 */
	internal var listener: JavaScriptPropertyChangeHandler? = null

	/**
	 * @property lock
	 * @since 0.7.0
	 * @hidden
	 */
	private var lock: Any? = null


	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the property using a JavaScript handle.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(context: JavaScriptContext, callback: JavaScriptPropertyChangeHandler? = null) : this(context) {
		this.property = JavaScriptPropertyNull(context)
		this.listener = callback
	}

	/**
	 * Initializes the property using a JavaScript handle.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(context: JavaScriptContext, value: JavaScriptValue, callback: JavaScriptPropertyChangeHandler? = null) : this(context, callback) {
		this.property = JavaScriptPropertyValue(context, value)
	}

	/**
	 * Initializes the property to a string.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(context: JavaScriptContext, value: String, callback: JavaScriptPropertyChangeHandler? = null) : this(context, callback) {
		this.property = JavaScriptPropertyString(context, value)
	}

	/**
	 * Initializes the property to a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(context: JavaScriptContext, value: Double, callback: JavaScriptPropertyChangeHandler? = null) : this(context, callback) {
		this.property = JavaScriptPropertyNumber(context, value)
	}

	/**
	 * Initializes the property to a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(context: JavaScriptContext, value: Double, unit: JavaScriptPropertyUnit, callback: JavaScriptPropertyChangeHandler? = null) : this(context, callback) {
		this.property = JavaScriptPropertyNumber(context, value, unit)
	}

	/**
	 * Initializes the property to a boolean.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(context: JavaScriptContext, value: Boolean, callback: JavaScriptPropertyChangeHandler? = null) : this(context, callback) {
		this.property = JavaScriptPropertyBoolean(context, value)
	}

	/**
	 * Sets the property's value using a JavaScript value.
	 * @method set
	 * @since 0.7.0
	 */
	public fun set(value: JavaScriptValue?, lock: Any? = null) {
		this.reset(value, lock)
	}

	/**
	 * Sets the property's value using a string.
	 * @method set
	 * @since 0.7.0
	 */
	public fun set(string: String, lock: Any? = null) {
		this.reset(string, null, lock)
	}

	/**
	 * Sets the property's value using a number.
	 * @method set
	 * @since 0.7.0
	 */
	public fun set(number: Double, unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE, lock: Any? = null) {
		this.reset(number, unit, null, lock)
	}

	/**
	 * Sets the property's value using a boolean.
	 * @method set
	 * @since 0.7.0
	 */
	public fun set(boolean: Boolean, lock: Any? = null) {
		this.reset(boolean, null, lock)
	}

	/**
	 * Parses the JavaScriptValue
	 * @method set
	 * @since 0.7.0
	 */
	public fun parse(value: JavaScriptValue, lock: Any? = null) {

		if (value.isString) {

			val unit = this.parseUnit(value.string)
			if (unit == null) {
				this.reset(value.string, value, lock)
				return
			}

			val number = Conversion.toNumber(value.string)

			if (this.equal(number, unit) == false) {
				this.reset(number, unit, value, lock)
				return
			}
		}

		this.reset(value, lock)
	}

	/**
	 * Resets the property value by parsing a string.
	 * @method parse
	 * @since 0.7.0
	 */
	public fun parse(value: String, lock: Any? = null) {

		val unit = this.parseUnit(value)
		if (unit == null) {
			this.reset(value, null, lock)
			return
		}

		val number = Conversion.toNumber(value)

		if (this.equal(number, unit) == false) {
			this.reset(number, unit, null, lock)
		}
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method reset
	 * @since 0.7.0
	 * @hidden
	 */
	private fun reset(value: JavaScriptValue?, lock: Any? = null) {

		if (this.lock != null &&
			this.lock != lock) {
			return
		}

		this.lock = lock

		if (value == null) {

			if (this.property.isNull == false) {
				this.property = JavaScriptPropertyNull.instance(this.context)
				this.changed()
			}

			return
		}

		if (this.property.equal(value) == false) {
			this.property = JavaScriptPropertyString(this.context, string)
			this.property.value = value
			this.changed()
		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 * @hidden
	 */
	private fun reset(string: String, value: JavaScriptValue?, lock: Any? = null) {

		if (this.lock != null &&
			this.lock != lock) {
			return
		}

		this.lock = lock

		if (this.property.equal(string) == false) {
			this.property = JavaScriptPropertyString(this.context, string)
			this.property.value = value
			this.changed()
		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 * @hidden
	 */
	private fun reset(number: Double, unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE, value: JavaScriptValue?, lock: Any? = null) {

		if (this.lock != null &&
			this.lock != lock) {
			return
		}

		this.lock = lock

		if (this.property.equal(number) == false) {
			this.property = JavaScriptPropertyNumber(this.context, number, unit)
			this.property.value = value
			this.changed()
		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 * @hidden
	 */
	private fun reset(boolean: Boolean, value: JavaScriptValue?, lock: Any? = null) {

		if (this.lock != null &&
			this.lock != lock) {
			return
		}

		this.lock = lock

		if (this.property.equal(boolean) == false) {
			this.property = JavaScriptPropertyBoolean(this.context, boolean)
			this.property.value = value
			this.changed()
		}
	}

	/**
	 * @method equal
	 * @since 0.7.0
	 * @hidden
	 */
	private fun equal(property: JavaScriptPropertyData): Boolean {

		val type = property.type()
		val unit = property.unit()

		if (this.type != type ||
			this.unit != unit) {
			return false
		}

		val value = this.property.value
		if (value == null) {

			when (this.type) {
				JavaScriptPropertyType.NULL    -> return property.isNull
				JavaScriptPropertyType.STRING  -> return property.string() == this.string
				JavaScriptPropertyType.NUMBER  -> return property.number() == this.number
				JavaScriptPropertyType.BOOLEAN -> return property.boolean() == this.boolean
				else                           -> {}
			}

		} else {

			return property.value?.equals(value) ?: false

		}

		return false
	}

	/**
	 * @method equal
	 * @since 0.7.0
	 * @hidden
	 */
	private fun equal(string: String): Boolean {
		return this.type == JavaScriptPropertyType.STRING && this.string == string
	}

	/**
	 * @method equal
	 * @since 0.7.0
	 * @hidden
	 */
	private fun equal(number: Double, unit: JavaScriptPropertyUnit): Boolean {
		return this.type == JavaScriptPropertyType.NUMBER && this.unit == unit && this.number == number
	}

	/**
	 * @method equal
	 * @since 0.7.0
	 * @hidden
	 */
	private fun equal(boolean: Boolean): Boolean {
		return this.type == JavaScriptPropertyType.BOOLEAN && this.boolean == boolean
	}

	/**
	 * @method parseUnit
	 * @since 0.7.0
	 * @hidden
	 */
	private fun parseUnit(value: String): JavaScriptPropertyUnit? {

		if (value.length == 0) {
			return null
		}

		val letter = value[0]
		if (letter != '+' &&
			letter != '-' &&
			letter != '.' &&
			(letter < '0' || letter > '9')) {
			return null
		}

		when (value.takeLast(1).toLowerCase()) {
			"%"  -> { return JavaScriptPropertyUnit.PC }
			else -> {}
		}

		when (value.takeLast(2).toLowerCase()) {
			"px" -> { return JavaScriptPropertyUnit.PX }
			"vw" -> { return  JavaScriptPropertyUnit.VW }
			"vh" -> { return  JavaScriptPropertyUnit.VH }
			"pw" -> { return JavaScriptPropertyUnit.PW }
			"ph" -> { return  JavaScriptPropertyUnit.PH }
			"cw" -> { return  JavaScriptPropertyUnit.CW }
			"ch" -> { return  JavaScriptPropertyUnit.CH }
			else -> {}
		}

		when (value.takeLast(3).toLowerCase()) {
			"deg" -> { return  JavaScriptPropertyUnit.DEG }
			"rad" -> { return  JavaScriptPropertyUnit.RAD }
			else  -> { }
		}

		return null
	}

	/**
	 * @method changed
	 * @since 0.7.0
	 * @hidden
	 */
	private fun changed() {
		this.listener?.invoke(this)
	}
}