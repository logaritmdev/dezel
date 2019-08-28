import Foundation

extension Scanner {

	/**
	 * @method hasNext
	 * @since 0.4.0
	 * @hidden
	 */
	public func hasNext(string: String) -> Bool {

		let location = self.scanLocation

		if let _ = self.scanString(string) {
			self.scanLocation = location
			return true
		}

		return false
	}

	/**
	 * @method scanCharacters
	 * @since 0.4.0
	 * @hidden
	 */
    public func scanCharacters(from set: CharacterSet) -> String? {

        var value: NSString? = ""

		if self.scanCharacters(from: set, into: &value) {
			return value as String?
        }

        return nil
    }

	/**
	 * @method scanUpToCharacters
	 * @since 0.4.0
	 * @hidden
	 */
    public func scanUpToCharacters(from set: CharacterSet) -> String? {

        var value: NSString? = ""

        if self.scanUpToCharacters(from: set, into: &value) {
			return value as String?
        }

        return nil
    }

	/**
	 * @method scanString
	 * @since 0.4.0
	 * @hidden
	 */
    public func scanString(_ str: String) -> String? {

        var value: NSString? = ""

        if self.scanString(str, into: &value) {
			return value as String?
        }

        return nil
    }

	/**
	 * @method scanUpTo
	 * @since 0.4.0
	 * @hidden
	 */
    public func scanUpTo(_ str: String) -> String? {

        var value: NSString? = ""

        if self.scanUpTo(str, into: &value) {
			return value as String?
        }

        return nil
    }

	/**
	 * @method scanDouble
	 * @since 0.4.0
	 * @hidden
	 */
    public func scanDouble() -> Double? {

        var value = 0.0

        if self.scanDouble(&value) {
            return value
        }

        return nil
    }

	/**
	 * @method scanFloat
	 * @since 0.4.0
	 * @hidden
	 */
    public func scanFloat() -> Float? {

        var value: Float = 0.0

        if self.scanFloat(&value) {
            return value
        }

        return nil
    }

	/**
	 * @method scanInt
	 * @since 0.4.0
	 * @hidden
	 */
    public func scanInt() -> Int32? {

        var value: Int32 = 0

        if self.scanInt32(&value) {
            return value
        }

        return nil
    }

	/**
	 * @method scanFloat
	 * @since 0.4.0
	 * @hidden
	 */
    public func scanCGFloat() -> CGFloat? {

        var value: Float = 0.0

        if self.scanFloat(&value) {
            return CGFloat(value)
        }

        return nil
    }
}
