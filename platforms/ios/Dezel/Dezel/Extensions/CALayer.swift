var kTransitionListener: UInt8 = 0

/**
 * @extension CALayer
 * @since 0.1.0
 * @hidden
 */
internal extension CALayer {

	/**
	 * The object that manages this layer.
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
	 * @method createOuterMask
	 * @since 0.1.0
	 * @hidden
	 */
	static func createOuterMask(_ path: CGPath) -> CAShapeLayer {
		let layer = CAShapeLayer()
		layer.actions = nil
		layer.contentsScale = UIScreen.main.scale
		layer.rasterizationScale = UIScreen.main.scale
		layer.path = path
		return layer
	}

	/**
	 * @method createInnerMask
	 * @since 0.1.0
	 * @hidden
	 */
	static func createInnerMask(_ path: CGPath) -> CAShapeLayer {
		let layer = CAShapeLayer()
		layer.actions = nil
		layer.contentsScale = UIScreen.main.scale
		layer.rasterizationScale = UIScreen.main.scale
		layer.fillRule = CAShapeLayerFillRule.evenOdd
		layer.path = path
		return layer
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
