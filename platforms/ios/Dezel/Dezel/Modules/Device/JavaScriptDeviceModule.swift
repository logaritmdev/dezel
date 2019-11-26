/**
 * @class JavaScriptDeviceModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
public class JavaScriptDeviceModule : JavaScriptModule {

    /**
     * @method register
     * @since 0.7.0
     */
	public override func register(context: JavaScriptContext) {
		context.registerClass("dezel.device.Device", with: JavaScriptDevice.self)
	}
}
