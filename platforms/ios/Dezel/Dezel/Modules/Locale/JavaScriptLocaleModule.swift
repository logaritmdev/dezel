/**
 * @class JavaScriptLocaleModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
public class JavaScriptLocaleModule : JavaScriptModule {

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	open override func configure(context: JavaScriptContext) {
		context.registerClass("dezel.locale.Locale", with: JavaScriptLocale.self)
	}
}
