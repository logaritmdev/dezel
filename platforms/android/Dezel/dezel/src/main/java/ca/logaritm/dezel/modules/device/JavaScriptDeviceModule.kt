package ca.logaritm.dezel.modules.device

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class JavaScriptDeviceModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
open class JavaScriptDeviceModule: JavaScriptModule() {

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	override fun configure(context: JavaScriptContext) {
		context.registerClass("dezel.device.Device", JavaScriptDevice::class.java)
	}
}