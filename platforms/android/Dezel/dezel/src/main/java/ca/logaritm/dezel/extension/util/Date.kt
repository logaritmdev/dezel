package ca.logaritm.dezel.extension.util

import ca.logaritm.dezel.util.date.DateFormatter
import java.util.*

/**
 * @property Date.iso
 * @since 0.5.0
 * @hidden
 */
internal val Date.iso: String
	get() = DateFormatter.iso(this)

/**
 * @property Date.format
 * @since 0.5.0
 * @hidden
 */
internal fun Date.format(format: String, locale: String): String {
	return DateFormatter.format(this, format, locale)
}