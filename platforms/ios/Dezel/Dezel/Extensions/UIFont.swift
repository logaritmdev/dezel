/**
 * @extension UIFont
 * @since 0.1.0
 * @hidden
 */
internal extension UIFont {

	/**
	 * @property cache
	 * @since 0.1.0
	 * @hidden
	 */
	private static var cache: [String: UIFont] = [:]

	/**
	 * @method from
	 * @since 0.1.0
	 * @hidden
	 */
	static func from(family: String, weight: String, style: String, size: CGFloat) -> UIFont {

		let fw = weight.lowercased().trim()
		let fs = style.lowercased().trim()

		if (family == "") {

			switch (fw) {
				case "lighter":
					return UIFont.systemFont(ofSize:size, weight:UIFont.Weight.light)
				case "normal":
					return UIFont.systemFont(ofSize:size, weight:UIFont.Weight.regular)
				case "bold":
					return UIFont.systemFont(ofSize:size, weight:UIFont.Weight.bold)
				case "bolder":
					return UIFont.systemFont(ofSize:size, weight:UIFont.Weight.heavy)
				case "100":
					return UIFont.systemFont(ofSize:size, weight:UIFont.Weight.ultraLight)
				case "200":
					return UIFont.systemFont(ofSize:size, weight:UIFont.Weight.thin)
				case "300":
					return UIFont.systemFont(ofSize:size, weight:UIFont.Weight.light)
				case "400":
					return UIFont.systemFont(ofSize:size, weight:UIFont.Weight.regular)
				case "500":
					return UIFont.systemFont(ofSize:size, weight:UIFont.Weight.medium)
				case "600":
					return UIFont.systemFont(ofSize:size, weight:UIFont.Weight.semibold)
				case "700":
					return UIFont.systemFont(ofSize: size, weight:UIFont.Weight.bold)
				case "800":
					return UIFont.systemFont(ofSize: size, weight:UIFont.Weight.heavy)
				case "900":
					return UIFont.systemFont(ofSize: size, weight:UIFont.Weight.black)
				default:
					return UIFont.systemFont(ofSize: size, weight:UIFont.Weight.regular)
			}
		}

		let key = "\(family)\(fw)\(fs)\(size)"

		var cache = self.cache[key]
		if (cache == nil) {

			var face = ""

			switch (fw) {
				case "lighter":
					face += "Thin"
				case "normal":
					face += "Regular"
				case "bold":
					face += "Bold"
				case "bolder":
					face += "Heavy"
				case "100":
					face += "UltraLight"
				case "200":
					face += "Thin"
				case "300":
					face += "Light"
				case "400":
					face += "Regular"
				case "500":
					face += "Medium"
				case "600":
					face += "Semibold"
				case "700":
					face += "Bold"
				case "800":
					face += "Heavy"
				case "900":
					face += "Black"
				default:
					face += "Regular"
			}

			switch (fs) {
				case "normal":
					break
				case "italic":
					face += " Italic"
				case "oblique":
					face += " Oblique"
				default:
					break
			}

			if (face == "Regular Italic") {
				face = "Italic"
			}

			let descriptor = UIFontDescriptor(fontAttributes:[
				UIFontDescriptor.AttributeName.family: family,
				UIFontDescriptor.AttributeName.face: face
			])

			if (descriptor.matchingFontDescriptors(withMandatoryKeys: nil).count > 0) {
				cache = UIFont(descriptor: descriptor, size:size)
			} else if let font = UIFont(name: family, size:size) {
				cache = font
			} else {
				cache = UIFont.systemFont(ofSize: size)
			}

			self.cache[key] = cache
		}

		return cache!
	}

	/**
	 * @method defaultSystemFontWith
	 * @since 0.5.0
	 * @hidden
	 */
	static func defaultSystemFontWith(trait: UIFontDescriptor.SymbolicTraits) -> UIFont {
		return UIFont(descriptor: UIFont.systemFont(ofSize: UIFont.systemFontSize).with(trait: trait)!.fontDescriptor, size: UIFont.systemFontSize)
	}

	/**
	 * @method with
	 * @since 0.5.0
	 * @hidden
	 */
	func with(trait: UIFontDescriptor.SymbolicTraits) -> UIFont? {

		if let descriptor = self.fontDescriptor.withSymbolicTraits(trait) {
			return UIFont(descriptor: descriptor, size: self.pointSize)
		}

		return nil
	}

	/**
	 * @method with
	 * @since 0.5.0
	 * @hidden
	 */
	func with(size: CGFloat) -> UIFont? {
		return UIFont(descriptor: self.fontDescriptor, size: size)
	}

	/**
	 * @method with
	 * @since 0.5.0
	 * @hidden
	 */
	func with(size: Double) -> UIFont? {
		return UIFont(descriptor: self.fontDescriptor, size: CGFloat(size))
	}

	/**
	 * @method with
	 * @since 0.5.0
	 * @hidden
	 */
	func with(face: String) -> UIFont? {
		return UIFont(name: face, size: self.pointSize)
	}
}

