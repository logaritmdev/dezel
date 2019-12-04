/**
 * @class JavaScriptPropertyNumberValue
 * @super JavaScriptPropertyValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyNumberValue: JavaScriptPropertyValue {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property data
	 * @since 0.7.0
	 * @hidden
	 */
	private var data: Double

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(value: Double) {
		self.data = value
		super.init(type: .number)
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public init(value: Double, unit: JavaScriptPropertyUnit) {

		self.data = value

		super.init(
			type: .number, unit: unit)
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	override open func toString() -> String {

		var string = self.data.toString()

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
	 * @method toNumber
	 * @since 0.7.0
	 */
	override open func toNumber() -> Double {
		return self.data
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	override open func toBoolean() -> Bool {
		return self.data > 0
	}
}
