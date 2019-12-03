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

		var result = ""

		result.append(self.name)
		result.append("(")

		for argument in self.arguments {
			result.append(argument.string)
			result.append(",")
		}

		result.append(")")

		return result
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	override open func toNumber() -> Double {
		return .nan
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override open func toBoolean() -> Bool {
		return false
	}
}
