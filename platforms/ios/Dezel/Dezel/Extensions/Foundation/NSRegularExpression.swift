/**
 * @extension NSRegularExpression
 * @since 0.5.0
 * @hidden
 */
internal extension NSRegularExpression {

	/**
	 * @method isHTML
	 * @since 0.5.0
	 * @hidden
	 */
	static func isHTML(_ string: String) -> Bool {

		do {

			if (isHTMLRegex == nil) {
				isHTMLRegex = try NSRegularExpression(pattern: "<[a-z][\\s\\S]*>", options: .caseInsensitive)
			}

			return isHTMLRegex!.matches(string)

		} catch {
			fatalError("HTML Regular expression is invalid.")
		}
	}

	/**
	 * @method matches
	 * @since 0.5.0
	 * @hidden
	 */
	func matches(_ string: String) -> Bool {
		return self.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.length)) != nil
	}
}

/**
 * @since 0.5.0
 */
private var isHTMLRegex: NSRegularExpression?
