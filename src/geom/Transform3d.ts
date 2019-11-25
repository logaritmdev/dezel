import { Point3D } from './Point3d'

/**
 * Provides the transformations methods for a 3d matrix.
 * @class Transform3D
 * @since 0.1.0
 */
export class Transform3D {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	// a1	a2	a3	a4
	// b1	b2	b3	b4
	// c1	c2	c3	c4
	// d1	d2	d3	d4

	/**
	 * @property a1
	 * @since 0.1.0
	 */
	public a1 = 1

	/**
	 * @property b1
	 * @since 0.1.0
	 */
	public b1 = 0

	/**
	 * @property c1
	 * @since 0.1.0
	 */
	public c1 = 0

	/**
	 * @property d1
	 * @since 0.1.0
	 */
	public d1 = 1

	/**
	 * @property a2
	 * @since 0.1.0
	 */
	public a2 = 0

	/**
	 * @property b2
	 * @since 0.1.0
	 */
	public b2 = 1

	/**
	 * @property c2
	 * @since 0.1.0
	 */
	public c2 = 0

	/**
	 * @property d2
	 * @since 0.1.0
	 */
	public d2 = 1

	/**
	 * @property a3
	 * @since 0.1.0
	 */
	public a3 = 0

	/**
	 * @property b3
	 * @since 0.1.0
	 */
	public b3 = 0

	/**
	 * @property c3
	 * @since 0.1.0
	 */
	public c3 = 1

	/**
	 * @property d3
	 * @since 0.1.0
	 */
	public d3 = 1

	/**
	 * @property a4
	 * @since 0.1.0
	 */
	public a4 = 0

	/**
	 * @property b4
	 * @since 0.1.0
	 */
	public b4 = 1

	/**
	 * @property c4
	 * @since 0.1.0
	 */
	public c4 = 0

	/**
	 * @property d4
	 * @since 0.1.0
	 */
	public d4 = 1

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(...args: Array<any>) {

		let transform = args[0]
		if (transform instanceof Transform3D) {
			this.a1 = transform.a1
			this.a2 = transform.a2
			this.a3 = transform.a3
			this.a4 = transform.a4
			this.b1 = transform.b1
			this.b2 = transform.b2
			this.b3 = transform.b3
			this.b4 = transform.b4
			this.c1 = transform.c1
			this.c2 = transform.c2
			this.c3 = transform.c3
			this.c4 = transform.c4
			this.d1 = transform.d1
			this.d2 = transform.d2
			this.d3 = transform.d3
			this.d4 = transform.d4
			return
		}

		if (args.length == 16) {
			this.a1 = parseFloat(args[0])
			this.a2 = parseFloat(args[1])
			this.a3 = parseFloat(args[2])
			this.a4 = parseFloat(args[3])
			this.b1 = parseFloat(args[4])
			this.b2 = parseFloat(args[5])
			this.b3 = parseFloat(args[6])
			this.b4 = parseFloat(args[7])
			this.c1 = parseFloat(args[8])
			this.c2 = parseFloat(args[9])
			this.c3 = parseFloat(args[10])
			this.c4 = parseFloat(args[11])
			this.d1 = parseFloat(args[12])
			this.d2 = parseFloat(args[13])
			this.d3 = parseFloat(args[14])
			this.d4 = parseFloat(args[15])
			return
		}

		this.reset()
	}

	/**
	 * @method translate
	 * @since 0.1.0
	 */
	translate(x: number, y: number, z: number) {
		this.a4 += x * this.a1 + y * this.a2 + z * this.a3
		this.b4 += x * this.b1 + y * this.b2 + z * this.b3
		this.c4 += x * this.c1 + y * this.c2 + z * this.c3
		this.d4 += x * this.d1 + y * this.d2 + z * this.d3
		return this
	}

	/**
	 * @method scale
	 * @since 0.1.0
	 */
	scale(x: number, y: number, z: number) {

		let a1 = 1, a2 = 0, a3 = 0, a4 = 0
		let b1 = 0, b2 = 1, b3 = 0, b4 = 0
		let c1 = 0, c2 = 0, c3 = 1, c4 = 0
		let d1 = 0, d2 = 0, d3 = 0, d4 = 1

		a1 = x
		b2 = y
		c3 = z

		this.concat(
			a1, a2, a3, a4,
			b1, b2, b3, b4,
			c1, c2, c3, c4,
			d1, d2, d3, d4
		)

		return this
	}

	/**
	 * @method rotate
	 * @since 0.1.0
	 */
	rotate(x: number, y: number, z: number, angle: number) {

		angle /= 2.0
		let sinA = Math.sin(angle)
		let cosA = Math.cos(angle)
		let sinA2 = sinA * sinA

		let length = Math.sqrt(x * x + y * y + z * z)
		if (length == 0) {
			x = 0
			y = 0
			z = 1
		} else if (length != 1) {
			x /= length
			y /= length
			z /= length
		}

		let a1 = 1, a2 = 0, a3 = 0, a4 = 0
		let b1 = 0, b2 = 1, b3 = 0, b4 = 0
		let c1 = 0, c2 = 0, c3 = 1, c4 = 0
		let d1 = 0, d2 = 0, d3 = 0, d4 = 1

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
			d1 = d2 = d3 = 0.0
			a4 = b4 = c4 = 0.0
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
			d1 = d2 = d3 = 0.0
			a4 = b4 = c4 = 0.0
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
			d1 = d2 = d3 = 0.0
			a4 = b4 = c4 = 0.0
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
			d1 = d2 = d3 = 0.0
			a4 = b4 = c4 = 0.0
			d4 = 1.0
		}

		this.concat(
			a1, a2, a3, a4,
			b1, b2, b3, b4,
			c1, c2, c3, c4,
			d1, d2, d3, d4
		)

