package ca.logaritm.dezel.geom

import android.graphics.PointF
import android.util.SizeF
import kotlin.math.ceil

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
		this.width = ceil(this.width)
		this.height = ceil(this.height)
	}

	/**
	 * Returns a new instance with clamped width and height.
	 * @method clamped
	 * @since 0.5.0
	 */
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
	 * @method toMiddleOf
	 * @since 0.5.0
	 * @hidden
	 */	
	internal fun toMiddleOf(of: Size): PointF {
		return PointF(0f, of.height / 2 - this.height / 2)
	}

	/**
	 * @method toBottomOf
	 * @since 0.5.0
	 * @hidden
	 */
	internal fun toBottomOf(of: Size): PointF {
		return PointF(0f, of.height - this.height)
	}
}
