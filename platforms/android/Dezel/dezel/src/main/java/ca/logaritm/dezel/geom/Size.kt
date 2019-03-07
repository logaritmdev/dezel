package ca.logaritm.dezel.geom

import android.graphics.PointF
import android.util.SizeF
import ca.logaritm.dezel.extension.ceil

/**
 * @class Size
 * @since 0.5.0
 * @hidden
 */
public class Size(var width: Float = 0f, var height: Float = 0f) {

	public constructor(size: Size) : this(size.width, size.height)
	public constructor(size: SizeF) : this(size.width, size.height)

	/**
	 * @method equals
	 * @since 0.5.0
	 * @hidden
	 */
	public fun equals(size: Size): Boolean {
		return (
			this.width == size.width &&
			this.height == size.height
		)
	}

	/**
	 * Ceils the text size's width and height.
	 * @method ceil
	 * @since 0.5.0
	 */
	public fun ceil() {
		this.width = this.width.ceil()
		this.height = this.height.ceil()
	}

	/**
	 * Returns a new instance with clamped width and height.
	 * @method clamp
	 * @since 0.5.0
	 */
	public fun clamp(min: Size, max: Size): Size {
		var w = this.width
		var h = this.height
		if (w < min.width) w = min.width
		if (w > max.width) w = max.width
		if (h < min.height) h = min.height
		if (h > max.height) h = max.height
		return Size(w, h)
	}

	public fun ceiled(): Size {
		return Size(this.width.ceil(), this.height.ceil())
	}

	/**
	 * Returns a new instance with clamped width and height.
	 * @method clamped
	 * @since 0.5.0
	 */
	public fun clamped(min: Size, max: Size): Size {
		var w = this.width
		var h = this.height
		if (w < min.width) w = min.width
		if (w > max.width) w = max.width
		if (h < min.height) h = min.height
		if (h > max.height) h = max.height
		return Size(w, h)
	}

	public fun clamped(min: SizeF, max: SizeF): SizeF {
		var w = this.width
		var h = this.height
		if (w < min.width) w = min.width
		if (w > max.width) w = max.width
		if (h < min.height) h = min.height
		if (h > max.height) h = max.height
		return SizeF(w, h)
	}

	/**
	 * @method alignMiddle
	 * @since 0.5.0
	 * @hidden
	 */	
	internal fun alignMiddle(of: Size): PointF {
		return PointF(0f, of.height / 2 - this.height / 2)
	}

	/**
	 * @method alignMiddle
	 * @since 0.5.0
	 * @hidden
	 */
	internal fun alignBottom(of: Size): PointF {
		return PointF(0f, of.height - this.height)
	}

	/**
	 * @inherited
	 * @method toString
	 * @since 0.5.0
	 */
	public override fun toString(): String {
		return "width:" + this.width + " height:" + this.height
	}
}
