private var gradientLayerKey: UInt8 = 0
private var backgroundLinearGradientKey: UInt8 = 0
private var backgroundRadiaoGradientKey: UInt8 = 0
private var invalidBackgroundLinearGradientKey: UInt8 = 0
private var invalidBackgroundRadiaoGradientKey: UInt8 = 0

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
	 * @property gradientLayer
	 * @since 0.7.0
	 * @hidden
	 */
	var gradientLayer: Layer? {

		get {
			return objc_getAssociatedObject(self, &gradientLayerKey) as? Layer
		}

		set {
			objc_setAssociatedObject(self, &gradientLayerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	/**
	 * @property backgroundLinearGradient
	 * @since 0.7.0
	 * @hidden
	 */
    var backgroundLinearGradient: LinearGradient? {

		get {
			return objc_getAssociatedObject(self, &backgroundLinearGradientKey) as? LinearGradient
		}

		set {
			objc_setAssociatedObject(self, &backgroundLinearGradientKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			self.invalidBackgroundLinearGradient = true
		}
	}

	/**
	 * @property backgroundRadialGradient
	 * @since 0.7.0
	 * @hidden
	 */
    var backgroundRadialGradient: RadialGradient? {

		get {
			return objc_getAssociatedObject(self, &backgroundRadiaoGradientKey) as? RadialGradient
		}

		set {
			objc_setAssociatedObject(self, &backgroundRadiaoGradientKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			self.invalidBackgroundRadialGradient = true
		}
	}

	/**
	 * @property invalidBackgroundLinearGradient
	 * @since 0.7.0
	 * @hidden
	 */
    private var invalidBackgroundLinearGradient: Bool {

		get {
			return objc_getAssociatedObject(self, &invalidBackgroundLinearGradientKey) as? Bool ?? false
		}

		set {
			objc_setAssociatedObject(self, &invalidBackgroundLinearGradientKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
		}
	}

	/**
	 * @property invalidBackgroundRadialGradient
	 * @since 0.7.0
	 * @hidden
	 */
    private var invalidBackgroundRadialGradient: Bool {

		get {
			return objc_getAssociatedObject(self, &invalidBackgroundRadiaoGradientKey) as? Bool ?? false
		}

		set {
			objc_setAssociatedObject(self, &invalidBackgroundRadiaoGradientKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
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

	/**
	 * @method updateGradient
	 * @since 0.7.0
	 * @hidden
	 */
	func updateGradient() {

		if (self.backgroundLinearGradient == nil &&
			self.backgroundRadialGradient == nil) {

			if (self.gradientLayer != nil) {
				self.gradientLayer?.removeFromSuperlayer()
				self.gradientLayer = nil
			}

			return
		}

		if (self.gradientLayer == nil) {
			self.gradientLayer = Layer()
			self.layer.insertSublayer(self.gradientLayer!, at: 0)
		}

		guard let layer = self.gradientLayer else {
			return
		}

		layer.frame = self.bounds

		if (self.invalidBackgroundLinearGradient ||
			self.invalidBackgroundRadialGradient) {

			self.invalidBackgroundLinearGradient = false
			self.invalidBackgroundRadialGradient = false

			if let gradient = self.backgroundLinearGradient {

				let pi = CGFloat(Double.pi)

				let x = (gradient.angle + pi / 2) / (2 * pi)

				let a = pow(sin((2 * pi * ((x + 0.75) / 2))), 2)
				let b = pow(sin((2 * pi * ((x + 0.00) / 2))), 2)
				let c = pow(sin((2 * pi * ((x + 0.25) / 2))), 2)
				let d = pow(sin((2 * pi * ((x + 0.50) / 2))), 2)

				layer.applyGradient(
					colors: gradient.colors,
					points: gradient.points,
					start: CGPoint(x: a, y: b),
					end:   CGPoint(x: c, y: d)
				)

				return
			}
			/*
			if let gradient = self.backgroundRadialGradient {
				// TODO
			}
			*/
		}
	}
}
