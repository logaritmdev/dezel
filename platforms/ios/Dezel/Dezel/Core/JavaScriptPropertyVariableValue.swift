/**
 * @class JavaScriptPropertyVariableValue
 * @super JavaScriptPropertyValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyVariableValue: JavaScriptPropertyValue {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property name
	 * @since 0.7.0
	 */
	private(set) public var name: String

	/**
	 * @property values
	 * @since 0.7.0
	 */
	private(set) public var values: [JavaScriptPropertyValue]

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(name: String, values: [JavaScriptPropertyValue]) {
		self.name = name
		self.values = values
		super.init(type: .variable)
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override open func toString() -> String {
		fatalError("JavaScriptPropertyVariableValue is not convertible to type string.")
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	override open func toNumber() -> Double {
		fatalError("JavaScriptPropertyVariableValue is not convertible to type number.")
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override open func toBoolean() -> Bool {
		fatalError("JavaScriptPropertyVariableValue is not convertible to type boolean.")
	}
}
