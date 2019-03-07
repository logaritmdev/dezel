package ca.logaritm.dezel.modules.location

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class LocationModule
 * @since 0.1.0
 */
open class LocationModule(context: JavaScriptContext) : Module(context) {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.location.LocationManager", LocationManager::class.java)
	}
}
