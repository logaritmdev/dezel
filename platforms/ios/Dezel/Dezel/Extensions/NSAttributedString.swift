import CoreText

/**
 * @extension NSAttributedString
 * @since 0.1.0
 * @hidden
 */
internal extension NSAttributedString {

	internal var link: String? {
		return self.attribute(.link, at: 0, effectiveRange: nil) as? String
	}

	/**
	 * @method substring
	 * @since 0.5.0
	 * @hidden
	 */
	internal func substring(offset: Int, length: Int) -> NSAttributedString {
		return self.attributedSubstring(from: NSRange(location: offset, length: length))
	}

	/**
	 * @method truncate
	 * @since 0.5.0
	 * @hidden
	 */
	internal func truncate(range: NSRange, bounds: CGSize, character: NSAttributedString) -> CTLine? {
		return CTLineCreateTruncatedLine(CTLineCreateWithAttributedString(self.substring(offset: range.location, length: self.length - range.location)), Double(bounds.width), .end, CTLineCreateWithAttributedString(character))
	}

	/**
	 * @method truncate
	 * @since 0.5.0
	 * @hidden
	 */
	internal func truncate(range: CFRange, bounds: CGSize, character: NSAttributedString) -> CTLine? {
		return CTLineCreateTruncatedLine(CTLineCreateWithAttributedString(self.substring(offset: range.location, length: self.length - range.location)), Double(bounds.width), .end,  CTLineCreateWithAttributedString(character))
	}
}

internal extension NSMutableAttributedString {

	/**
	 * @method setFont
	 * @since 0.5.0
	 * @hidden
	 */
	internal func addFont(_ value: UIFont, range: NSRange) {
		self.addAttribute(.font, value: value, range: range)
	}

	/**
	 * @method addBackgroundColor
	 * @since 0.5.0
	 * @hidden
	 */
	internal func addBackgroundColor(_ value: CGColor, range: NSRange) {
		self.addAttribute(.backgroundColor, value: UIColor(cgColor: value), range: range)
	}

	/**
	 * @method addBackgroundColor
	 * @since 0.5.0
	 * @hidden
	 */
	internal func addBackgroundColor(_ value: UIColor, range: NSRange) {
		self.addAttribute(.backgroundColor, value: value, range: range)
	}

	/**
	 * @method addTextColor
	 * @since 0.5.0
	 * @hidden
	 */
	internal func addTextColor(_ value: CGColor, range: NSRange) {
		self.addAttribute(.foregroundColor, value: UIColor(cgColor: value), range: range)
	}

	/**
	 * @method addTextColor
	 * @since 0.5.0
	 * @hidden
	 */
	internal func addTextColor(_ value: UIColor, range: NSRange) {
		self.addAttribute(.foregroundColor, value: value, range: range)
	}

	/**
	 * @method addTextKerning
	 * @since 0.5.0
	 * @hidden
	 */
	internal func addTextKerning(_ value: CGFloat, range: NSRange) {
		self.addAttribute(.kern, value: value, range: range)
	}

	/**
	 * @method addBaselineOffset
	 * @since 0.5.0
	 * @hidden
	 */
	internal func addBaselineOffset(_ value: CGFloat, range: NSRange) {
		self.addAttribute(.baselineOffset, value: value, range: range)
	}

	/**
	 * @method addTextDecoration
	 * @since 0.5.0
	 * @hidden
	 */
	internal func addTextDecoration(_ value: TextDecoration, range: NSRange) {

		switch (value) {

			case .underline:
				self.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
			case .linethrough:
				self.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)

			default:
				break
		}
	}

	/**
	 * @method addLink
	 * @since 0.5.0
	 * @hidden
	 */
	internal func addLink(_ value: String, range: NSRange) {
		self.addAttribute(.link, value: string, range: range)
	}
}

/**
 * Attributed string text attributes.
 * @typealias TextAttributes
 * @since 0.5.0
 */
public typealias TextAttributes = [NSAttributedString.Key: Any]

/**
 * @extension Dictionary
 * @since 0.5.0
 * @hidden
 */
extension Dictionary where Key == NSAttributedString.Key, Value == Any {

	/**
	 * @property paragraph
	 * @since 0.5.0
	 * @hidden
	 */
	mutating private func paragraph() -> NSMutableParagraphStyle {

		if (self[.paragraphStyle] == nil) {
			self[.paragraphStyle] = NSMutableParagraphStyle()
		}

		return self[.paragraphStyle] as! NSMutableParagraphStyle
	}

	/**
	 * @method setFont
	 * @since 0.5.0
	 * @hidden
	 */
	mutating internal func setFont(_ value: UIFont?) {
		self[.font] = value
	}

	/**
	 * @method setBackgroundColor
	 * @since 0.5.0
	 * @hidden
	 */
	mutating internal func setBackgroundColor(_ value: CGColor) {
		self[.backgroundColor] = UIColor(cgColor: value)
	}

	/**
	 * @method setBackgroundColor
	 * @since 0.5.0
	 * @hidden
	 */
	mutating internal func setBackgroundColor(_ value: UIColor?) {
		self[.backgroundColor] = value
	}

	/**
	 * @method setTextColor
	 * @since 0.5.0
	 * @hidden
	 */
	mutating internal func setTextColor(_ value: CGColor) {
		self[.foregroundColor] = UIColor(cgColor: value)
	}

	/**
	 * @method setTextColor
	 * @since 0.5.0
	 * @hidden
	 */
	mutating internal func setTextColor(_ value: UIColor?) {
		self[.foregroundColor] = value
	}

	/**
	 * @method setTextKerning
	 * @since 0.5.0
	 * @hidden
	 */
	mutating internal func setTextKerning(_ value: CGFloat) {
		self[.kern] = value
	}

	/**
	 * @method setTextLeading
	 * @since 0.5.0
	 * @hidden
	 */
	mutating internal func setTextLeading(_ value: CGFloat) {
		self.paragraph().lineSpacing = value
	}

	/**
	 * @method setBaselineOffset
	 * @since 0.5.0
	 * @hidden
	 */
	mutating internal func setBaselineOffset(_ value: CGFloat) {
		self[.baselineOffset] = value
	}

	/**
	 * @method setTextAlignment
	 * @since 0.5.0
	 * @hidden
	 */
	mutating internal func setTextAlignment(_ value: TextAlignment) {

		if (value == .start || value == .end) {

			let dir = UIApplication.shared.userInterfaceLayoutDirection

			switch (value) {

				case .start:
					self.paragraph().alignment = dir == .leftToRight ? .left : .right
				case .end:
					self.paragraph().alignment = dir == .leftToRight ? .right : .left

				default:
					break
			}
		}

		switch (value) {

			case .left:
				self.paragraph().alignment = .left
			case .right:
				self.paragraph().alignment = .right
			case .center:
				self.paragraph().alignment = .center

			default:
				break
		}
	}

	/**
	 * @method setTextDecoration
	 * @since 0.5.0
	 * @hidden
	 */
	mutating internal func setTextDecoration(_ value: TextDecoration) {

		switch (value) {

			case .underline:
				self[.underlineStyle] = NSUnderlineStyle.single.rawValue
			case .linethrough:
				self[.strikethroughStyle] = NSUnderlineStyle.single.rawValue

			default:
				break
		}
	}
}
