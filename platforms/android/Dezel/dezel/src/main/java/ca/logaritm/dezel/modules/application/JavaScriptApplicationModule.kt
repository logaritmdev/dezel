package ca.logaritm.dezel.modules.application

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class JavaScriptApplicationModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
open class JavaScriptApplicationModule: JavaScriptModule() {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	override fun configure(context: JavaScriptContext) {
		context.registerClass("dezel.application.Application", JavaScriptApplication::class.java)
	}
}
