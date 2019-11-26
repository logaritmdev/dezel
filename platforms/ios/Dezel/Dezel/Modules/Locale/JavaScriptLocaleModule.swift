/**
 * @class JavaScriptLocaleModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
public class JavaScriptLocaleModule : JavaScriptModule {

	/**
	 * @method register
	 * @since 0.7.0
	 */
	open override func register(context: JavaScriptContext) {
		context.registerClass("dezel.locale.Locale", with: JavaScriptLocale.self)
	}
}
