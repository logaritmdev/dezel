/**
 * @class JavaScriptPlatformModule
 * @since 0.7.0
 * @hidden
 */
public class JavaScriptPlatformModule : Module {

    /**
     * @inherited
     * @method register
     * @since 0.7.0
     */
	public override func register(context: JavaScriptContext) {
		context.registerClass("dezel.platform.Platform", with: JavaScriptPlatform.self)
	}
}
