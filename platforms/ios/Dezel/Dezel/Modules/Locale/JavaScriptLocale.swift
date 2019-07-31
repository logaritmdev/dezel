import AudioToolbox

/**
 * @class JavaScriptLocale
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptLocale: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property language
	 * @since 0.7.0
	 * @hidden
	 */
	private var language: Property

	/**
	 * @property region
	 * @since 0.7.0
	 * @hidden
	 */
	private var region: Property

	/**
	 * @property ltr
	 * @since 0.7.0
	 * @hidden
	 */
	private var ltr: Property

	/**
	 * @property rtl
	 * @since 0.7.0
	 * @hidden
	 */
	private var rtl: Property

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public required init(context: JavaScriptContext) {
		self.language = Property(string: Locale.current.languageCode ?? "Unknown")
		self.region = Property(string: Locale.current.regionCode ?? "Unknown")
		self.ltr = Property(boolean: UIApplication.shared.userInterfaceLayoutDirection == .leftToRight)
		self.rtl = Property(boolean: UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft)
		super.init(context: context)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
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
