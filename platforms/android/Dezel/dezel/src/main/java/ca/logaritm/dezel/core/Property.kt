package ca.logaritm.dezel.core

import ca.logaritm.dezel.extension.Delegates

/**
 * A clazz checked handle with optional unit.
 * @class Property
 * @since 0.1.0
 */
open class Property {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * Parses a raw property string.
		 * @method parse
		 * @since 0.2.0
		 */
		public fun parse(raw: String): Property {
			val property = Property()
			property.parse(raw)
			return property
		}
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The property's type.
	 * @property type
	 * @since 0.1.0
	 */
	public var type: PropertyType = PropertyType.NULL
		private set

	/**
	 * The property's unit.
	 * @property unit
	 * @since 0.1.0
	 */
	public var unit: PropertyUnit = PropertyUnit.NONE
		private set

	/**
	 * The property's string handle.
	 * @property string
	 * @since 0.1.0
	 */
	public var string: String by Delegates.Lazy {
		this.initializeString()
	}

	/**
	 * The property's number handle.
	 * @property number
	 * @since 0.1.0
	 */
	public var number: Double by Delegates.Lazy {
		this.initializeNumber()
	}

	/**
	 * The property's boolean handle.
	 * @property boolean
	 * @since 0.1.0
	 */
	public var boolean: Boolean by Delegates.Lazy {
		this.initializeBoolean()
	}

	/**
	 * @property cache
	 * @since 0.1.0
	 * @hidden
	 */
	private var cache: JavaScriptValue? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the property.
	 * @constructor
	 * @since 0.1.0
	 */
	public constructor()

	/**
	 * Initializes the property to a string.
	 * @constructor
	 * @since 0.1.0
	 */
	public constructor(string: String) {
		this.set(string)
	}

	/**
	 * Initializes the property to a number.
	 * @constructor
	 * @since 0.1.0
	 */
	public constructor(number: Double) {
		this.set(number, PropertyUnit.NONE)
	}

	/**
	 * Initializes the property to a number.
	 * @constructor
	 * @since 0.1.0
	 */
	public constructor(number: Double, unit: PropertyUnit) {
		this.set(number, unit)
	}

	/**
	 * Initializes the property to a boolean.
	 * @constructor
	 * @since 0.1.0
	 */
	public constructor(boolean: Boolean) {
		this.set(boolean)
	}

	/**
	 * Initializes the property using a JavaScript handle.
	 * @constructor
	 * @since 0.1.0
	 */
	public constructor(value: JavaScriptValue) {

		this.cache = value

		if (value.isNull ||
			value.isUndefined) {
			this.type = PropertyType.NULL
			return
		}

		if (value.isArray) {
			this.type = PropertyType.ARRAY
			return
		}

		if (value.isObject) {
			this.type = PropertyType.OBJECT
			return
		}

		if (value.isString) {
			this.parse(value.string)
			return
		}

		if (value.isNumber) {
			this.set(value.number, PropertyUnit.NONE)
			return
		}

		if (value.isBoolean) {
			this.set(value.boolean)
			return
		}
	}

	/**
	 * Resets the property's value.
	 * @method reset
	 * @since 0.1.0
	 */
	public fun reset(value: String) {
		this.cache = null
		this.set(value)
	}

	/**
	 * Resets the property's value.
	 * @method reset
	 * @since 0.1.0
	 */
	public fun reset(value: Double) {
		this.cache = null
		this.set(value, PropertyUnit.NONE)
	}

	/**
	 * Resets the property's value.
	 * @method reset
	 * @since 0.1.0
	 */
	public fun reset(value: Double, unit: PropertyUnit) {
		this.cache = null
		this.set(value, unit)
	}

	/**
	 * Resets the property's value.
	 * @method reset
	 * @since 0.1.0
	 */
	public fun reset(value: Boolean) {
		this.cache = null
		this.set(value)
	}

	/**
	 * Returns the property as a handle created in the specified context.
	 * @method value
	 * @since 0.1.0
	 */
	public fun value(context: JavaScriptContext): JavaScriptValue {

		val cache = this.cache
		if (cache != null) {
			return cache
		}

		this.cache = when (this.type) {
			PropertyType.NULL    -> context.createNull()
			PropertyType.ARRAY   ->	context.createEmptyArray()
			PropertyType.OBJECT  ->	context.createEmptyObject()
			PropertyType.STRING  -> context.createString(this.string)
			PropertyType.NUMBER  -> context.createNumber(this.number, this.unit)
			PropertyType.BOOLEAN -> context.createBoolean(this.boolean)
		}

		return this.cache!!
	}

