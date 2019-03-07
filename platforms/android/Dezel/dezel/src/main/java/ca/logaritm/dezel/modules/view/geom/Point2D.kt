package ca.logaritm.dezel.modules.view.geom

/**
 * @class Point2D
 * @since 0.2.0
 */
public data class Point2D(var x: Double, var y: Double) {

	/**
	 * @method round
	 * @since 0.2.0
	 */
	public fun round() {
		this.x = Math.round(this.x).toDouble()
		this.y = Math.round(this.y).toDouble()
	}

	/**
	 * @method floor
	 * @since 0.1.0
	 */
	public fun floor() {
		this.x = Math.floor(this.x)
		this.y = Math.floor(this.y)
	}

	/**
	 * @method ceil
	 * @since 0.1.0
	 */
	public fun ceil() {
		this.x = Math.ceil(this.x)
		this.y = Math.ceil(this.y)
	}
}