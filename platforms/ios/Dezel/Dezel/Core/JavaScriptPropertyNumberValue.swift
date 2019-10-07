/**
 * @class JavaScriptPropertyNumberValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyNumberValue: JavaScriptPropertyValue {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property value
	 * @since 0.7.0
	 * @hidden
	 */
	private var value: Double

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(value: Double) {
		self.value = value
		super.init(type: .number)
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(value: Double, unit: JavaScriptPropertyUnit) {
		self.value = value
		super.init(type: .number, unit: unit)
	}

	/**
	 * @inherited
	 * @method toString
	 * @since 0.7.0
	 */
	override open func toString() -> String {

		var string = self.value.toString()

		switch (self.unit) {

			case .px:
				string.append("px")
			case .pc:
				string.append("%")
			case .vw:
				string.append("vw")
			case .vh:
				string.append("vh")
			case .pw:
				string.append("pw")
			case .ph:
				string.append("ph")
			case .cw:
				string.append("cw")
			case .ch:
				string.append("ch")
			case .deg:
				string.append("deg")
			case .rad:
				string.append("rad")

			default:
				break
		}

		return string
	}

	/**
	 * @inherited
	 * @method toNumber
	 * @since 0.7.0
	 */
	override open func toNumber() -> Double {
		return self.value
	}

	/**
	 * @inherited
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override open func toBoolean() -> Bool {
		return self.value > 0
	}
}
