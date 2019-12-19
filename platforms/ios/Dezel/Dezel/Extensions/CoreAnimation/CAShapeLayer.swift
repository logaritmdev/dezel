/**
 * @extension CAShapeLayer
 * @since 0.7.0
 */
internal extension CAShapeLayer {

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	convenience init(path: CGPath) {
		self.init()
		self.path = path
	}
}
