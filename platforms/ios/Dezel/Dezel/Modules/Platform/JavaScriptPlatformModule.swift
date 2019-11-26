/**
 * @class JavaScriptPlatformModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
public class JavaScriptPlatformModule : JavaScriptModule {

    /**
     * @method register
     * @since 0.7.0
     */
	public override func register(context: JavaScriptContext) {
		context.registerClass("dezel.platform.Platform", with: JavaScriptPlatform.self)
	}
}
