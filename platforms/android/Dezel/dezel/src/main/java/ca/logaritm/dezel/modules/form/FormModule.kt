package ca.logaritm.dezel.modules.form

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class FormModule
 * @since 0.1.0
 */
open class FormModule(context: JavaScriptContext) : Module(context) {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.form.TextInput", JavaScriptTextInput::class.java)
		this.context.registerClass("dezel.form.TextArea", JavaScriptTextArea::class.java)
	}
}