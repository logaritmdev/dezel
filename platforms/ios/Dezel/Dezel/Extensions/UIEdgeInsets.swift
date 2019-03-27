/**
 * @extension UIEdgeInsets
 * @since 0.2.0
 * @hidden
 */
internal extension UIEdgeInsets {

	/**
	 * @method setTop
	 * @since 0.2.0
	 * @hidden
	 */
	func setTop(_ value: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: value, left: self.left, bottom: self.bottom, right: self.right)
	}

	/**
	 * @method setLeft
	 * @since 0.2.0
	 * @hidden
	 */
	func setLeft(_ value: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: self.top, left: value, bottom: self.bottom, right: self.right)
	}

	/**
	 * @method setRight
	 * @since 0.2.0
	 * @hidden
	 */
	func setRight(_ value: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: self.top, left: self.left, bottom: self.bottom, right: value)
	}

	/**
	 * @method setBottom
	 * @since 0.2.0
	 * @hidden
	 */
	func setBottom(_ value: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: self.top, left: self.left, bottom: value, right: self.right)
	}
}
