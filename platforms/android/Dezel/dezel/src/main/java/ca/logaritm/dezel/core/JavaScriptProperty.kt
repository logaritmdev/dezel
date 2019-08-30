package ca.logaritm.dezel.core

import android.util.Log
import ca.logaritm.dezel.extension.isLocked
import ca.logaritm.dezel.extension.type.let

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
		get() = this.storage.type
	
	/**
	 * The property's unit.
	 * @property unit
	 * @since 0.7.0
	 */
	public val unit: JavaScriptPropertyUnit
		get() = this.storage.unit

	/**
	 * The property's string value.
	 * @property string
	 * @since 0.7.0
	 */
	public val string: String
		get() = this.storage.string

	/**
	 * The property's number value.
	 * @property number
	 * @since 0.7.0
	 */
	public val number: Double
		get() = this.storage.number

	/**
	 * The property's boolean value.
	 * @property boolean
	 * @since 0.7.0
	 */
	public val boolean: Boolean
		get() = this.storage.boolean

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
	 * @property storage
	 * @since 0.7.0
	 * @hidden
	 */
	private var storage: JavaScriptPropertyStorage

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
		this.storage = JavaScriptPropertyStorage()
		this.handler = handler
	}

	/**
	 * Initializes the property with a string.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(string: String, handler: JavaScriptPropertyHandler? = null) {
		this.storage = JavaScriptPropertyStorageString(string)
		this.handler = handler
	}

	/**
	 * Initializes the property with a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, handler: JavaScriptPropertyHandler? = null) {
		this.storage = JavaScriptPropertyStorageNumber(number)
		this.handler = handler
	}

	/**
	 * Initializes the property with a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, unit: JavaScriptPropertyUnit, handler: JavaScriptPropertyHandler? = null) {
		this.storage = JavaScriptPropertyStorageNumber(number, unit)
		this.handler = handler
	}

	/**
	 * Initializes the property with a boolean.
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(boolean: Boolean, handler: JavaScriptPropertyHandler? = null) {
		this.storage = JavaScriptPropertyStorageBoolean(boolean)
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

		this.storage.store(value)
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
		return this.storage.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified string.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: String): Boolean {
		return this.storage.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Double): Boolean {
		return this.storage.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Double, unit: JavaScriptPropertyUnit): Boolean {
		return this.storage.equals(value, unit)
	}

	/**
	 * Indicate whether this property's value is a specified boolean.
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Boolean): Boolean {
		return this.storage.equals(value)
	}

	/**
	 * Casts the property to a specified type.
	 * @method cast
	 * @since 0.7.0
	 */
	public fun <T> cast(type: Class<T>): T? {
		return this.storage.cast(type)
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
		return this.storage.toHandle(context)
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
		this.storage = JavaScriptPropertyStorage()
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: JavaScriptValue) {
		this.storage = JavaScriptPropertyStorageValue(value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: String) {
		this.storage = JavaScriptPropertyStorageString(value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: Double) {
		this.storage = JavaScriptPropertyStorageNumber(value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: Double, unit: JavaScriptPropertyUnit) {
		this.storage = JavaScriptPropertyStorageNumber(value, unit)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: Boolean) {
		this.storage = JavaScriptPropertyStorageBoolean(value)
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
