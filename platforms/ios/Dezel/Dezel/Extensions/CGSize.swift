/**
 * @extension CGSize
 * @since 0.1.0
 * @hidden
 */
internal extension CGSize {

	/**
	 * @method alignBottom
	 * @since 0.1.0
	 * @hidden
	 */
	internal func alignBottom(of: CGSize) -> CGPoint {
		return CGPoint(x: 0, y: of.height - self.height)
	}

	/**
	 * @method alignMiddle
	 * @since 0.1.0
	 * @hidden
	 */
	internal func alignMiddle(of: CGSize) -> CGPoint {
		return CGPoint(x: 0, y: of.height / 2 - self.height / 2)
	}

	/**
	 * @method setLeft
	 * @since 0.1.0
	 * @hidden
	 */
	internal func setLeft(_ value: CGFloat) -> CGSize {
		return CGSize(width: value, height: self.height)
	}

	/**
	 * @method setTop
	 * @since 0.1.0
	 * @hidden
	 */
	internal func setTop(_ value: CGFloat) -> CGSize {
		return CGSize(width: self.width, height: value)
	}

	/**
	 * @method setWidth
	 * @since 0.1.0
	 * @hidden
	 */
	internal func setWidth(_ value: CGFloat) -> CGSize {
		return CGSize(width: value, height: self.height)
	}

	/**
	 * @method setHeight
	 * @since 0.1.0
	 * @hidden
	 */
	internal func setHeight(_ value: CGFloat) -> CGSize {
		return CGSize(width: self.width, height: value)
	}

	/**
	 * @method addWidth
	 * @since 0.1.0
	 * @hidden
	 */
	func addWidth(_ value:CGFloat) -> CGSize {
		return CGSize(width:self.width + value, height:self.height)
	}

	/**
	 * @method addHeight
	 * @since 0.1.0
	 * @hidden
	 */
	func addHeight(_ value:CGFloat) -> CGSize {
		return CGSize(width:self.width, height:self.height + value)
	}

	/**
	 * @method ceil
	 * @since 0.1.0
	 * @hidden
	 */
	internal mutating func ceil() {
		self = CGSize(width: Foundation.ceil(self.width), height: Foundation.ceil(self.height))
	}

	/**
	 * @method clamp
	 * @since 0.1.0
	 * @hidden
	 */
	internal func clamped(min: CGSize, max: CGSize) -> CGSize {
		// TODO make mutated
		var size = self
		if (size.width < min.width) { size.width = min.width }
		if (size.width > max.width) { size.width = max.width }
		if (size.height < min.height) { size.height = min.height }
		if (size.height > max.height) { size.height = max.height }
		return size
	}
}
