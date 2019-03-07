package ca.logaritm.dezel.extension

/**
 * @property Double.Companion.min
 * @since 0.1.0
 * @hidden
 */
internal val Double.Companion.min: Double
	get() = -Double.MAX_VALUE

/**
 * @property Double.Companion.max
 * @since 0.1.0
 * @hidden
 */
internal val Double.Companion.max: Double
	get() = +Double.MAX_VALUE

/**
 * @method Double.toValidFloat
 * @since 0.1.0
 * @hidden
 */
internal fun Double.toValidFloat(): Float {
	return Float.ofDouble(this)
}

