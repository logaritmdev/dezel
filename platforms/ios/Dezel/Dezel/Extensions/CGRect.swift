/**
 * @extension CGRect
 * @since 0.1.0
 * @hidden
 */
internal extension CGRect {

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init(top: CGFloat, left: CGFloat, width: CGFloat, height: CGFloat) {
		self.init(x: CGFloat(left), y: CGFloat(top), width: CGFloat(width), height: CGFloat(height))
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init(top: Double, left: Double, width: Double, height: Double) {
		self.init(x: CGFloat(left), y: CGFloat(top), width: CGFloat(width), height: CGFloat(height))
	}

	/**
	 * @method setTop
	 * @since 0.1.0
	 * @hidden
	 */
	func setTop(_ value: CGFloat) -> CGRect {
		return CGRect(x: self.origin.x, y: value, width: self.size.width, height: self.size.height)
	}

	/**
	 * @method setLeft
	 * @since 0.1.0
	 * @hidden
	 */
	func setLeft(_ value: CGFloat) -> CGRect {
		return CGRect(x: value, y: self.origin.y, width: self.width, height: self.size.height)
	}

	/**
	 * @method setWidth
	 * @since 0.1.0
	 * @hidden
	 */
	func setWidth(_ value: CGFloat) -> CGRect {
		return CGRect(x: self.origin.x, y: self.origin.y, width: value, height: self.size.height)
	}

	/**
	 * @method setHeight
	 * @since 0.1.0
	 * @hidden
	 */
	func setHeight(_ value: CGFloat) -> CGRect {
		return CGRect(x: self.origin.x, y: self.origin.y, width: self.size.height, height: value)
	}

	/**
	 * @method center
	 * @since 0.1.0
	 * @hidden
	 */
	func center() -> CGPoint {
		return CGPoint(x: self.origin.x + self.width / 2, y: self.origin.y + self.height / 2)
	}
}
