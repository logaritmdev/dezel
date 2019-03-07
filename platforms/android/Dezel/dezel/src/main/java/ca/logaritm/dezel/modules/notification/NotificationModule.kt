package ca.logaritm.dezel.modules.notification

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class NotificationModule
 * @since 0.1.0
 */
open class NotificationModule(context: JavaScriptContext) : Module(context) {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.notification.NotificationManager", NotificationManager::class.java)
	}
}