/**
 * @extension CGPoint
 * @since 0.1.0
 * @hidden
 */
internal extension CGPoint {

	/**
	 * @method setTop
	 * @since 0.1.0
	 * @hidden
	 */
	func setTop(_ value: CGFloat) -> CGPoint {
		return CGPoint(x: self.x, y: value)
	}

	/**
	 * @method setLeft
	 * @since 0.1.0
	 * @hidden
	 */
	func setLeft(_ value: CGFloat) -> CGPoint {
		return CGPoint(x: value, y: self.y)
	}
}

