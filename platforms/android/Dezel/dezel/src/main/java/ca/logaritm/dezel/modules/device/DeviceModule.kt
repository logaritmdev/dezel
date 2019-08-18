package ca.logaritm.dezel.modules.device

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class DeviceModule
 * @since 0.4.0
 * @hidden
 */
open class DeviceModule(context: JavaScriptContext) : Module(context) {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.4.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.device.Device", JavaScriptDevice::class.java)
	}
}