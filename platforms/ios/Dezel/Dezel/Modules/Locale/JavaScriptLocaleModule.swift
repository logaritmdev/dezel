/**
 * @class JavaScriptLocaleModule
 * @since 0.7.0
 * @hidden
 */
public class JavaScriptLocaleModule : Module {

	/**
	 * @inherited
	 * @method register
	 * @since 0.7.0
	 */
	open override func register(context: JavaScriptContext) {
		context.registerClass("dezel.locale.Locale", with: JavaScriptLocale.self)
	}
}
