package ca.logaritm.dezel.modules.locale

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class JavaScriptLocaleModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
open class JavaScriptLocaleModule(context: JavaScriptContext) : JavaScriptModule(context) {

	/**
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.locale.Locale", JavaScriptLocale::class.java)
	}
}
