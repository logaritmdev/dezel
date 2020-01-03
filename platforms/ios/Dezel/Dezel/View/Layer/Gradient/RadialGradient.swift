/**
 * @class RadialGradient
 * @since 0.1.0
 */
open class RadialGradient {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property colors
	 * @since 0.1.0
	 */
	private(set) public var colors: [CGColor]

	/**
	 * @property points
	 * @since 0.1.0
	 */
	private(set) public var points: [CGFloat]

	/**
	 * @property angle
	 * @since 0.1.0
	 */
	private(set) public var angle: CGFloat


	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public init(colors: [CGColor], points: [CGFloat], angle: CGFloat) {
		self.colors = colors
		self.points = points
		self.angle = angle
	}

	public convenience init(property: JavaScriptProperty) {
		self.init(colors: [], points:[], angle: 0)
	}
}
