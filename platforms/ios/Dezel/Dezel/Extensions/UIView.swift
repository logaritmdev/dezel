/**
 * @extension UIView
 * @since 0.1.0
 * @hidden
 */
internal extension UIView {

	/**
	 * @method addSubview
	 * @since 0.7.0
	 * @hidden
	 */
	func addSubview(_ view: View) {
		self.addSubview(view.wrapper)
	}

	/**
	 * @method removeSubview
	 * @since 0.1.0
	 * @hidden
	 */
	func removeSubview(_ view: UIView) {
		if (view.superview == self) {
			view.removeFromSuperview()
		}
	}
}
