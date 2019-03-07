/**
 * A Point2D object represents a point in a 2D space.
 * @class Point2D
 * @since 0.1.0
 */
export class Point2D {

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

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the point.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(x: number, y: number) {
		this.x = x
		this.y = y
	}

	/**
	 * @method round
	 * @since 0.1.0
	 */
	public round() {
		this.x = Math.round(this.x)
		this.y = Math.round(this.y)
		return this
	}

	/**
	 * @method floor
	 * @since 0.1.0
	 */
	public floor() {
		this.x = Math.floor(this.x)
		this.y = Math.floor(this.y)
		return this
	}

	/**
	 * @method ceil
	 * @since 0.1.0
	 */
	public ceil() {
		this.x = Math.ceil(this.x)
		this.y = Math.ceil(this.y)
		return this
	}
}