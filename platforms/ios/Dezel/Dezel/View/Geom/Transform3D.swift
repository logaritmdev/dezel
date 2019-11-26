/**
 * @class Transform3D
 * @since 0.2.0
 */
public class Transform3D {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	// a1	a2	a3	a4
	// b1	b2	b3	b4
	// c1	c2	c3	c4
	// d1	d2	d3	d4

	/**
	 * @property a1
	 * @since 0.1.0
	 */
	public var a1: Double = 1.0

	/**
	 * @property b1
	 * @since 0.1.0
	 */
	public var b1: Double = 0.0

	/**
	 * @property c1
	 * @since 0.1.0
	 */
	public var c1: Double = 0.0

	/**
	 * @property d1
	 * @since 0.1.0
	 */
	public var d1: Double = 1.0

	/**
	 * @property a2
	 * @since 0.1.0
	 */
	public var a2: Double = 0.0

	/**
	 * @property b2
	 * @since 0.1.0
	 */
	public var b2: Double = 1.0

	/**
	 * @property c2
	 * @since 0.1.0
	 */
	public var c2: Double = 0.0

	/**
	 * @property d2
	 * @since 0.1.0
	 */
	public var d2: Double = 1.0

	/**
	 * @property a3
	 * @since 0.1.0
	 */
	public var a3: Double = 0.0

	/**
	 * @property b3
	 * @since 0.1.0
	 */
	public var b3: Double = 0.0

	/**
	 * @property c3
	 * @since 0.1.0
	 */
	public var c3: Double = 1.0

	/**
	 * @property d3
	 * @since 0.1.0
	 */
	public var d3: Double = 1.0

	/**
	 * @property a4
	 * @since 0.1.0
	 */
	public var a4: Double = 0.0

	/**
	 * @property b4
	 * @since 0.1.0
	 */
	public var b4: Double = 1.0

	/**
	 * @property c4
	 * @since 0.1.0
	 */
	public var c4: Double = 0.0

	/**
	 * @property d4
	 * @since 0.1.0
	 */
	public var d4: Double = 1.0

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method translate
	 * @since 0.1.0
	 */
	public func translate(x: Double, y: Double, z: Double) {
		self.a4 += x * self.a1 + y * self.a2 + z * self.a3
		self.b4 += x * self.b1 + y * self.b2 + z * self.b3
		self.c4 += x * self.c1 + y * self.c2 + z * self.c3
		self.d4 += x * self.d1 + y * self.d2 + z * self.d3
	}

	/**
	 * @method scale
	 * @since 0.1.0
	 */
	public func scale(x: Double, y: Double, z: Double) {

		let a1 = x
		let a2 = 0.0
		let a3 = 0.0
		let a4 = 0.0

		let b1 = 0.0
		let b2 = y
		let b3 = 0.0
		let b4 = 0.0

		let c1 = 0.0
		let c2 = 0.0
		let c3 = z
		let c4 = 0.0

		let d1 = 0.0
		let d2 = 0.0
		let d3 = 0.0
		let d4 = 1.0

		self.concat(
			a1, a2, a3, a4,
			b1, b2, b3, b4,
			c1, c2, c3, c4,
			d1, d2, d3, d4
		)
	}

	/**
	 * @method rotate
	 * @since 0.1.0
	 */
	public func rotate(x: Double, y: Double, z: Double, angle: Double) {

		let angle = angle / 2.0

		let sinA = sin(angle)
		let cosA = cos(angle)
		let sinA2 = sinA * sinA

		var x = x
		var y = y
		var z = z

		let length = sqrt(x * x + y * y + z * z)
		if (length == 0.0) {
			x = 0.0
			y = 0.0
			z = 1.0
		} else if (length != 1.0) {
			x /= length
			y /= length
			z /= length
		}

		let a1: Double
		let a2: Double
		let a3: Double
		let a4: Double

		let b1: Double
		let b2: Double
		let b3: Double
		let b4: Double

		let c1: Double
		let c2: Double
		let c3: Double
		let c4: Double

		let d1: Double
		let d2: Double
		let d3: Double
		let d4: Double

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
			let x2 = x * x
			let y2 = y * y
			let z2 = z * z
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

		self.concat(
			a1, a2, a3, a4,
			b1, b2, b3, b4,
			c1, c2, c3, c4,
			d1, d2, d3, d4
		)
	}

	/**
	 * @method perspective
	 * @since 0.1.0
	 */
	public func perspective(d: Double) {

		let p = -1 / d

		self.concat(
			1.0, 0.0, 0.0, 0.0,
			0.0, 1.0, 0.0, 0.0,
			0.0, 0.0, 1.0, 0.0,
			0.0, 0.0, p,   1.0
		)
	}

