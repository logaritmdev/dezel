package ca.logaritm.dezel.view.geom

/**
 * @class Point3D
 * @since 0.2.0
 */
public data class Point3D(var x: Double, var y: Double, var z: Double) {

	/**
	 * @method round
	 * @since 0.2.0
	 */
	public fun round() {
		this.x = Math.round(this.x).toDouble()
		this.y = Math.round(this.y).toDouble()
		this.z = Math.round(this.z).toDouble()
	}

	/**
	 * @method floor
	 * @since 0.2.0
	 */
	public fun floor() {
		this.x = Math.floor(this.x)
		this.y = Math.floor(this.y)
		this.z = Math.floor(this.z)
	}

	/**
	 * @method ceil
	 * @since 0.2.0
	 */
	public fun ceil() {
		this.x = Math.floor(this.x)
		this.y = Math.floor(this.y)
		this.z = Math.floor(this.z)
	}
}