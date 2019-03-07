/**
 * @class BluetoothModule
 * @since 0.5.0
 * @hidden
 */
public class BluetoothModule : Module {

	/**
	 * Initializes this module.
	 * @method initialize
	 * @since 0.5.0
	 */
	public override func initialize() {
		self.context.registerClass("dezel.bluetooth.BluetoothManager", type: BluetoothManager.self)
	}
}
