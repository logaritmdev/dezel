package ca.logaritm.dezel.core

import ca.logaritm.dezel.extension.isLocked

/**
 * A JavaScript property.
 * @class JavaScriptProperty
 * @since 0.7.0
 */
public class JavaScriptProperty {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The property's type.
	 * @property type
	 * @since 0.7.0
	 */
	public val type: JavaScriptPropertyType
		get() = this.currentValue.type
	
	/**
	 * The property's unit.
	 * @property unit
	 * @since 0.7.0
	 */
	public val unit: JavaScriptPropertyUnit
		get() = this.currentValue.unit

	/**
	 * The property's string currentValue.
	 * @property string
	 * @since 0.7.0
	 */
	public val string: String
		get() = this.currentValue.string

	/**
	 * The property's number currentValue.
	 * @property number
	 * @since 0.7.0
	 */
	public val number: Double
		get() = this.currentValue.number

	/**
	 * The property's boolean currentValue.
	 * @property boolean
	 * @since 0.7.0
	 */
	public val boolean: Boolean
		get() = this.currentValue.boolean

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
	 * Indicate whether the property is an array.
	 * @property isArray
	 * @since 0.7.0
	 */
	public val isArray: Boolean
		get() = this.type == JavaScriptPropertyType.ARRAY

	/**
	 * @property lock
	 * @since 0.7.0
	 * @hidden
	 */
	private var lock: Any? = null

	/**
	 * @property initialValue
	 * @since 0.7.0
	 * @hidden
	 */
	private var initialValue: JavaScriptPropertyValue

	/**
	 * @property currentValue
	 * @since 0.7.0
	 * @hidden
	 */
	private var currentValue: JavaScriptPropertyValue

