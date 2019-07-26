
/**
 * @extension JavaScriptValue
 * @since 0.7.0
 * @hidden
 */
internal extension JavaScriptValue {

	/**
	 * @method toTimeInterval
	 * @since 0.7.0
	 * @hidden
	 */
	func toURL() -> URL? {
		return URL(string: self.string)
	}

	/**
	 * @method toTimeInterval
	 * @since 0.7.0
	 * @hidden
	 */
	func toTimeInterval() -> TimeInterval {
		return TimeInterval(self.number)
	}

	/**
	 * @method toArrayOfString
	 * @since 0.7.0
	 * @hidden
	 */
	func toArrayOfString() -> [String] {

		var array: [String] = []

		self.forEach { index, value in
			array.append(value.string)
		}

		return array
	}

	/**
	 * @method toArrayOfNumber
	 * @since 0.7.0
	 * @hidden
	 */
	func toArrayOfNumber() -> [Double] {

		var array: [Double] = []

		self.forEach { index, value in
			array.append(value.number)
		}

		return array
	}

	/**
	 * @method toDictionaryOfString
	 * @since 0.7.0
	 * @hidden
	 */
	func toDictionaryOfString() -> [String: String] {

		var dictionary: [String: String] = [:]

		self.forOwn { property, value in
			dictionary[property] = value.string
		}

		return dictionary
	}

	/**
	 * @method toDictionaryOfNumber
	 * @since 0.7.0
	 * @hidden
	 */
	func toDictionaryOfNumber() -> [String: Double] {

		var dictionary: [String: Double] = [:]

		self.forOwn { property, value in
			dictionary[property] = value.number
		}

		return dictionary
	}
}
