/**
 * @class JavaScriptPropertyFunctionValue
 * @super JavaScriptPropertyValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyFunctionValue: JavaScriptPropertyValue {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property name
	 * @since 0.7.0
	 */
	private(set) public var name: String

	/**
	 * @property arguments
	 * @since 0.7.0
	 */
	private(set) public var arguments: [JavaScriptPropertyValue]

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(name: String, arguments: [JavaScriptPropertyValue]) {
		self.name = name
		self.arguments = arguments
		super.init(type: .function)
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override open func toString() -> String {
		fatalError("JavaScriptPropertyFunctionValue is not convertible to type string.")
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	override open func toNumber() -> Double {
		fatalError("JavaScriptPropertyFunctionValue is not convertible to type number.")
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override open func toBoolean() -> Bool {
		fatalError("JavaScriptPropertyFunctionValue is not convertible to type boolean.")
	}
}
