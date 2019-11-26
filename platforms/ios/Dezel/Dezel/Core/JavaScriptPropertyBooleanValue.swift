/**
 * @class JavaScriptPropertyBooleanValue
 * @super JavaScriptPropertyValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyBooleanValue: JavaScriptPropertyValue {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property value
	 * @since 0.7.0
	 * @hidden
	 */
	private var value: Bool

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(value: Bool) {
		self.value = value
		super.init(type: .boolean)
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override open func toString() -> String {
		return self.value ? "true" : "false"
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	override open func toNumber() -> Double {
		return self.value ? 1.0 : 0.0
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override open func toBoolean() -> Bool {
		return self.value
	}
}
