package ca.logaritm.dezel.modules.device

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class JavaScriptDeviceModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
open class JavaScriptDeviceModule(context: JavaScriptContext) : JavaScriptModule(context) {

	/**
	 * @method initialize
	 * @since 0.4.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.device.Device", JavaScriptDevice::class.java)
	}
}