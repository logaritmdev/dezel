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
	 * @method int
	 * @since 0.1.0
	 * @hidden
	 */
	func int() -> Int {
		return Int(self)
	}

	/**
	 * @method int32
	 * @since 0.5.0
	 * @hidden
	 */
	func int32() -> Int32 {
		return Int32(self)
	}
}

