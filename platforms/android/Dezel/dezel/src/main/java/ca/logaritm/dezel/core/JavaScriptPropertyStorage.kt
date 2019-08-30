package ca.logaritm.dezel.core

import android.util.Log

/**
 * @class JavaScriptPropertyStorage
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyStorage(type: JavaScriptPropertyType = JavaScriptPropertyType.NULL, unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE, value: JavaScriptValue? = null) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The property's type.
	 * @property type
	 * @since 0.7.0
	 */
	public var type: JavaScriptPropertyType = JavaScriptPropertyType.NULL

	/**
	 * The property's unit.
	 * @property unit
	 * @since 0.7.0
	 */
	public var unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE

	/**
	 * The property's string value.
	 * @property string
	 * @since 0.7.0
	 */
	public val string: String by lazy {
		this.toString()
	}

	/**
	 * The property's number value.
	 * @property number
	 * @since 0.7.0
	 */
	public val number: Double by lazy {
		this.toNumber()
	}

	/**
	 * The property's boolean value.
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
	 * Initializes the property storage.
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
	 * Stores the backing JavaScript value.
	 * @method store
	 * @since 0.7.0
	 */
	open fun store(value: JavaScriptValue?) {
		this.value = value
	}

	/**
	 * Returns the data as a string.
	 * @method toString
	 * @since 0.7.0
	 */
	override fun toString(): String {
		return ""
	}

	/**
	 * Returns the data as a number.
	 * @method toNumber
	 * @since 0.7.0
	 */
	open fun toNumber(): Double {
		return 0.0
	}

	/**
	 * Returns the data as a boolean.
	 * @method toBoolean
	 * @since 0.7.0
	 */
	open fun toBoolean(): Boolean {
		return false
	}

	/**
	 * Indicate whether this property's value is a specified JavaScript value.
	 * @method equals
	 * @since 0.7.0
	 */
	open fun equals(value: JavaScriptValue): Boolean {
		return this.value?.equals(value) ?: false
	}

	/**
	 * Indicate whether this property's value is a specified string.
	 * @method equals
	 * @since 0.7.0
	 */
	open fun equals(value: String): Boolean {
		return this.type == JavaScriptPropertyType.STRING && this.string == value
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	open fun equals(value: Double): Boolean {
		return this.type == JavaScriptPropertyType.NUMBER && this.number == value
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	open fun equals(value: Double, unit: JavaScriptPropertyUnit): Boolean {
		return this.type == JavaScriptPropertyType.NUMBER && this.number == value && this.unit == unit
	}

	/**
	 * Indicate whether this property's value is a specified boolean.
	 * @method equals
	 * @since 0.7.0
	 */
	open fun equals(value: Boolean): Boolean {
		return this.type == JavaScriptPropertyType.BOOLEAN && this.boolean == value
	}

	/**
	 * Casts the property to a specified type
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
