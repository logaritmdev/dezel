package ca.logaritm.dezel.extension.type

import java.util.*

/**
 * @property Double.Companion.min
 * @since 0.1.0
 * @hidden
 */
internal val Double.Companion.min: Double
	get() = -MAX_VALUE

/**
 * @property Double.Companion.max
 * @since 0.1.0
 * @hidden
 */
internal val Double.Companion.max: Double
	get() = +MAX_VALUE

/**
 * @method Double.toValidFloat
 * @since 0.1.0
 * @hidden
 */
internal fun Double.toValidFloat(): Float {
	return Float.ofDouble(this)
}

/**
 * Converts to a string.
 * @method Double.toStr
 * @since 0.7.0
 */
public fun Double.toStr(): String {
	return if (this % 1 == 0.0) String.format(Locale.getDefault(), "%.0f", this) else this.toString()
}

