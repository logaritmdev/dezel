package ca.logaritm.dezel.view.graphic

import android.util.SizeF
import ca.logaritm.dezel.extension.type.max
import ca.logaritm.dezel.extension.type.min
import ca.logaritm.dezel.extension.type.toValidFloat

/**
 * @object Convert
 * @since 0.1.0
 */
public object Convert {

	/**
	 * @property density
	 * @since 0.1.0
	 */
	public var density: Float = 1f

	/**
	 * @method toPx
	 * @since 0.1.0
	 */
	public fun toPx(dp: Float): Float {
		if (dp == Float.max) return Float.max
		if (dp == Float.min) return Float.min
		return dp * this.density
	}

	/**
	 * @method toPx
	 * @since 0.1.0
	 */
	public fun toPx(dp: Double): Float {
		val px = dp.toValidFloat()
		if (px == Float.max) return Float.max
		if (px == Float.min) return Float.min
		return px * this.density
	}

	/**
	 * @method toDp
	 * @since 0.1.0
	 */
	public fun toDp(px: Float): Float {
		return px / this.density
	}

	/**
	 * @method toDp
	 * @since 0.1.0
	 */
	public fun toDp(px: Double): Float {
		return px.toValidFloat() / this.density
	}

	/**
	 * @method toDp
	 * @since 0.1.0
	 */
	public fun toDp(px: Int): Float {
		return px.toFloat() / this.density
	}

	/**
	 * @method toPx
	 * @since 0.1.0
	 */
	public fun toPx(dp: SizeF): SizeF {
		return SizeF(Convert.toPx(dp.width), Convert.toPx(dp.height))
	}

	/**
	 * @method toDp
	 * @since 0.1.0
	 */
	public fun toDp(px: SizeF): SizeF {
		return SizeF(Convert.toDp(px.width), Convert.toDp(px.height))
	}
}
