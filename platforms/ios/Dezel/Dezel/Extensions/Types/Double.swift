/**
 * @extension Double
 * @since 0.1.0
 * @hidden
 */
internal extension Double {

	/**
	 * @property min
	 * @since 0.1.0
	 * @hidden
	 */
	static var min: Double {
		return -Double.greatestFiniteMagnitude
	}

	/**
	 * @property max
	 * @since 0.1.0
	 * @hidden
	 */
	static var max: Double {
		return +Double.greatestFiniteMagnitude
	}

	/**
	 * @method toInt
	 * @since 0.7.0
	 * @hidden
	 */
	func toInt() -> Int {
		return Int(self)
	}

	/**
	 * @method toInt32
	 * @since 0.7.0
	 * @hidden
	 */
	func toInt32() -> Int32 {
		return Int32(self)
	}

	/**
	 * @method toInt64
	 * @since 0.7.0
	 * @hidden
	 */
	func toInt64() -> Int64 {
		return Int64(self)
	}
}

/**
 * Double extension.
 * @extension Double
 * @since 0.7.0
 */
public extension Double {

	/**
	 * Converts to a string.
	 * @method toString
	 * @since 0.7.0
	 */
	func toString() -> String {
		return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
	}
}

