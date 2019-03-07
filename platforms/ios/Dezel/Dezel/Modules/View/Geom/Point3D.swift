
/**
 * @class Point3D
 * @since 0.2.0
 */
public class Point3D {

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

	/**
	 * @property z
	 * @since 0.2.0
	 */
	public var z: Double = 0

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.2.0
	 */
	public init(x: Double, y: Double, z: Double) {
		self.x = x
		self.y = y
		self.z = z
	}

	/**
	 * @method round
	 * @since 0.2.0
	 */
	public func round() {
		self.x.round()
		self.y.round()
		self.z.round()
	}

	/**
	 * @method floor
	 * @since 0.2.0
	 */
	public func floor() {
		self.x.round(.down)
		self.y.round(.down)
		self.z.round(.down)
	}

	/**
	 * @method ceil
	 * @since 0.2.0
	 */
	public func ceil() {
		self.x.round(.up)
		self.y.round(.up)
		self.z.round(.up)
	}
}
