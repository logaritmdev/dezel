
/**
 * @class Point2D
 * @since 0.2.0
 */
public class Point2D {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property x
	 * @since 0.2.0
	 */
	public var x: Double = 0

	/**
	 * @property y
	 * @since 0.2.0
	 */
	public var y: Double = 0

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.2.0
	 */
	public init(x: Double, y: Double) {
		self.x = x
		self.y = y
	}

	/**
	 * @method round
	 * @since 0.2.0
	 */
	public func round() {
		self.x.round()
		self.y.round()
	}

	/**
	 * @method floor
	 * @since 0.1.0
	 */
	public func floor() {
		self.x.round(.down)
		self.y.round(.down)
	}

	/**
	 * @method ceil
	 * @since 0.1.0
	 */
	public func ceil() {
		self.x.round(.up)
		self.y.round(.up)
	}
}
