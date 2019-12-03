/**
 * @class JavaScriptPropertyCompositeValue
 * @super JavaScriptPropertyValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyCompositeValue: JavaScriptPropertyValue {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

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
	public init(values: [JavaScriptPropertyValue]) {
		self.values = values
		super.init(type: .composite)
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override open func toString() -> String {

		var string = ""

		for value in values {
			string.append(value.string)
			string.append(" ")
		}

		return string
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
