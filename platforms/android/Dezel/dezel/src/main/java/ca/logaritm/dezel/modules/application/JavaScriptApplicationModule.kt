package ca.logaritm.dezel.modules.application

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class JavaScriptApplicationModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
open class JavaScriptApplicationModule(context: JavaScriptContext): JavaScriptModule(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.application.Application", JavaScriptApplication::class.java)
	}
}
