package ca.logaritm.dezel.modules.form

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class JavaScriptFormModule
 * @super JavaScriptModule
 * @since 0.1.0
 */
open class JavaScriptFormModule: JavaScriptModule() {

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	override fun configure(context: JavaScriptContext) {
		context.registerClass("dezel.form.TextInput", JavaScriptTextInput::class.java)
		context.registerClass("dezel.form.TextArea", JavaScriptTextArea::class.java)
	}
}