		return this
	}

	/**
	 * @method perspective
	 * @since 0.1.0
	 */
	perspective(d: number) {

		let p = -1 / d

		this.concat(
			1, 0, 0, 0,
			0, 1, 0, 0,
			0, 0, 1, 0,
			0, 0, p, 1
		)

		return this
	}

	/**
	 * @method concat
	 * @since 0.1.0
	 */
	concat(...args: Array<any>) {

		let a1 = 1
		let b1 = 0
		let c1 = 0
		let d1 = 1
		let a2 = 0
		let b2 = 1
		let c2 = 0
		let d2 = 1
		let a3 = 0
		let b3 = 0
		let c3 = 1
		let d3 = 1
		let a4 = 0
		let b4 = 1
		let c4 = 0
		let d4 = 1

		let transform = args[0]
		if (transform instanceof Transform3D) {
			a1 = transform.a1
			a2 = transform.a2
			a3 = transform.a3
			a4 = transform.a4
			b1 = transform.b1
			b2 = transform.b2
			b3 = transform.b3
			b4 = transform.b4
			c1 = transform.c1
			c2 = transform.c2
			c3 = transform.c3
			c4 = transform.c4
			d1 = transform.d1
			d2 = transform.d2
			d3 = transform.d3
			d4 = transform.d4
		} else if (args.length == 16) {
			a1 = parseFloat(args[0])
			a2 = parseFloat(args[1])
			a3 = parseFloat(args[2])
			a4 = parseFloat(args[3])
			b1 = parseFloat(args[4])
			b2 = parseFloat(args[5])
			b3 = parseFloat(args[6])
			b4 = parseFloat(args[7])
			c1 = parseFloat(args[8])
			c2 = parseFloat(args[9])
			c3 = parseFloat(args[10])
			c4 = parseFloat(args[11])
			d1 = parseFloat(args[12])
			d2 = parseFloat(args[13])
			d3 = parseFloat(args[14])
			d4 = parseFloat(args[15])
			return
		}

		let ra1 = 1, ra2 = 0, ra3 = 0, ra4 = 0
		let rb1 = 0, rb2 = 1, rb3 = 0, rb4 = 0
		let rc1 = 0, rc2 = 0, rc3 = 1, rc4 = 0
		let rd1 = 0, rd2 = 0, rd3 = 0, rd4 = 1

		ra1 = a1 * this.a1 + b1 * this.a2 + c1 * this.a3 + d1 * this.a4
		rb1 = a1 * this.b1 + b1 * this.b2 + c1 * this.b3 + d1 * this.b4
		rc1 = a1 * this.c1 + b1 * this.c2 + c1 * this.c3 + d1 * this.c4
		rd1 = a1 * this.d1 + b1 * this.d2 + c1 * this.d3 + d1 * this.d4

		ra2 = a2 * this.a1 + b2 * this.a2 + c2 * this.a3 + d2 * this.a4
		rb2 = a2 * this.b1 + b2 * this.b2 + c2 * this.b3 + d2 * this.b4
		rc2 = a2 * this.c1 + b2 * this.c2 + c2 * this.c3 + d2 * this.c4
		rd2 = a2 * this.d1 + b2 * this.d2 + c2 * this.d3 + d2 * this.d4

		ra3 = a3 * this.a1 + b3 * this.a2 + c3 * this.a3 + d3 * this.a4
		rb3 = a3 * this.b1 + b3 * this.b2 + c3 * this.b3 + d3 * this.b4
		rc3 = a3 * this.c1 + b3 * this.c2 + c3 * this.c3 + d3 * this.c4
		rd3 = a3 * this.d1 + b3 * this.d2 + c3 * this.d3 + d3 * this.d4

		ra4 = a4 * this.a1 + b4 * this.a2 + c4 * this.a3 + d4 * this.a4
		rb4 = a4 * this.b1 + b4 * this.b2 + c4 * this.b3 + d4 * this.b4
		rc4 = a4 * this.c1 + b4 * this.c2 + c4 * this.c3 + d4 * this.c4
		rd4 = a4 * this.d1 + b4 * this.d2 + c4 * this.d3 + d4 * this.d4

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

		return this
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 */
	reset() {

		this.a1 = 1
		this.a2 = 0
		this.a3 = 0
		this.a4 = 0

		this.b1 = 0
		this.b2 = 1
		this.b3 = 0
		this.b4 = 0

		this.c1 = 0
		this.c2 = 0
		this.c3 = 1
		this.c4 = 0

		this.d1 = 0
		this.d2 = 0
		this.d3 = 0
		this.d4 = 1

		return this
	}

	/**
	 * @method transform
	 * @since 0.1.0
	 */
	transform(point: Point3D) {

		let x = point.x
		let y = point.y
		let z = point.z
		let k = 1

		point.x = this.a1 * x + this.a2 * y + this.a3 * z + this.a4 * k
		point.y = this.b1 * x + this.b2 * y + this.b3 * z + this.b4 * k
		point.z = this.c1 * x + this.c2 * y + this.c3 * z + this.c4 * k

		return this
	}

	/**
	 * @method isIdentity
	 * @since 0.1.0
	 */
	isIdentity() {

		if (this.a1 == 1 && this.a2 == 0 && this.a3 == 0 && this.a4 == 0 &&
			this.b1 == 0 && this.b2 == 1 && this.b3 == 0 && this.b4 == 0 &&
			this.c1 == 0 && this.c2 == 0 && this.c3 == 1 && this.c4 == 0 &&
			this.d1 == 0 && this.d2 == 0 && this.d3 == 0 && this.d4 == 1) {
			return true
		}

		return false
	}
}
