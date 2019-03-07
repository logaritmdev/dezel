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
	internal func setTop(_ value: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: value, left: self.left, bottom: self.bottom, right: self.right)
	}

	/**
	 * @method setLeft
	 * @since 0.2.0
	 * @hidden
	 */
	internal func setLeft(_ value: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: self.top, left: value, bottom: self.bottom, right: self.right)
	}

	/**
	 * @method setRight
	 * @since 0.2.0
	 * @hidden
	 */
	internal func setRight(_ value: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: self.top, left: self.left, bottom: self.bottom, right: value)
	}

	/**
	 * @method setBottom
	 * @since 0.2.0
	 * @hidden
	 */
	internal func setBottom(_ value: CGFloat) -> UIEdgeInsets {
		return UIEdgeInsets(top: self.top, left: self.left, bottom: value, right: self.right)
	}
}
