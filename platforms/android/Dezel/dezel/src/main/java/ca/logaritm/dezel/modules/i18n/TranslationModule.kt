package ca.logaritm.dezel.modules.i18n

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class TranslationModule
 * @since 0.5.0
 * @hidden
 */
open class TranslationModule(context: JavaScriptContext) : Module(context) {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.i18n.TranslationManager", TranslationManager::class.java)
	}
}