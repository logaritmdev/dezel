/**
 * @extension Locale
 * @since 0.5.0
 * @hidden
 */
internal extension Locale {

	/**
	 * @property language
	 * @since 0.5.0
	 * @hidden
	 */
	internal var language: String {
		return self.languageCode ?? ""
	}

	/**
	 * @property region
	 * @since 0.5.0
	 * @hidden
	 */
	internal var region: String {
		return self.regionCode ?? ""
	}
}
