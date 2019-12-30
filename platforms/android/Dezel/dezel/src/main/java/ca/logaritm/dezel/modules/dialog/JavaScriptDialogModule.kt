package ca.logaritm.dezel.modules.dialog

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class JavaScriptDialogModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
open class JavaScriptDialogModule: JavaScriptModule() {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	override fun configure(context: JavaScriptContext) {
		context.registerClass("dezel.dialog.Alert", JavaScriptAlert::class.java)
		context.registerClass("dezel.dialog.AlertButton", JavaScriptAlertButton::class.java)
	}
}

