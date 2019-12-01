package ca.logaritm.dezel.modules.form

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class JavaScriptFormModule
 * @super JavaScriptModule
 * @since 0.1.0
 */
open class JavaScriptFormModule(context: JavaScriptContext) : JavaScriptModule(context) {

	/**
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.form.TextInput", JavaScriptTextInput::class.java)
		this.context.registerClass("dezel.form.TextArea", JavaScriptTextArea::class.java)
	}
}