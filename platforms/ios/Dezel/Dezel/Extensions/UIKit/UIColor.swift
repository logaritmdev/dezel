/**
 * @extension UIFont
 * @since 0.1.0
 * @hidden
 */
internal extension UIColor {

	/**
	 * @property alpha
	 * @since 0.5.0
	 * @hidden
	 */
	var alpha: CGFloat {
		return self.cgColor.alpha
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	convenience init(string: String) {
		self.init(cgColor: CGColorParse(string))
	}	
}