package ca.logaritm.dezel.modules.locale

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module
import ca.logaritm.dezel.modules.device.JavaScriptLocale


/**
 * @class LocaleModule
 * @since 0.1.0
 * @hidden
 */
open class LocaleModule(context: JavaScriptContext) : Module(context) {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.locale.Locale", JavaScriptLocale::class.java)
	}
}
