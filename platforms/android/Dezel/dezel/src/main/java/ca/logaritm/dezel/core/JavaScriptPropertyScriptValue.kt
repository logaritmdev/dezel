package ca.logaritm.dezel.core

/**
 * @class JavaScriptPropertyRawValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyRawValue(value: JavaScriptValue) : JavaScriptPropertyValue() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property data
	 * @since 0.7.0
	 */
	private var value: JavaScriptValue

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {

		this.value = value

		/*
		 * The value was parsed before being assigned here,
		 * there is no need to parse it again.
		 */

		val type: JavaScriptPropertyType

		when (true) {

			value.isNull      -> type = JavaScriptPropertyType.NULL
			value.isUndefined -> type = JavaScriptPropertyType.NULL
			value.isString    -> type = JavaScriptPropertyType.STRING
			value.isNumber    -> type = JavaScriptPropertyType.NUMBER
			value.isBoolean   -> type = JavaScriptPropertyType.BOOLEAN
			value.isObject    -> type = JavaScriptPropertyType.OBJECT
			value.isArray     -> type = JavaScriptPropertyType.ARRAY
			else              -> type = JavaScriptPropertyType.NULL
		}

		this.type = type
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override fun toString(): String {
		return this.value.string
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	override fun toNumber(): Double {
		return this.value.number
	}

	/**
	 * @inherited
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override fun toBoolean(): Boolean {
		return this.value.boolean
	}
}