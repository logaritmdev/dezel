package ca.logaritm.dezel.core

import ca.logaritm.dezel.extension.isLocked

/**
 * @class JavaScriptProperty
 * @since 0.7.0
 */
public class JavaScriptProperty {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * @property NullValue
		 * @since 0.7.0
		 * @hidden
		 */
		private val NullValue = JavaScriptPropertyValue()

	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property type
	 * @since 0.7.0
	 */
	public val type: JavaScriptPropertyType
		get() = this.currentValue.type
	
	/**
	 * @property unit
	 * @since 0.7.0
	 */
	public val unit: JavaScriptPropertyUnit
		get() = this.currentValue.unit

	/**
	 * @property string
	 * @since 0.7.0
	 */
	public val string: String
		get() = this.currentValue.string

	/**
	 * @property number
	 * @since 0.7.0
	 */
	public val number: Double
		get() = this.currentValue.number

	/**
	 * @property boolean
	 * @since 0.7.0
	 */
	public val boolean: Boolean
		get() = this.currentValue.boolean

	/**
	 * @property isNull
	 * @since 0.7.0
	 */
	public val isNull: Boolean
		get() = this.type == JavaScriptPropertyType.NULL

	/**
	 * @property isString
	 * @since 0.7.0
	 */
	public val isString: Boolean
		get() = this.type == JavaScriptPropertyType.STRING

	/**
	 * @property isNumber
	 * @since 0.7.0
	 */
	public val isNumber: Boolean
		get() = this.type == JavaScriptPropertyType.NUMBER

	/**
	 * @property isBoolean
	 * @since 0.7.0
	 */
	public val isBoolean: Boolean
		get() = this.type == JavaScriptPropertyType.BOOLEAN

	/**
	 * @property isObject
	 * @since 0.7.0
	 */
	public val isObject: Boolean
		get() = this.type == JavaScriptPropertyType.OBJECT

	/**
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
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = NullValue
		this.currentValue = NullValue
		this.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(string: String, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyStringValue(string)
		this.currentValue = this.initialValue
		this.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyNumberValue(number)
		this.currentValue = this.initialValue
		this.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, unit: JavaScriptPropertyUnit, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyNumberValue(number, unit)
		this.currentValue = this.initialValue
		this.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(boolean: Boolean, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyBooleanValue(boolean)
		this.currentValue = this.initialValue
		this.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(lock: Any, handler: JavaScriptPropertyHandler? = null) : this(handler) {
		this.lock = lock
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(string: String, lock: Any, handler: JavaScriptPropertyHandler? = null) : this(string, handler) {
		this.lock = lock;
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, lock: Any, handler: JavaScriptPropertyHandler? = null) : this(number, handler) {
		this.lock = lock;
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, unit: JavaScriptPropertyUnit, lock: Any, handler: JavaScriptPropertyHandler? = null) : this(number, unit, handler) {
		this.lock = lock;
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(boolean: Boolean, lock: Any, handler: JavaScriptPropertyHandler? = null) : this(boolean, handler) {
		this.lock = lock;
	}

	/**
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
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: JavaScriptValue): Boolean {
		return this.currentValue.equals(value)
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: String): Boolean {
		return this.currentValue.equals(value)
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Double): Boolean {
		return this.currentValue.equals(value)
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Double, unit: JavaScriptPropertyUnit): Boolean {
		return this.currentValue.equals(value, unit)
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	public fun equals(value: Boolean): Boolean {
		return this.currentValue.equals(value)
	}

	/**
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
		this.currentValue = NullValue
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
		this.currentValue = JavaScriptPropertyScriptValue(value)
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
