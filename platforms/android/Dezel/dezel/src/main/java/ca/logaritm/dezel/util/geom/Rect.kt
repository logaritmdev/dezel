package ca.logaritm.dezel.util.geom

/**
 * @class Rect
 * @since 0.1.0
 */
public class Rect(x: Float = 0f, y: Float = 0f, width: Float = 0f, height: Float = 0f) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property x
	 * @since 0.5.0
	 */
	public var x: Float = 0f

	/**
	 * @property y
	 * @since 0.5.0
	 */
	public var y: Float = 0f

	/**
	 * @property width
	 * @since 0.5.0
	 */
	public var width: Float = 0f

	/**
	 * @property height
	 * @since 0.5.0
	 */
	public var height: Float = 0f

	/**
	 * @property size
	 * @since 0.5.0
	 */
	public val size: Size
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
	 * @method toString
	 * @since 0.5.0
	 */
	public override fun toString(): String {
		return "x:" + this.x + " y:" + this.y + " width:" + this.width + " height:" + this.height
	}
}
