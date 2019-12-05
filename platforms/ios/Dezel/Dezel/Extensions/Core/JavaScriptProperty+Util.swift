/**
 * @extension JavaScriptProperty
 * @since 0.7.0
 * @hidden
 */
internal extension JavaScriptProperty {

	/**
	 * @property strings
	 * @since 0.7.0
	 * @hidden
	 */
	var strings: [String] {

		if let values = self.composite?.values {
			return values.map { it in it.string }
		}

		return [self.string]
	}

	/**
	 * @property numbers
	 * @since 0.7.0
	 * @hidden
	 */
	var numbers: [Double] {

		if let values = self.composite?.values {
			return values.map { it in it.number }
		}

		return [self.number]
	}

}
