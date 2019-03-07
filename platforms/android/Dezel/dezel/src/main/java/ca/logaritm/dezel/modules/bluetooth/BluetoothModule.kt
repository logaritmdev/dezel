package ca.logaritm.dezel.modules.bluetooth

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class BluetoothModule
 * @since 0.5.0
 */
public class BluetoothModule(context: JavaScriptContext) : Module(context) {

	/**
	 * Initializes this module.
	 * @method initialize
	 * @since 0.5.0
	 */
	public override fun initialize() {
		this.context.registerClass("dezel.bluetooth.BluetoothManager", BluetoothManager::class.java)
	}
}