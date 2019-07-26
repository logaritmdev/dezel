import CoreText

/**
 * @extension NSAttributedString
 * @since 0.1.0
 * @hidden
 */
internal extension NSAttributedString {

	/**
	 * @property link
	 * @since 0.5.0
	 * @hidden
	 */
	var link: String? {
		return self.attribute(.link, at: 0, effectiveRange: nil) as? String
	}

	/**
	 * @method substring
	 * @since 0.5.0
	 * @hidden
	 */
	func substring(offset: Int, length: Int) -> NSAttributedString {
		return self.attributedSubstring(from: NSRange(location: offset, length: length))
	}

	/**
	 * @method truncate
	 * @since 0.5.0
	 * @hidden
	 */
	func truncate(range: NSRange, bounds: CGSize, character: NSAttributedString) -> CTLine? {
		return CTLineCreateTruncatedLine(CTLineCreateWithAttributedString(self.substring(offset: range.location, length: self.length - range.location)), Double(bounds.width), .end, CTLineCreateWithAttributedString(character))
	}

	/**
	 * @method truncate
	 * @since 0.5.0
	 * @hidden
	 */
	func truncate(range: CFRange, bounds: CGSize, character: NSAttributedString) -> CTLine? {
		return CTLineCreateTruncatedLine(CTLineCreateWithAttributedString(self.substring(offset: range.location, length: self.length - range.location)), Double(bounds.width), .end,  CTLineCreateWithAttributedString(character))
	}
}
