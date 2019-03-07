/**
 * Convenience class to parse dates.
 * @class DateParser
 * @since 0.5.0
 */
open class DateParser {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property parser
	 * @since 0.5.0
	 * @hidden
	 */
	private static var parser: DateFormatter = {
		let parser = DateFormatter()
		parser.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
		parser.timeZone = TimeZone.utc
		return parser
	}()

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Parses the specified ISO date string.
	 * @method parse
	 * @since 0.5.0
	 */
	public static func parse(_ string: String) -> Date {
		return self.parser.date(from: string) ?? Date()
	}	
}
