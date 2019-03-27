/**
 * @extension UIView
 * @since 0.1.0
 * @hidden
 */
internal extension UIView {

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
