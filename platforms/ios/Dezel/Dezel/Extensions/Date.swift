/**
 * @extension Date
 * @since 0.5.0
 * @hidden
 */
internal extension Date {

	/**
	 * @property iso
	 * @since 0.5.0
	 * @hidden
	 */
	internal var iso: String {
		return DateFormater.iso(self)
	}

	/**
	 * @method format
	 * @since 0.5.0
	 * @hidden
	 */
	internal func format(_ format: String, _ locale: String) -> String {
		return DateFormater.format(self, format: format, locale: locale)
	}
}
