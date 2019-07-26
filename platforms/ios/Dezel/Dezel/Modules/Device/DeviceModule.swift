/**
 * @class DeviceModule
 * @since 0.4.0
 * @hidden
 */
public class DeviceModule : Module {

    /**
     * @inherited
     * @method initialize
     * @since 0.4.0
     */
	public override func initialize() {
		self.context.registerClass("dezel.device.Device", with: Device.self)
	}
}
