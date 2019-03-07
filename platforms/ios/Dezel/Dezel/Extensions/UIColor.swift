/**
 * @extension UIFont
 * @since 0.1.0
 * @hidden
 */
public extension UIColor {

	/**
	 * @property alpha
	 * @since 0.5.0
	 * @hidden
	 */
	public var alpha: CGFloat {
		return self.cgColor.alpha
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	convenience public init(string: String) {
		self.init(cgColor: CGColorParse(string))
	}	
}
