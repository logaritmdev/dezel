/**
 * @class LocaleModule
 * @since 0.1.0
 * @hidden
 */
public class LocaleModule : Module {

	/**
	 * Initializes this module.
	 * @method initialize
	 * @since 0.1.0
	 */
	public override func initialize() {

		let locale = self.context.createEmptyObject()
		locale.property("language", string: Locale.current.languageCode ?? "Unknown")
		locale.property("region", string: Locale.current.regionCode ?? "Unknown")
		locale.property("ltr", boolean: UIApplication.shared.userInterfaceLayoutDirection == .leftToRight)
		locale.property("rtl", boolean: UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft)

		self.context.global.defineProperty(
			"locale",
			value: locale,
			getter: nil,
			setter: nil,
			writable: false,
			enumerable: false,
			configurable: true
		)
	}
}
