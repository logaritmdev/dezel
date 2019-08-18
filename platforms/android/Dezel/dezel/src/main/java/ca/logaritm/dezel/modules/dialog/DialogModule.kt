package ca.logaritm.dezel.modules.dialog

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module

/**
 * @class DialogModule
 * @since 0.1.0
 */
open class DialogModule(context: JavaScriptContext): Module(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.dialog.Alert", JavaScriptAlert::class.java)
		this.context.registerClass("dezel.dialog.AlertButton", JavaScriptAlertButton::class.java)
	}
}

