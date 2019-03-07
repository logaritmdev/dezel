package ca.logaritm.dezel.modules.application

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class ApplicationModule
 * @since 0.1.0
 */
open class ApplicationModule(context: JavaScriptContext): Module(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.application.Application", Application::class.java)
	}
}
