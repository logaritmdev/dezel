import { Point2D } from './Point2d'

/**
 * @class Transform2D
 * @since 0.1.0
 */
export class Transform2D {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	//	a	c	e
	//	b	d	f
	//	0	0	1

	/**
	 * @property a
	 * @since 0.1.0
	 */
	public a = 1

	/**
	 * @property b
	 * @since 0.1.0
	 */
	public b = 0

	/**
	 * @property c
	 * @since 0.1.0
	 */
	public c = 0

	/**
	 * @property d
	 * @since 0.1.0
	 */
	public d = 1

	/**
	 * @property e
	 * @since 0.1.0
	 */
	public e = 0

	/**
	 * @property f
	 * @since 0.1.0
	 */
	public f = 0

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(...args: Array<any>) {

		let transform = args[0]
		if (transform instanceof Transform2D) {
			this.a = transform.a
			this.b = transform.b
			this.c = transform.c
			this.d = transform.d
			this.e = transform.e
			this.f = transform.f
			return
		}

		if (args.length == 6) {
			this.a = parseFloat(args[0])
			this.b = parseFloat(args[1])
			this.c = parseFloat(args[2])
			this.d = parseFloat(args[3])
			this.e = parseFloat(args[4])
			this.f = parseFloat(args[5])
			return
		}

		this.reset()
	}

	/**
	 * @method translate
	 * @since 0.1.0
	 */
	public translate(x: number, y: number) {
		this.e += x * this.a + y * this.b
		this.f += x * this.c + y * this.d
		return this
	}

	/**
	 * @method scale
	 * @since 0.1.0
	 */
	public scale(x: number, y: number) {
		this.a *= x
		this.c *= x
		this.b *= y
		this.d *= y
		return this
	}

	/**
	 * @method rotate
	 * @since 0.1.0
	 */
	public rotate(angle: number) {

		angle = angle || 0

		let cos = Math.cos(angle)
		let sin = Math.sin(angle)

		let a = this.a
		let b = this.b
		let c = this.c
		let d = this.d

		this.a = cos * a + sin * b
		this.b = -sin * a + cos * b
		this.c = cos * c + sin * d
		this.d = -sin * c + cos * d

		return this
	}

	/**
	 * @method concat
	 * @since 0.1.0
	 */
	public concat(...args: Array<any>) {

		let a = 1
		let b = 0
		let c = 0
		let d = 1
		let e = 0
		let f = 0

		let transform = arguments[0]
		if (transform instanceof Transform2D) {
			a = transform.a
			b = transform.b
			c = transform.c
			d = transform.d
			e = transform.e
			f = transform.f
		} else {
			if (typeof args[0] == 'number') this.a = args[0]
			if (typeof args[1] == 'number') this.b = args[1]
			if (typeof args[2] == 'number') this.c = args[2]
			if (typeof args[3] == 'number') this.d = args[3]
			if (typeof args[4] == 'number') this.e = args[4]
			if (typeof args[5] == 'number') this.f = args[5]
		}

		// WRONG
		let ra = a * this.a + c * this.b
		let rb = b * this.a + d * this.b
		let rc = a * this.c + c * this.d
		let rd = b * this.c + d * this.d
		let re = a * this.a + f * this.b
		let rf = b * this.c + f * this.d

		this.a = ra
		this.b = rb
		this.c = rc
		this.d = rd
		this.e = re
		this.f = rf

		return this
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 */
	public reset() {
		this.a = 1
		this.b = 0
		this.c = 0
		this.d = 1
		this.e = 0
		this.f = 0
		return this
	}

	/**
	 * @method transform
	 * @since 0.1.0
	 */
	public transform(point: Point2D) {
		let x = point.x
		let y = point.y
		point.x = this.a * x + this.c * y
		point.y = this.b * x + this.d * y
		return this
	}

	/**
	 * @method isIdentity
	 * @since 0.1.0
	 */
	public isIdentity() {
		return this.a == 1 && this.c == 0 && this.b == 0 && this.d == 1 && this.e == 0 && this.f == 0
	}
}