	/**
	 * Casts the value to a specified type.
	 * @method cast
	 * @since 0.1.0
	 */
	public fun <T> cast(type: Class<T>): T? {

		val value = this.cache
		if (value == null) {
			throw Exception("Unable to cast")
		}

		return value.cast(type)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method set
	 * @since 0.2.0
	 * @hidden
	 */
	private fun set(string: String) {
		this.type = PropertyType.STRING
		this.unit = PropertyUnit.NONE
		this.string = string
	}

	/**
	 * @method set
	 * @since 0.2.0
	 * @hidden
	 */
	private fun set(number: Double, unit: PropertyUnit) {
		this.type = PropertyType.NUMBER
		this.unit = unit
		this.number = number
	}

	/**
	 * @method set
	 * @since 0.2.0
	 * @hidden
	 */
	private fun set(boolean: Boolean) {
		this.type = PropertyType.BOOLEAN
		this.unit = PropertyUnit.NONE
		this.boolean = boolean
	}

	/**
	 * @method parse
	 * @since 0.2.0
	 * @hidden
	 */
	private fun parse(string: String) {

		if (string.length == 0) {
			this.set("")
			return
		}

		val letter = string[0]
		if (letter != '+' &&
			letter != '-' &&
			letter != '.' &&
			(letter < '0' || letter > '9')) {
			this.set(string)
			return
		}

		if (string.takeLast(1) == "%") {
			this.set(Conversion.ston(string), PropertyUnit.PC)
			return
		}

		when (string.takeLast(2).toLowerCase()) {

			"px" -> {
				this.set(Conversion.ston(string), PropertyUnit.PX)
				return
			}

			"vw" -> {
				this.set(Conversion.ston(string), PropertyUnit.VW)
				return
			}

			"vh" -> {
				this.set(Conversion.ston(string), PropertyUnit.VH)
				return
			}

			"pw" -> {
				this.set(Conversion.ston(string), PropertyUnit.PW)
				return
			}

			"ph" -> {
				this.set(Conversion.ston(string), PropertyUnit.PH)
				return
			}

			"cw" -> {
				this.set(Conversion.ston(string), PropertyUnit.CW)
				return
			}

			"ch" -> {
				this.set(Conversion.ston(string), PropertyUnit.CH)
				return
			}

			else -> {
			}
		}

		when (string.takeLast(3).toLowerCase()) {

			"deg" -> {
				this.set(Conversion.ston(string), PropertyUnit.DEG)
				return
			}

			"rad" -> {
				this.set(Conversion.ston(string), PropertyUnit.RAD)
				return
			}

			else  -> {
			}
		}

		this.set(string)
	}

	//--------------------------------------------------------------------------
	// Private API - Lazy Initialization
	//--------------------------------------------------------------------------

	/**
	 * @method initializeString
	 * @since 0.2.0
	 * @hidden
	 */
	private fun initializeString(): String {
		return when (this.type) {
			PropertyType.NULL    -> ""
			PropertyType.ARRAY   -> ""
			PropertyType.OBJECT  -> ""
			PropertyType.STRING  -> ""
			PropertyType.NUMBER  -> Conversion.ntos(this.number)
			PropertyType.BOOLEAN -> Conversion.btos(this.boolean)
		}
	}

	/**
	 * @method initializeNumber
	 * @since 0.2.0
	 * @hidden
	 */
	private fun initializeNumber(): Double {
		return when (this.type) {
			PropertyType.NULL    -> 0.0
			PropertyType.ARRAY   -> Double.NaN
			PropertyType.OBJECT  -> Double.NaN
			PropertyType.NUMBER  -> 0.0
			PropertyType.STRING  -> Conversion.ston(this.string)
			PropertyType.BOOLEAN -> Conversion.bton(this.boolean)
		}
	}

	/**
	 * @method initializeBoolean
	 * @since 0.2.0
	 * @hidden
	 */
	private fun initializeBoolean(): Boolean {
		return when (this.type) {
			PropertyType.NULL    -> false
			PropertyType.ARRAY   -> true
			PropertyType.OBJECT  -> true
			PropertyType.STRING  -> Conversion.stob(this.string)
			PropertyType.NUMBER  -> Conversion.ntob(this.number)
			PropertyType.BOOLEAN -> false
		}
	}
}
