import AudioToolbox

/**
 * @class JavaScriptLocale
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptLocale: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public required init(context: JavaScriptContext) {
		super.init(context: context)
		self.language.reset(Locale.current.languageCode ?? "Unknown")
		self.region.reset(Locale.current.regionCode ?? "Unknown")
		self.ltr.reset(UIApplication.shared.userInterfaceLayoutDirection == .leftToRight)
		self.rtl.reset(UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * The locale's language.
	 * @property language
	 * @since 0.7.0
	 */
	open lazy var language = JavaScriptProperty()

	/**
	 * The locale's region.
	 * @property region
	 * @since 0.7.0
	 */
	open lazy var region = JavaScriptProperty()

	/**
	 * Whether the locale is left to right.
	 * @property ltr
	 * @since 0.7.0
	 */
	open lazy var ltr = JavaScriptProperty()

	/**
	 * Whether the locale is right to left.
	 * @property ltr
	 * @since 0.7.0
	 */
	open lazy var rtl = JavaScriptProperty()

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_language
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_language(callback: JavaScriptGetterCallback) {
		callback.returns(self.language)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_region
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_region(callback: JavaScriptGetterCallback) {
		callback.returns(self.region)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_ltr
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_ltr(callback: JavaScriptGetterCallback) {
		callback.returns(self.ltr)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_rtl
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_rtl(callback: JavaScriptGetterCallback) {
		callback.returns(self.rtl)
	}
}
