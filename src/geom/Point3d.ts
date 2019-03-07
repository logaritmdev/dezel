/**
 * A Point3D object represents a point in a 3D space.
 * @class Point3D
 * @since 0.1.0
 */
export class Point3D {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The value of the point on the X axis.
	 * @property x
	 * @since 0.1.0
	 */
	public x: number = 0

	/**
	 * The value of the point on the Y axis.
	 * @property y
	 * @since 0.1.0
	 */
	public y: number = 0

	/**
	 * The value of the point on the Z axis.
	 * @property z
	 * @since 0.1.0
	 */
	public z: number = 0

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the point.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(x: number, y: number, z: number) {
		this.x = x
		this.y = y
		this.z = z
	}

	/**
	 * @method round
	 * @since 0.1.0
	 */
	public round() {
		this.x = Math.round(this.x)
		this.y = Math.round(this.y)
		this.z = Math.round(this.z)
		return this
	}

	/**
	 * @method floor
	 * @since 0.1.0
	 */
	public floor() {
		this.x = Math.floor(this.x)
		this.y = Math.floor(this.y)
		this.z = Math.floor(this.z)
		return this
	}

	/**
	 * @method ceil
	 * @since 0.1.0
	 */
	public ceil() {
		this.x = Math.floor(this.x)
		this.y = Math.floor(this.y)
		this.z = Math.floor(this.z)
		return this
	}
}
