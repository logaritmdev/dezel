/**
 * @class JavaScriptApplicationModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
public class JavaScriptApplicationModule: JavaScriptModule {

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	public override func configure(context: JavaScriptContext) {
		context.registerClass("dezel.application.Application", with: JavaScriptApplication.self)
	}
}
