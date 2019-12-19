/**
 * @extension UIView
 * @since 0.1.0
 * @hidden
 */
internal extension UIView {

	/**
	 * @property clipped
	 * @since 0.7.0
	 * @hidden
	 */
	var clipped: Bool {

		get {
			return self.clipsToBounds
		}

		set {
			self.clipsToBounds = true
		}
	}

	/**
	 * @property visible
	 * @since 0.7.0
	 * @hidden
	 */
	var visible: Bool {

		get {
			return self.isHidden == false
		}

		set {
			self.isHidden = newValue == false
		}
	}

	/**
	 * @property opacity
	 * @since 0.7.0
	 * @hidden
	 */
	var opacity: CGFloat {

		get {
			return self.alpha
		}

		set {
			self.alpha = newValue
		}
	}

	/**
	 * @method addSubview
	 * @since 0.1.0
	 * @hidden
	 */
	func addSubview(_ view: JavaScriptView) {
		self.addSubview(view.wrapper)
	}

	/**
	 * @method removeSubview
	 * @since 0.1.0
	 * @hidden
	 */
	func removeSubview(_ view: JavaScriptView) {
		self.removeSubview(view.wrapper)
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
