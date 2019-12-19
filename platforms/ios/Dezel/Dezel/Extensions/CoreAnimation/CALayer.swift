var kTransitionListener: UInt8 = 0

/**
 * @extension CALayer
 * @since 0.1.0
 * @hidden
 */
internal extension CALayer {

	/**
	 * @property listener
	 * @since 0.2.0
	 */
	var listener: AnyObject? {

		get {
			return objc_getAssociatedObject(self, &kTransitionListener) as AnyObject
		}

		set {
			objc_setAssociatedObject(self, &kTransitionListener, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
		}
	}

	/**
	 * @method maskColor
	 * @since 0.7.0
	 * @hidden
	 */
	var maskColor: CGColor? {

		get {
			return self.backgroundColor
		}

		set {
			self.backgroundColor = newValue
		}
	}

	/**
	 * @method maskShape
	 * @since 0.7.0
	 * @hidden
	 */
	var maskShape: CALayer? {

		get {
			return self.mask
		}

		set {
			self.mask = newValue
		}
	}

	/**
	 * @method setup
	 * @since 0.1.0
	 * @hidden
	 */
	func setup() {
		self.actions = nil
		self.contentsScale = UIScreen.main.scale
		self.rasterizationScale = UIScreen.main.scale
	}

	/**
	 * @method setContent
	 * @since 0.1.0
	 * @hidden
	 */
	func setContent(_ image: UIImage, center: CGPoint) {

		let w = image.size.width
		let h = image.size.height

		self.contents = image.cgImage
		self.contentsCenter = CGRect(
			x: center.x / w,
			y: center.y / h,
			width: 1 / w,
			height: 1 / h
		)
	}

	/**
	 * @method insertLayer
	 * @since 0.1.0
	 * @hidden
	 */
	func insertLayer(_ layer: CALayer, at: Int) {
		self.insertSublayer(layer, at: UInt32(at))
	}

	/**
	 * @method removeLayer
	 * @since 0.1.0
	 * @hidden
	 */
	func removeLayer(_ layer: CALayer) {
		layer.removeFromSuperlayer()
	}
}
