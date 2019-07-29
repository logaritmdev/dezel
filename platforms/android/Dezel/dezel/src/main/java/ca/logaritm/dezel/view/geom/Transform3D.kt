package ca.logaritm.dezel.view.geom

/**
 * Provides the transformations methods for a 3d matrix.
 * @class Transform3D
 * @since 0.2.0
 */
public class Transform3D {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	// a1	a2	a3	a4
	// b1	b2	b3	b4
	// c1	c2	c3	c4
	// d1	d2	d3	d4

	/**
	 * public a1
	 * @since 0.1.0
	 */
	public var a1: Double = 1.0

	/**
	 * public b1
	 * @since 0.1.0
	 */
	public var b1: Double = 0.0

	/**
	 * public c1
	 * @since 0.1.0
	 */
	public var c1: Double = 0.0

	/**
	 * public d1
	 * @since 0.1.0
	 */
	public var d1: Double = 1.0

	/**
	 * public a2
	 * @since 0.1.0
	 */
	public var a2: Double = 0.0

	/**
	 * public b2
	 * @since 0.1.0
	 */
	public var b2: Double = 1.0

	/**
	 * public c2
	 * @since 0.1.0
	 */
	public var c2: Double = 0.0

	/**
	 * public d2
	 * @since 0.1.0
	 */
	public var d2: Double = 1.0

	/**
	 * public a3
	 * @since 0.1.0
	 */
	public var a3: Double = 0.0

	/**
	 * public b3
	 * @since 0.1.0
	 */
	public var b3: Double = 0.0

	/**
	 * public c3
	 * @since 0.1.0
	 */
	public var c3: Double = 1.0

	/**
	 * public d3
	 * @since 0.1.0
	 */
	public var d3: Double = 1.0

	/**
	 * public a4
	 * @since 0.1.0
	 */
	public var a4: Double = 0.0

	/**
	 * public b4
	 * @since 0.1.0
	 */
	public var b4: Double = 1.0

	/**
	 * public c4
	 * @since 0.1.0
	 */
	public var c4: Double = 0.0

	/**
	 * public d4
	 * @since 0.1.0
	 */
	public var d4: Double = 1.0

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Translates the matrix.
	 * @method translate
	 * @since 0.1.0
	 */
	public fun translate(x: Double, y: Double, z: Double) {
		this.a4 += x * this.a1 + y * this.a2 + z * this.a3
		this.b4 += x * this.b1 + y * this.b2 + z * this.b3
		this.c4 += x * this.c1 + y * this.c2 + z * this.c3
		this.d4 += x * this.d1 + y * this.d2 + z * this.d3
	}

	/**
	 * Scales the matrix.
	 * @method scale
	 * @since 0.1.0
	 */
	public fun scale(x: Double, y: Double, z: Double) {

		val a1 = x
		val a2 = 0.0
		val a3 = 0.0
		val a4 = 0.0

		val b1 = 0.0
		val b2 = y
		val b3 = 0.0
		val b4 = 0.0

		val c1 = 0.0
		val c2 = 0.0
		val c3 = z
		val c4 = 0.0

		val d1 = 0.0
		val d2 = 0.0
		val d3 = 0.0
		val d4 = 1.0

		this.concat(
			a1, a2, a3, a4,
			b1, b2, b3, b4,
			c1, c2, c3, c4,
			d1, d2, d3, d4
		)
	}

