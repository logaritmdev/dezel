/**
 * @extension Bool
 * @since 0.1.0
 * @hidden
 */
internal extension Bool {

	/**
	 * @method string
	 * @since 0.1.0
	 * @hidden
	 */
	internal func string() -> String {
		return self ? "true" : "false"
	}

	/**
	 * @method double
	 * @since 0.1.0
	 * @hidden
	 */
	internal func double() -> Double {
		return self ? 1 : 0
	}
}

