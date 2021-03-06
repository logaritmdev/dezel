package ca.logaritm.dezel.date

import ca.logaritm.dezel.extension.Timezone
import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.*


/**
 * @class DateParser
 * @since 0.5.0
 * @hidden
 */
internal object DateParser {

	//--------------------------------------------------------------------------
	//  Properties
	//--------------------------------------------------------------------------

	/**
	 * @property parser
	 * @since 0.5.0
	 * @hidden
	 */
	private val parser: SimpleDateFormat = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.US)

	//--------------------------------------------------------------------------
	//  Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.5.0
	 */
	 init {
		this.parser.timeZone = Timezone.utc
	}

	/**
	 * Parses the specified ISO date string.
	 * @method parse
	 * @since 0.5.0
	 */
	public fun parse(string: String): Date {

		try {
			return this.parser.parse(string)
		} catch (e: ParseException) {
			return Date()
		}

	}
}
