/**
 * @extension String
 * @since 0.1.0
 * @hidden
 */
internal extension String {

	/**
	 * @property length
	 * @since 0.1.0
	 * @hidden
	 */
	var length: Int {
		return self.count
	}

	/**
	 * @property isHTML
	 * @since 0.5.0
	 * @hidden
	 */
	var isHTML: Bool {
		return NSRegularExpression.isHTML(self)
	}

	/**
	 * @method substring
	 * @since 0.5.0
	 * @hidden
	 */
	func substring(start: Int, end: Int) -> String {
		let s = self.index(self.startIndex, offsetBy: start)
		let e = self.index(self.startIndex, offsetBy: end + 1)
		return String(self[s..<e])
	}

	/**
	 * @method trim
	 * @since 0.1.0
	 * @hidden
	 */
	func trim(set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
		return self.trimmingCharacters(in: set)
	}

	/**
	 * @method ltrim
	 * @since 0.5.0
	 * @hidden
	 */
	func ltrim(set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {

        for character in self.enumerated() {
            let matched = character.element.unicodeScalars.contains { set.contains($0) }
            if (matched == false) {
            	return self.substring(start: character.offset, end: self.length - character.offset)
            }
        }

        return self
	}

	/**
	 * @method rtrim
	 * @since 0.5.0
	 * @hidden
	 */
	func rtrim(set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
	// TODO
	// THis is not OK
            for character in self.reversed().enumerated() {
            let matched = character.element.unicodeScalars.contains { set.contains($0) }
            if (matched == false) {
                return String(
                	self.suffix(from: self.index(self.endIndex, offsetBy: -character.offset))
				)
            }
        }

        return self
	}

	/**
	 * @method until
	 * @since 0.2.0
	 * @hidden
	 */
	func until(_ char: Character) -> String {

		if let index = self.firstIndex(of: char) {
			return String(self[..<index])
		}

		return self
	}

	/**
	 * @method match
	 * @since 0.1.0
	 * @hidden
	 */
	func match(_ regex: String) -> Bool {
		return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
	}

	/**
	 * @method unitize
	 * @since 0.1.0
	 * @hidden
	 */
	mutating func unitize(_ unit: PropertyUnit) -> String {

		switch (unit) {
			case .px: self.append("px")
			case .pc: self.append("%")
			case .vw: self.append("vw")
			case .vh: self.append("vh")
			case .pw: self.append("pw")
			case .ph: self.append("ph")
			case .cw: self.append("cw")
			case .ch: self.append("ch")
			case .deg: self.append("deg")
			case .rad: self.append("rad")
			case .none: break
		}

		return self
	}

	/**
	 * @method normalize
	 * @since 0.5.0
	 * @hidden
	 */
	func normalize() -> String {
		return (
			self.trim()
				.replacingOccurrences(of: "\\n", with: "\n")
				.replacingOccurrences(of: "[\t ]+", with: " ", options: .regularExpression, range: nil)
				.replacingOccurrences(of: "\n ", with: "\n")
			)
	}

	/**
	 * @method toColor
	 * @since 0.1.0
	 * @hidden
	 */
	func toColor() -> CGColor {
		return CGColorParse(self)
	}

	/**
	 * @method toLocale
	 * @since 0.5.0
	 * @hidden
	 */
	func toLocale() -> Locale {

		if (self == "") {
			return Locale.current
		}

		if (locales[self] == nil) {
			locales[self] = Locale(identifier: self)
		}

		return locales[self]!
	}
}

/**
 * @const locales
 * @since 0.5.0
 * @hidden
 */
private var locales: [String: Locale] = [:]
