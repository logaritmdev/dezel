/**
 * @class JavaScriptPropertyStringValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyStringValue: JavaScriptPropertyValue {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property data
	 * @since 0.7.0
	 * @hidden
	 */
	private var value: String

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(value: String) {
		self.value = value
		super.init(type: .string)
	}

	/**
	 * @inherited
	 * @method toString
	 * @since 0.7.0
	 */
	override open func toString() -> String {
		return self.value
	}

	/**
	 * @inherited
	 * @method toNumber
	 * @since 0.7.0
	 */
	override open func toNumber() -> Double {
		return self.value.toNumber()
	}

	/**
	 * @inherited
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override open func toBoolean() -> Bool {
		return self.value.isEmpty == false
	}
}
