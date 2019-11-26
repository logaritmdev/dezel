/**
 * @class JavaScriptDeviceModule
 * @since 0.7.0
 * @hidden
 */
public class JavaScriptDeviceModule : Module {

    /**
     * @inherited
     * @method register
     * @since 0.7.0
     */
	public override func register(context: JavaScriptContext) {
		context.registerClass("dezel.device.Device", with: JavaScriptDevice.self)
	}
}
