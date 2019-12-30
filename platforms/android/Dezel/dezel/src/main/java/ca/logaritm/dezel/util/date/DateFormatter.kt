package ca.logaritm.dezel.util.date

import ca.logaritm.dezel.extension.type.Timezone
import ca.logaritm.dezel.extension.type.toLocale
import java.text.SimpleDateFormat
import java.util.*

/**
 * @class DateFormater
 * @since 0.5.0
 */
public object DateFormatter {

	//--------------------------------------------------------------------------
	//  Properties
	//--------------------------------------------------------------------------

	/**
	 * @property formatters
	 * @since 0.5.0
	 * @hidden
	 */
	private val formatters: MutableMap<String, SimpleDateFormat> = mutableMapOf()

	//--------------------------------------------------------------------------
	//  Methods
	//--------------------------------------------------------------------------

	/**
	 * @method format
	 * @since 0.5.0
	 */
	public fun format(date: Date, format: String, locale: String): String {

		var formatter = this.formatters[format + locale]
		if (formatter == null) {
			formatter = SimpleDateFormat(format, locale.toLocale())
			formatter.timeZone = TimeZone.getDefault()
			this.formatters[format + locale] = formatter
		}

		return formatter.format(date)
	}

	/**
	 * @method iso
	 * @since 0.5.0
	 */
	internal fun iso( date: Date): String {
		var formatter = this.formatters["ISO"]
		if (formatter == null) {
			formatter = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.US)
			formatter.timeZone = Timezone.utc
			this.formatters["ISO"] = formatter
		}

		return formatter.format(date)
	}
}