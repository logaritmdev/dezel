package ca.logaritm.dezel.extension

/**
 * @method Float.Companion.ceil
 * @since 0.1.0
 * @hidden
 */
internal fun Float.Companion.ceil(value: Float): Float {
	return Math.ceil(value.toDouble()).toFloat()
}