package ca.logaritm.dezel.core

/**
 * @class JavaScriptPropertyVariableValue
 * @super JavaScriptPropertyValue
 * @since 0.7.0
 */
open class JavaScriptPropertyVariableValue(name: String, values: MutableList<JavaScriptPropertyValue>): JavaScriptPropertyValue(JavaScriptPropertyType.VARIABLE) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property name
	 * @since 0.7.0
	 */
	public var name: String
		private set

	/**
	 * @property values
	 * @since 0.7.0
	 */
	public var values: MutableList<JavaScriptPropertyValue>
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {
		this.name = name
		this.values = values
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override fun toString(): String {
		throw Exception("JavaScriptPropertyVariableValue is not convertible to type string.")
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	override fun toNumber(): Double {
		throw Exception("JavaScriptPropertyVariableValue is not convertible to type number.")
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override fun toBoolean(): Boolean {
		throw Exception("JavaScriptPropertyVariableValue is not convertible to type boolean.")
	}
}