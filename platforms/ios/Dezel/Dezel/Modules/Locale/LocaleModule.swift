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
		self.context.registerClass("dezel.locale.Locale", with: JavaScriptLocale.self)
	}
}
