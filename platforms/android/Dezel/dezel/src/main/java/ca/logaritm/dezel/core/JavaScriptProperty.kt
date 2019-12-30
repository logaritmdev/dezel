package ca.logaritm.dezel.core

import android.util.Log
import ca.logaritm.dezel.extension.core.reset
import ca.logaritm.dezel.extension.isLocked
import ca.logaritm.dezel.view.display.external.ValueListExternal
import ca.logaritm.dezel.view.display.value.Value

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
		 * @property Null
		 * @since 0.7.0
		 * @hidden
		 */
		public val Null = JavaScriptPropertyValue()

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
	 * @property value
	 * @since 0.7.0
	 */
	public val value: JavaScriptValue?
		get() = this.currentValue.value

	/**
	 * @property variable
	 * @since 0.7.0
	 */
	public val variable: JavaScriptPropertyVariableValue?
		get() = this.currentValue as? JavaScriptPropertyVariableValue

	/**
	 * @property function
	 * @since 0.7.0
	 */
	public val function: JavaScriptPropertyFunctionValue?
		get() = this.currentValue as? JavaScriptPropertyFunctionValue

	/**
	 * @property composite
	 * @since 0.7.0
	 */
	public val composite: JavaScriptPropertyCompositeValue?
		get() = this.currentValue as? JavaScriptPropertyCompositeValue

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
	 * @property isCallback
	 * @since 0.7.0
	 */
	public val isCallback: Boolean
		get() = this.type == JavaScriptPropertyType.CALLBACK

	/**
	 * @property isVariable
	 * @since 0.7.0
	 */
	public val isVariable: Boolean
		get() = this.type == JavaScriptPropertyType.VARIABLE

	/**
	 * @property isFunction
	 * @since 0.7.0
	 */
	public val isFunction: Boolean
		get() = this.type == JavaScriptPropertyType.FUNCTION

	/**
	 * @property isComposite
	 * @since 0.7.0
	 */
	public val isComposite: Boolean
		get() = this.type == JavaScriptPropertyType.COMPOSITE

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
		this.initialValue = Null
		this.currentValue = Null
		this.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(string: String, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyStringValue(string)
		this.currentValue = JavaScriptPropertyStringValue(string)
		this.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyNumberValue(number)
		this.currentValue = JavaScriptPropertyNumberValue(number)
		this.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, unit: JavaScriptPropertyUnit, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyNumberValue(number, unit)
		this.currentValue = JavaScriptPropertyNumberValue(number, unit)
		this.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(boolean: Boolean, handler: JavaScriptPropertyHandler? = null) {
		this.initialValue = JavaScriptPropertyBooleanValue(boolean)
		this.currentValue = JavaScriptPropertyBooleanValue(boolean)
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
		this.lock = lock
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, lock: Any, handler: JavaScriptPropertyHandler? = null) : this(number, handler) {
		this.lock = lock
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(number: Double, unit: JavaScriptPropertyUnit, lock: Any, handler: JavaScriptPropertyHandler? = null) : this(number, unit, handler) {
		this.lock = lock
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(boolean: Boolean, lock: Any, handler: JavaScriptPropertyHandler? = null) : this(boolean, handler) {
		this.lock = lock
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
	public fun reset(value: String, lock: Any? = null, parse: Boolean = false) {

		if (isLocked(this.lock, lock)) {
			return
		}

		this.lock = lock

		if (parse) {
			this.parse(value, lock = lock)
			return
		}

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
	 * @method reset
	 * @since 0.7.0
	 */
	public fun reset(value: JavaScriptValue, lock: Any? = null, parse: Boolean = false) {

		if (isLocked(this.lock, lock)) {
			return
		}

		this.lock = lock

		when (true) {

			value.isNull      -> this.reset(lock = lock)
			value.isUndefined -> this.reset(lock = lock)
			value.isString    -> this.reset(value.string, lock = lock, parse = parse)
			value.isNumber    -> this.reset(value.number, lock = lock)
			value.isBoolean   -> this.reset(value.boolean, lock = lock)

			else -> {
				if (this.equals(value) == false) {
					this.update(value)
					this.change()
				}
			}
		}

		this.currentValue.reset(value)
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public fun reset(value: JavaScriptProperty, lock: Any? = null) {

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
	public fun reset(value: JavaScriptPropertyValue, lock: Any? = null) {

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
	internal fun equals(value: JavaScriptProperty): Boolean {
		return this.equals(value.currentValue)
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

			else -> {

			}
		}

		return this.currentValue === value
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
	 * @method parse
	 * @since 0.7.0
	 * @hidden
	 */
	internal fun parse(value: String, lock: Any? = null) {

		val values = Value.parse(value)
		if (values == null) {
			return
		}

		this.reset(values, lock = lock)

		values.delete()
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	internal fun reset(value: JavaScriptPropertyVariableValue, lock: Any? = null) {

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
	internal fun reset(value: JavaScriptPropertyFunctionValue, lock: Any? = null) {

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
	internal fun reset(value: JavaScriptPropertyCompositeValue, lock: Any? = null) {

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
	internal fun equals(value: JavaScriptPropertyVariableValue): Boolean {
		return this.currentValue === value
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	internal fun equals(value: JavaScriptPropertyFunctionValue): Boolean {
		return this.currentValue === value
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	internal fun equals(value: JavaScriptPropertyCompositeValue): Boolean {
		return this.currentValue === value
	}

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
		this.currentValue = Null
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
	private fun update(value: JavaScriptPropertyValue) {
		this.currentValue = value
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private fun update(value: JavaScriptProperty) {
		this.currentValue = value.currentValue
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