	/**
	 * Rotates the matrix.
	 * @method rotate
	 * @since 0.1.0
	 */
	public fun rotate(x: Double, y: Double, z: Double, angle: Double) {

		var angle = angle / 2.0

		val sinA = Math.sin(angle)
		val cosA = Math.cos(angle)
		val sinA2 = sinA * sinA

		var x = x
		var y = y
		var z = z

		val length = Math.sqrt(x * x + y * y + z * z)
		if (length == 0.0) {
			x = 0.0
			y = 0.0
			z = 1.0
		} else if (length != 1.0) {
			x /= length
			y /= length
			z /= length
		}

		val a1: Double
		val a2: Double
		val a3: Double
		val a4: Double

		val b1: Double
		val b2: Double
		val b3: Double
		val b4: Double

		val c1: Double
		val c2: Double
		val c3: Double
		val c4: Double

		val d1: Double
		val d2: Double
		val d3: Double
		val d4: Double

		if (x == 1.0 && y == 0.0 && z == 0.0) {
			a1 = 1.0
			b1 = 0.0
			c1 = 0.0
			a2 = 0.0
			b2 = 1.0 - 2.0 * sinA2
			c2 = 2.0 * sinA * cosA
			a3 = 0.0
			b3 = -2.0 * sinA * cosA
			c3 = 1.0 - 2.0 * sinA2
			d1 = 0.0
			d2 = 0.0
			d3 = 0.0
			a4 = 0.0
			b4 = 0.0
			c4 = 0.0
			d4 = 1.0
		} else if (x == 0.0 && y == 1.0 && z == 0.0) {
			a1 = 1.0 - 2.0 * sinA2
			b1 = 0.0
			c1 = -2.0 * sinA * cosA
			a2 = 0.0
			b2 = 1.0
			c2 = 0.0
			a3 = 2.0 * sinA * cosA
			b3 = 0.0
			c3 = 1.0 - 2.0 * sinA2
			d1 = 0.0
			d2 = 0.0
			d3 = 0.0
			a4 = 0.0
			b4 = 0.0
			c4 = 0.0
			d4 = 1.0
		} else if (x == 0.0 && y == 0.0 && z == 1.0) {
			a1 = 1.0 - 2.0 * sinA2
			b1 = 2.0 * sinA * cosA
			c1 = 0.0
			a2 = -2.0 * sinA * cosA
			b2 = 1.0 - 2.0 * sinA2
			c2 = 0.0
			a3 = 0.0
			b3 = 0.0
			c3 = 1.0
			d1 = 0.0
			d2 = 0.0
			d3 = 0.0
			a4 = 0.0
			b4 = 0.0
			c4 = 0.0
			d4 = 1.0
		} else {
			val x2 = x * x
			val y2 = y * y
			val z2 = z * z
			a1 = 1.0 - 2.0 * (y2 + z2) * sinA2
			b1 = 2.0 * (x * y * sinA2 + z * sinA * cosA)
			c1 = 2.0 * (x * z * sinA2 - y * sinA * cosA)
			a2 = 2.0 * (y * x * sinA2 - z * sinA * cosA)
			b2 = 1.0 - 2.0 * (z2 + x2) * sinA2
			c2 = 2.0 * (y * z * sinA2 + x * sinA * cosA)
			a3 = 2.0 * (z * x * sinA2 + y * sinA * cosA)
			b3 = 2.0 * (z * y * sinA2 - x * sinA * cosA)
			c3 = 1.0 - 2.0 * (x2 + y2) * sinA2
			d1 = 0.0
			d2 = 0.0
			d3 = 0.0
			a4 = 0.0
			b4 = 0.0
			c4 = 0.0
			d4 = 1.0
		}

		this.concat(
			a1, a2, a3, a4,
			b1, b2, b3, b4,
			c1, c2, c3, c4,
			d1, d2, d3, d4
		)
	}

	/**
	 * Add perspective to the matrix.
	 * @method perspective
	 * @since 0.1.0
	 */
	public fun perspective(d: Double) {

		val p = -1 / d

		this.concat(
			1.0, 0.0, 0.0, 0.0,
			0.0, 1.0, 0.0, 0.0,
			0.0, 0.0, 1.0, 0.0,
			0.0, 0.0, p,   1.0
		)
	}

