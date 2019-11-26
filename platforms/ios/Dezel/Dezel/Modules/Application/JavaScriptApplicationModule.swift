/**
 * @class JavaScriptApplicationModule
 * @since 0.7.0
 */
public class JavaScriptApplicationModule: Module {

	/**
	 * @inherited
	 * @method register
	 * @since 0.7.0
	 */
	public override func register(context: JavaScriptContext) {
		context.registerClass("dezel.application.Application", with: JavaScriptApplication.self)
	}
}
