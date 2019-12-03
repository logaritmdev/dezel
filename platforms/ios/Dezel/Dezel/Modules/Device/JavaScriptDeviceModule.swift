/**
 * @class JavaScriptDeviceModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
public class JavaScriptDeviceModule : JavaScriptModule {

    /**
     * @method configure
     * @since 0.7.0
     */
	public override func configure(context: JavaScriptContext) {
		context.registerClass("dezel.device.Device", with: JavaScriptDevice.self)
	}
}
