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
		get() = this.value.type
	
	/**
	 * The property's unit.
	 * @property unit
	 * @since 0.7.0
	 */
	public val unit: JavaScriptPropertyUnit
		get() = this.value.unit

	/**
	 * The property's string value.
	 * @property string
	 * @since 0.7.0
	 */
	public val string: String
		get() = this.value.string

	/**
	 * The property's number value.
	 * @property number
	 * @since 0.7.0
	 */
	public val number: Double
		get() = this.value.number

	/**
	 * The property's boolean value.
	 * @property boolean
	 * @since 0.7.0
	 */
	public val boolean: Boolean
		get() = this.value.boolean

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
	 * @property value
	 * @since 0.7.0
	 * @hidden
	 */
	private var value: JavaScriptPropertyValue

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
		this.value = JavaScriptPropertyValue()
		this.handler = handler
	}

	/**
	 * Initializes the property with a string.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(string: String, handler: JavaScriptPropertyHandler? = null) {
		this.value = JavaScriptPropertyStringValue(string)
		this.handler = handler
	}

	/**
	 * Initializes the property with a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, handler: JavaScriptPropertyHandler? = null) {
		this.value = JavaScriptPropertyNumberValue(number)
		this.handler = handler
	}

	/**
	 * Initializes the property with a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, unit: JavaScriptPropertyUnit, handler: JavaScriptPropertyHandler? = null) {
		this.value = JavaScriptPropertyNumberValue(number, unit)
		this.handler = handler
	}

	/**
	 * Initializes the property with a boolean.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(boolean: Boolean, handler: JavaScriptPropertyHandler? = null) {
		this.value = JavaScriptPropertyBooleanValue(boolean)
		this.handler = handler
	}

	/**
	 * Parses the string and
	 * @method reset
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
	public fun reset(lock: Any? = null) {

		if (isLocked(this.lock, lock)) {
			return
		}

		this.lock = lock

		if (this.isNull == false) {
			this.update()
			this.change()
		}
	}

	/**
	 * Resets this property's value using a JavaScript value.
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

		this.value.store(value)
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
	public fun equals(value: JavaScriptValue): Boolean {
		return this.value.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified string.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: String): Boolean {
		return this.value.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Double): Boolean {
		return this.value.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Double, unit: JavaScriptPropertyUnit): Boolean {
		return this.value.equals(value, unit)
	}

	/**
	 * Indicate whether this property's value is a specified boolean.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Boolean): Boolean {
		return this.value.equals(value)
	}

	/**
	 * Casts the property to a specified type.
	 * @method cast
	 * @since 0.7.0
	 */
	public fun <T> cast(type: Class<T>): T? {
		return this.value.cast(type)
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method toJs
	 * @since 0.7.0
	 * @hidden
	 */
	open fun toHandle(context: JavaScriptContext): Long? {
		return this.value.toHandle(context)
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
		this.value = JavaScriptPropertyValue()
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: JavaScriptValue) {
		this.value = JavaScriptPropertyRawValue(value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: String) {
		this.value = JavaScriptPropertyStringValue(value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: Double) {
		this.value = JavaScriptPropertyNumberValue(value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: Double, unit: JavaScriptPropertyUnit) {
		this.value = JavaScriptPropertyNumberValue(value, unit)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: Boolean) {
		this.value = JavaScriptPropertyBooleanValue(value)
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