	/**
	 * @method concat
	 * @since 0.1.0
	 */
	public func concat(_ a1: Double, _ a2: Double, _ a3: Double, _ a4: Double, _ b1: Double, _ b2: Double, _ b3: Double, _ b4: Double, _ c1: Double, _ c2: Double, _ c3: Double, _ c4: Double, _ d1: Double, _ d2: Double, _ d3: Double, _ d4: Double) {

		let ra1 = a1 * self.a1 + b1 * self.a2 + c1 * self.a3 + d1 * self.a4
		let rb1 = a1 * self.b1 + b1 * self.b2 + c1 * self.b3 + d1 * self.b4
		let rc1 = a1 * self.c1 + b1 * self.c2 + c1 * self.c3 + d1 * self.c4
		let rd1 = a1 * self.d1 + b1 * self.d2 + c1 * self.d3 + d1 * self.d4

		let ra2 = a2 * self.a1 + b2 * self.a2 + c2 * self.a3 + d2 * self.a4
		let rb2 = a2 * self.b1 + b2 * self.b2 + c2 * self.b3 + d2 * self.b4
		let rc2 = a2 * self.c1 + b2 * self.c2 + c2 * self.c3 + d2 * self.c4
		let rd2 = a2 * self.d1 + b2 * self.d2 + c2 * self.d3 + d2 * self.d4

		let ra3 = a3 * self.a1 + b3 * self.a2 + c3 * self.a3 + d3 * self.a4
		let rb3 = a3 * self.b1 + b3 * self.b2 + c3 * self.b3 + d3 * self.b4
		let rc3 = a3 * self.c1 + b3 * self.c2 + c3 * self.c3 + d3 * self.c4
		let rd3 = a3 * self.d1 + b3 * self.d2 + c3 * self.d3 + d3 * self.d4

		let ra4 = a4 * self.a1 + b4 * self.a2 + c4 * self.a3 + d4 * self.a4
		let rb4 = a4 * self.b1 + b4 * self.b2 + c4 * self.b3 + d4 * self.b4
		let rc4 = a4 * self.c1 + b4 * self.c2 + c4 * self.c3 + d4 * self.c4
		let rd4 = a4 * self.d1 + b4 * self.d2 + c4 * self.d3 + d4 * self.d4

		self.a1 = ra1
		self.a2 = ra2
		self.a3 = ra3
		self.a4 = ra4

		self.b1 = rb1
		self.b2 = rb2
		self.b3 = rb3
		self.b4 = rb4

		self.c1 = rc1
		self.c2 = rc2
		self.c3 = rc3
		self.c4 = rc4

		self.d1 = rd1
		self.d2 = rd2
		self.d3 = rd3
		self.d4 = rd4
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 */
	public func reset() {

		self.a1 = 1.0
		self.a2 = 0.0
		self.a3 = 0.0
		self.a4 = 0.0

		self.b1 = 0.0
		self.b2 = 1.0
		self.b3 = 0.0
		self.b4 = 0.0

		self.c1 = 0.0
		self.c2 = 0.0
		self.c3 = 1.0
		self.c4 = 0.0

		self.d1 = 0.0
		self.d2 = 0.0
		self.d3 = 0.0
		self.d4 = 1.0
	}

	/**
	 * @method transform
	 * @since 0.1.0
	 */
	public func transform(point: Point3D) {

		let x = point.x
		let y = point.y
		let z = point.z
		let k = 1.0

		point.x = 0
		point.y = 0
		point.z = 0

		point.x += (self.a1 * x)
		point.x += (self.a2 * y)
		point.x += (self.a3 * z)
		point.x += (self.a4 * k)

		point.y += (self.b1 * x)
		point.y += (self.b2 * y)
		point.y += (self.b3 * z)
		point.y += (self.b4 * k)

		point.z += (self.c1 * x)
		point.z += (self.c2 * y)
		point.z += (self.c3 * z)
		point.z += (self.c4 * k)
	}

	/**
	 * @method isIdentity
	 * @since 0.1.0
	 */
	public func isIdentity() -> Bool {

		if (self.a1 == 1.0 && self.a2 == 0.0 && self.a3 == 0.0 && self.a4 == 0.0 &&
			self.b1 == 0.0 && self.b2 == 1.0 && self.b3 == 0.0 && self.b4 == 0.0 &&
			self.c1 == 0.0 && self.c2 == 0.0 && self.c3 == 1.0 && self.c4 == 0.0 &&
			self.d1 == 0.0 && self.d2 == 0.0 && self.d3 == 0.0 && self.d4 == 1.0) {
			return true
		}

		return false
	}
}
