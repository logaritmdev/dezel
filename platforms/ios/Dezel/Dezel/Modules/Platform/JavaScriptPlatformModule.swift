/**
 * @class JavaScriptPlatformModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
public class JavaScriptPlatformModule : JavaScriptModule {

    /**
     * @method configure
     * @since 0.7.0
     */
	public override func configure(context: JavaScriptContext) {
		context.registerClass("dezel.platform.Platform", with: JavaScriptPlatform.self)
	}
}
