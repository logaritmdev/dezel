package ca.logaritm.dezel.geom

/**
 * @class Rect
 * @since 0.1.0
 * @hidden
 */
public class Rect(x: Float = 0f, y: Float = 0f, width: Float = 0f, height: Float = 0f) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The rect x coordinates.
	 * @property x
	 * @since 0.5.0
	 */
	public var x: Float = 0f

	/**
	 * The rect y coordinates.
	 * @property y
	 * @since 0.5.0
	 */
	public var y: Float = 0f

	/**
	 * The rect width.
	 * @property width
	 * @since 0.5.0
	 */
	public var width: Float = 0f

	/**
	 * The rect height.
	 * @property height
	 * @since 0.5.0
	 */
	public var height: Float = 0f

	/**
	 * The rect size.
	 * @property size
	 * @since 0.5.0
	 */
	public var size: Size = Size(0f, 0f)
		get() = Size(this.width, this.height)

	//--------------------------------------------------------------------------
	// Method
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {
		this.x = x
		this.y = y
		this.width = width
		this.height = height
	}

	/**
	 * @inherited
	 * @method toString
	 * @since 0.5.0
	 */
	public override fun toString(): String {
		return "x:" + this.x + " y:" + this.y + " width:" + this.width + " height:" + this.height
	}
}
