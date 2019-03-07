/**
 * @extension TimeZone
 * @since 0.5.0
 * @hidden
 */
internal extension TimeZone {

	/**
	 * @property utc
	 * @since 0.6.0
	 * @hidden
	 */
	internal static var utc: TimeZone {
		return TimeZone(secondsFromGMT: 0)!
	}
}
