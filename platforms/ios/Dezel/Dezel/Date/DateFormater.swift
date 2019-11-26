/**
 * @class DateFormater
 * @since 0.5.0
 * @hidden
 */
public class DateFormater {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property formatter
	 * @since 0.5.0
	 * @hidden
	 */
	private static var formatter: DateFormatter = {
		return DateFormatter()
	}()

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method format
	 * @since 0.5.0
	 * @hidden
	 */
	public static func format(_ date: Date, format: String, locale: String) -> String {
		self.formatter.dateFormat = format
		self.formatter.timeZone = TimeZone.current
		self.formatter.locale = locale.toLocale()
		return self.formatter.string(from: date)
	}

	/**
	 * @method iso
	 * @since 0.5.0
	 * @hidden
	 */
	public static func iso(_ date: Date) -> String {
		self.formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
		self.formatter.timeZone = TimeZone.utc
		return self.formatter.string(from: date)
	}
}