	/**
	 * Multiply the matrix with the specified matrix.
	 * @method concat
	 * @since 0.1.0
	 */
	public fun concat(a1: Double, a2: Double, a3: Double, a4: Double, b1: Double, b2: Double, b3: Double, b4: Double, c1: Double, c2: Double, c3: Double, c4: Double, d1: Double, d2: Double, d3: Double, d4: Double) {

		val ra1 = a1 * this.a1 + b1 * this.a2 + c1 * this.a3 + d1 * this.a4
		val rb1 = a1 * this.b1 + b1 * this.b2 + c1 * this.b3 + d1 * this.b4
		val rc1 = a1 * this.c1 + b1 * this.c2 + c1 * this.c3 + d1 * this.c4
		val rd1 = a1 * this.d1 + b1 * this.d2 + c1 * this.d3 + d1 * this.d4

		val ra2 = a2 * this.a1 + b2 * this.a2 + c2 * this.a3 + d2 * this.a4
		val rb2 = a2 * this.b1 + b2 * this.b2 + c2 * this.b3 + d2 * this.b4
		val rc2 = a2 * this.c1 + b2 * this.c2 + c2 * this.c3 + d2 * this.c4
		val rd2 = a2 * this.d1 + b2 * this.d2 + c2 * this.d3 + d2 * this.d4

		val ra3 = a3 * this.a1 + b3 * this.a2 + c3 * this.a3 + d3 * this.a4
		val rb3 = a3 * this.b1 + b3 * this.b2 + c3 * this.b3 + d3 * this.b4
		val rc3 = a3 * this.c1 + b3 * this.c2 + c3 * this.c3 + d3 * this.c4
		val rd3 = a3 * this.d1 + b3 * this.d2 + c3 * this.d3 + d3 * this.d4

		val ra4 = a4 * this.a1 + b4 * this.a2 + c4 * this.a3 + d4 * this.a4
		val rb4 = a4 * this.b1 + b4 * this.b2 + c4 * this.b3 + d4 * this.b4
		val rc4 = a4 * this.c1 + b4 * this.c2 + c4 * this.c3 + d4 * this.c4
		val rd4 = a4 * this.d1 + b4 * this.d2 + c4 * this.d3 + d4 * this.d4

		this.a1 = ra1
		this.a2 = ra2
		this.a3 = ra3
		this.a4 = ra4

		this.b1 = rb1
		this.b2 = rb2
		this.b3 = rb3
		this.b4 = rb4

		this.c1 = rc1
		this.c2 = rc2
		this.c3 = rc3
		this.c4 = rc4

		this.d1 = rd1
		this.d2 = rd2
		this.d3 = rd3
		this.d4 = rd4
	}

	/**
	 * Resets the matrix.
	 * @method reset
	 * @since 0.1.0
	 */
	public fun reset() {

		this.a1 = 1.0
		this.a2 = 0.0
		this.a3 = 0.0
		this.a4 = 0.0

		this.b1 = 0.0
		this.b2 = 1.0
		this.b3 = 0.0
		this.b4 = 0.0

		this.c1 = 0.0
		this.c2 = 0.0
		this.c3 = 1.0
		this.c4 = 0.0

		this.d1 = 0.0
		this.d2 = 0.0
		this.d3 = 0.0
		this.d4 = 1.0
	}

	/**
	 * Transforms a point using the matrix.
	 * @method transform
	 * @since 0.1.0
	 */
	public fun transform(point: Point3D) {

		val x = point.x
		val y = point.y
		val z = point.z
		val k = 1

		point.x = this.a1 * x + this.a2 * y + this.a3 * z + this.a4 * k
		point.y = this.b1 * x + this.b2 * y + this.b3 * z + this.b4 * k
		point.z = this.c1 * x + this.c2 * y + this.c3 * z + this.c4 * k
	}

	/**
	 * Indicates whether the matrix is the identity matrix.
	 * @method isIdentity
	 * @since 0.1.0
	 */
	public fun isIdentity(): Boolean {

		if (this.a1 == 1.0 && this.a2 == 0.0 && this.a3 == 0.0 && this.a4 == 0.0 &&
			this.b1 == 0.0 && this.b2 == 1.0 && this.b3 == 0.0 && this.b4 == 0.0 &&
			this.c1 == 0.0 && this.c2 == 0.0 && this.c3 == 1.0 && this.c4 == 0.0 &&
			this.d1 == 0.0 && this.d2 == 0.0 && this.d3 == 0.0 && this.d4 == 1.0) {
			return true
		}

		return false
	}
}