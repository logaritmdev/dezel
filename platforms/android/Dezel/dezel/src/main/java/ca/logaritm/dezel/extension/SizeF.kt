package ca.logaritm.dezel.extension

import android.util.SizeF

/**
 * @method SizeF.clamp
 * @since 1.0.0
 * @hidden
 */
internal fun SizeF.clamp(min: SizeF, max: SizeF): SizeF {

	var w = this.width
	var h = this.height

	if (w < min.width) w = min.width
	if (w > max.width) w = max.width
	if (h < min.height) h = min.height
	if (h > max.height) h = max.height

	return SizeF(w, h)
}

/**
 * @method SizeF.ceiled()
 * @since 1.0.0
 * @hidden
 */
internal fun SizeF.ceiled(): SizeF {
	return SizeF(this.width.ceil(), this.height.ceil())
}