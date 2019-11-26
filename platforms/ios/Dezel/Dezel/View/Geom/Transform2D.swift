
/**
 * @class Transform2D
 * @since 0.2.0
 */
public class Transform2D {

	//--------------------------------------------------------------------------
	// MARK: Properties
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
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method translate
	 * @since 0.2.0
	 */
	public func translate(x: Double, y: Double) {
		self.e += x * self.a + y * self.b
		self.f += x * self.c + y * self.d
	}

	/**
	 * @method scale
	 * @since 0.2.0
	 */
	public func scale(x: Double, y: Double) {
		self.a *= x
		self.c *= x
		self.b *= y
		self.d *= y
	}

	/**
	 * @method rotate
	 * @since 0.2.0
	 */
	public func rotate(angle: Double) {

		let cosA = cos(angle)
		let sinA = sin(angle)

		let a = self.a
		let b = self.b
		let c = self.c
		let d = self.d

		self.a = cosA * a + sinA * b
		self.b = -sinA * a + cosA * b
		self.c = cosA * c + sinA * d
		self.d = -sinA * c + cosA * d
	}

	/**
	 * @method concat
	 * @since 0.2.0
	 */
	public func concat(_ a: Double, _ b: Double, _ c: Double, _ d: Double, _ e: Double, _ f: Double) {

		let ra = a * self.a + c * self.b
		let rb = b * self.a + d * self.b
		let rc = a * self.c + c * self.d
		let rd = b * self.c + d * self.d
		let re = a * self.a + f * self.b
		let rf = b * self.c + f * self.d

		self.a = ra
		self.b = rb
		self.c = rc
		self.d = rd
		self.e = re
		self.f = rf
	}

	/**
	 * @method reset
	 * @since 0.2.0
	 */
	public func reset() {
		self.a = 1.0
		self.b = 0.0
		self.c = 0.0
		self.d = 1.0
		self.e = 0.0
		self.f = 0.0
	}

	/**
	 * @method transform
	 * @since 0.2.0
	 */
	public func transform(point: Point2D) {
		let x = point.x
		let y = point.y
		point.x = self.a * x + self.c * y
		point.y = self.b * x + self.d * y
	}

	/**
	 * @method isIdentity
	 * @since 0.2.0
	 */
	public func isIdentity() -> Bool {
		return self.a == 1.0 && self.c == 0.0 && self.b == 0.0 && self.d == 1.0 && self.e == 0.0 && self.f == 0.0
	}
}
