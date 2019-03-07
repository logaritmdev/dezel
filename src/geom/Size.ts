/**
 * @class Size
 * @since 0.1.0
 */
export class Size {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property width
	 * @since 0.1.0
	 */
	public width: number = 0

	/**
	 * @property height
	 * @since 0.1.0
	 */
	public height: number = 0

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the size.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(width: number, height: number) {
		this.width = width
		this.height = height
	}

	/**
	 * @method round
	 * @since 0.1.0
	 */
	public round() {
		this.width = Math.round(this.width)
		this.height = Math.round(this.height)
		return this
	}

	/**
	 * @method floor
	 * @since 0.1.0
	 */
	public floor() {
		this.width = Math.floor(this.width)
		this.height = Math.floor(this.height)
		return this
	}

	/**
	 * @method ceil
	 * @since 0.1.0
	 */
	public ceil() {
		this.width = Math.ceil(this.width)
		this.height = Math.ceil(this.height)
		return this
	}
}