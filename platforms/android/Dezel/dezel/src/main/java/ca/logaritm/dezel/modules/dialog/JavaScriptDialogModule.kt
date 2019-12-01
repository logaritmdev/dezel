package ca.logaritm.dezel.modules.dialog

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class JavaScriptDialogModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
open class JavaScriptDialogModule(context: JavaScriptContext): JavaScriptModule(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.dialog.Alert", JavaScriptAlert::class.java)
		this.context.registerClass("dezel.dialog.AlertButton", JavaScriptAlertButton::class.java)
	}
}

