package ca.logaritm.dezel.core


/**
 * @class JavaScriptPropertyFunctionValue
 * @super JavaScriptPropertyValue
 * @since 0.7.0
 */
open class JavaScriptPropertyFunctionValue(name: String, arguments: MutableList<JavaScriptPropertyValue>): JavaScriptPropertyValue(JavaScriptPropertyType.VARIABLE) {

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
	 * @property arguments
	 * @since 0.7.0
	 */
	public var arguments: MutableList<JavaScriptPropertyValue>
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
		this.arguments = arguments
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override fun toString(): String {
		throw Exception("JavaScriptPropertyFunctionValue is not convertible to type string.")
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	override fun toNumber(): Double {
		throw Exception("JavaScriptPropertyFunctionValue is not convertible to type number.")
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override fun toBoolean(): Boolean {
		throw Exception("JavaScriptPropertyFunctionValue is not convertible to type boolean.")
	}
}