package ca.logaritm.dezel.view.geom

/**
 * Provides the transformations methods for a 2d matrix.
 * @class Transform2D
 * @since 0.2.0
 */
public class Transform2D {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	//	a	c	e
	//	b	d	f
	//	0	0	1

	/**
	 * @property a
	 * @since 0.2.0
	 */
	public var a: Double = 1.0

	/**
	 * @property b
	 * @since 0.2.0
	 */
	public var b: Double = 0.0

	/**
	 * @property c
	 * @since 0.2.0
	 */
	public var c: Double = 0.0

	/**
	 * @property d
	 * @since 0.2.0
	 */
	public var d: Double = 1.0

	/**
	 * @property e
	 * @since 0.2.0
	 */
	public var e: Double = 0.0

	/**
	 * @property f
	 * @since 0.2.0
	 */
	public var f: Double = 0.0

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Translates the matrix.
	 * @method translate
	 * @since 0.2.0
	 */
	public fun translate(x: Double, y: Double) {
		this.e += x * this.a + y * this.b
		this.f += x * this.c + y * this.d
	}

	/**
	 * Scales the matrix.
	 * @method scale
	 * @since 0.2.0
	 */
	public fun scale(x: Double, y: Double) {
		this.a *= x
		this.c *= x
		this.b *= y
		this.d *= y
	}

	/**
	 * Rotates the matrix.
	 * @method rotate
	 * @since 0.2.0
	 */
	public fun rotate(angle: Double) {

		val cosA = Math.cos(angle)
		val sinA = Math.sin(angle)

		val a = this.a
		val b = this.b
		val c = this.c
		val d = this.d

		this.a = cosA * a + sinA * b
		this.b = -sinA * a + cosA * b
		this.c = cosA * c + sinA * d
		this.d = -sinA * c + cosA * d
	}

	/**
	 * Multiply the matrix with the specified matrix.
	 * @method concat
	 * @since 0.2.0
	 */
	public fun concat(a: Double, b: Double, c: Double, d: Double, e: Double, f: Double) {

		val ra = a * this.a + c * this.b
		val rb = b * this.a + d * this.b
		val rc = a * this.c + c * this.d
		val rd = b * this.c + d * this.d
		val re = a * this.a + f * this.b
		val rf = b * this.c + f * this.d

		this.a = ra
		this.b = rb
		this.c = rc
		this.d = rd
		this.e = re
		this.f = rf
	}

	/**
	 * Resets the matrix.
	 * @method reset
	 * @since 0.2.0
	 */
	public fun reset() {
		this.a = 1.0
		this.b = 0.0
		this.c = 0.0
		this.d = 1.0
		this.e = 0.0
		this.f = 0.0
	}

	/**
	 * Transforms a point using the matrix.
	 * @method transform
	 * @since 0.2.0
	 */
	public fun transform(point: Point2D) {
		val x = point.x
		val y = point.y
		point.x = this.a * x + this.c * y
		point.y = this.b * x + this.d * y
	}

	/**
	 * Indicates whether the matrix is the identity matrix.
	 * @method isIdentity
	 * @since 0.2.0
	 */
	public fun isIdentity(): Boolean {
		return this.a == 1.0 && this.c == 0.0 && this.b == 0.0 && this.d == 1.0 && this.e == 0.0 && this.f == 0.0
	}
}