	/**
	 * @property handler
	 * @since 0.7.0
	 * @hidden
	 */
	private var handler: JavaScriptPropertyHandler? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the property to null.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyValue()
		this.currentValue = this.initialValue
		this.handler = handler
	}

	/**
	 * Initializes the property with a string.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(string: String, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyStringValue(string)
		this.currentValue = this.initialValue
		this.handler = handler
	}

	/**
	 * Initializes the property with a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyNumberValue(number)
		this.currentValue = this.initialValue
		this.handler = handler
	}

	/**
	 * Initializes the property with a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, unit: JavaScriptPropertyUnit, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyNumberValue(number, unit)
		this.currentValue = this.initialValue
		this.handler = handler
	}

	/**
	 * Initializes the property with a boolean.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(boolean: Boolean, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyBooleanValue(boolean)
		this.currentValue = this.initialValue
		this.handler = handler
	}

	/**
	 * Initializes the property to null.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(lock: Any, handler: JavaScriptPropertyHandler? = null) : this(handler) {
		this.lock = lock
	}

	/**
	 * Initializes the property with a string.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(string: String, lock: Any, handler: JavaScriptPropertyHandler? = null) : this(string, handler) {
		this.lock = lock;
	}

	/**
	 * Initializes the property with a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, lock: Any, handler: JavaScriptPropertyHandler? = null) : this(number, handler) {
		this.lock = lock;
	}

	/**
	 * Initializes the property with a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, unit: JavaScriptPropertyUnit, lock: Any, handler: JavaScriptPropertyHandler? = null) : this(number, unit, handler) {
		this.lock = lock;
	}

	/**
	 * Initializes the property with a boolean.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(boolean: Boolean, lock: Any, handler: JavaScriptPropertyHandler? = null) : this(boolean, handler) {
		this.lock = lock;
	}

	/**
	 * Parses the string assign its result to the property.
	 * @method parse
	 * @since 0.7.0
	 */
	public fun parse(value: String, lock: Any? = null) {

		if (isLocked(this.lock, lock)) {
			return
		}

		this.lock = lock

		val result = JavaScriptPropertyParser.parse(value)
		if (result != null) {

			when (result.type) {
				JavaScriptPropertyType.STRING  -> this.reset(result.string)
				JavaScriptPropertyType.NUMBER  -> this.reset(result.number, result.unit)
				JavaScriptPropertyType.BOOLEAN -> this.reset(result.boolean)
				else                           -> {}
			}

			return
		}

		this.reset(value)
	}

	/**
	 * Resets this property's value to null.
	 * @method reset
	 * @since 0.7.0
	 */
	public fun reset(lock: Any? = null, initial: Boolean = false) {

		if (isLocked(this.lock, lock)) {
			return
		}

		this.lock = lock

		if (initial) {

			if (this.equals(this.initialValue) == false) {
				this.update(this.initialValue)
				this.change();
			}

		} else {

			if (this.isNull == false) {
				this.update()
				this.change()
			}

		}
	}

	/**
	 * Resets this property's value using a JavaScript currentValue.
	 * @method reset
	 * @since 0.7.0
	 */
	public fun reset(value: JavaScriptValue?, lock: Any? = null) {

		if (isLocked(this.lock, lock)) {
			return
		}

		this.lock = lock

		if (value == null) {
			this.reset()
			return
		}

		val result = JavaScriptPropertyParser.parse(value)
		if (result != null) {

			when (result.type) {
				JavaScriptPropertyType.NULL    -> this.reset()
				JavaScriptPropertyType.STRING  -> this.reset(result.string)
				JavaScriptPropertyType.NUMBER  -> this.reset(result.number, result.unit)
				JavaScriptPropertyType.BOOLEAN -> this.reset(result.boolean)
				else                           -> {}
			}

		} else {

			if (this.equals(value) == false) {
				this.update(value)
				this.change()
			}

		}

		this.currentValue.store(value)
	}

	/**
	 * Resets this property's value using a string.
	 * @method reset
	 * @since 0.7.0
	 */
	public fun reset(value: String, lock: Any? = null) {

		if (isLocked(this.lock, lock)) {
			return
		}

		this.lock = lock

		if (this.equals(value) == false) {
			this.update(value)
			this.change()
		}
	}

	/**
	 * Resets this property's value using a number.
	 * @method reset
	 * @since 0.7.0
	 */
	public fun reset(value: Double, lock: Any? = null) {

		if (isLocked(this.lock, lock)) {
			return
		}

		this.lock = lock

		if (this.equals(value) == false) {
			this.update(value)
			this.change()
		}
	}

	/**
	 * Resets this property's value using a number.
	 * @method reset
	 * @since 0.7.0
	 */
	public fun reset(value: Double, unit: JavaScriptPropertyUnit, lock: Any? = null) {

		if (isLocked(this.lock, lock)) {
			return
		}

		this.lock = lock

		if (this.equals(value, unit) == false) {
			this.update(value, unit)
			this.change()
		}
	}

	/**
	 * Resets this property's value using a boolean.
	 * @method reset
	 * @since 0.7.0
	 */
	public fun reset(value: Boolean, lock: Any? = null) {

		if (isLocked(this.lock, lock)) {
			return
		}

		this.lock = lock

		if (this.equals(value) == false) {
			this.update(value)
			this.change()
		}
	}

	/**
	 * Indicate whether this property's value is a specified JavaScript value.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: JavaScriptPropertyValue): Boolean {

		when (this.type) {
			JavaScriptPropertyType.NULL    -> return value.type == JavaScriptPropertyType.NULL
			JavaScriptPropertyType.STRING  -> return value.equals(this.string)
			JavaScriptPropertyType.NUMBER  -> return value.equals(this.number)
			JavaScriptPropertyType.BOOLEAN -> return value.equals(this.boolean)
			else                           -> {}
		}

		return this.currentValue == value
	}
	
	/**
	 * Indicate whether this property's value is a specified JavaScript currentValue.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: JavaScriptValue): Boolean {
		return this.currentValue.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified string.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: String): Boolean {
		return this.currentValue.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Double): Boolean {
		return this.currentValue.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Double, unit: JavaScriptPropertyUnit): Boolean {
		return this.currentValue.equals(value, unit)
	}

	/**
	 * Indicate whether this property's value is a specified boolean.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Boolean): Boolean {
		return this.currentValue.equals(value)
	}

	/**
	 * Casts the property to a specified type.
	 * @method cast
	 * @since 0.7.0
	 */
	public fun <T> cast(type: Class<T>): T? {
		return this.currentValue.cast(type)
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method toJs
	 * @since 0.7.0
	 * @hidden
	 */
	public fun toHandle(context: JavaScriptContext): Long? {
		return this.currentValue.toHandle(context)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update() {
		this.currentValue = JavaScriptPropertyValue()
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: JavaScriptPropertyValue) {
		this.currentValue = value
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: JavaScriptValue) {
		this.currentValue = JavaScriptPropertyRawValue(value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: String) {
		this.currentValue = JavaScriptPropertyStringValue(value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: Double) {
		this.currentValue = JavaScriptPropertyNumberValue(value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: Double, unit: JavaScriptPropertyUnit) {
		this.currentValue = JavaScriptPropertyNumberValue(value, unit)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: Boolean) {
		this.currentValue = JavaScriptPropertyBooleanValue(value)
	}

	/**
	 * @method change
	 * @since 0.7.0
	 * @hidden
	 */
	private fun change() {
		this.handler?.invoke(this)
	}
}
