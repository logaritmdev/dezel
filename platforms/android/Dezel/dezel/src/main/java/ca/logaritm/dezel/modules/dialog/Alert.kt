package ca.logaritm.dezel.modules.dialog

import android.app.AlertDialog
import android.content.DialogInterface
import android.os.Handler
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback

/**
 * @class Alert
 * @since 0.1.0
 * @hidden
 */
open class Alert(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property alertDialog
	 * @since 0.1.0
	 * @hidden
	 */
	private var alertDialog: AlertDialog? = null

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_present
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_present(callback: JavaScriptFunctionCallback) {

		this.protect()

		val title   = callback.argument(0).string
		val message = callback.argument(1).string
		val buttons = callback.argument(2)
		
		val builder = AlertDialog.Builder(this.context.application)
		builder.setTitle(title)
		builder.setMessage(message)

		builder.setOnDismissListener {
			Handler().postDelayed({
				this.holder.callMethod("nativeDismiss")
				this.unprotect()
			}, 50)
		}

		var empty = true

		buttons.forEach { _, value ->

			val button = value.cast(AlertButton::class.java)
			if (button == null) {
				return@forEach
			}

			val listener = DialogInterface.OnClickListener { _, _ ->
				button.holder.callMethod("nativePress")
			}

			when (button.style.string) {

				"normal" -> {
					builder.setNeutralButton(button.label.string, listener)
				}

				"cancel" -> {
					builder.setPositiveButton(button.label.string, listener)
				}

				"destructive" -> {
					builder.setNegativeButton(button.label.string, listener)
				}
			}

			empty = false
		}

		if (empty) {
			builder.setNeutralButton("OK", null)
		}

		this.alertDialog = builder.create()
		this.alertDialog?.show()

		Handler().postDelayed({
			this.holder.callMethod("nativePresent")
		}, 50)
	}

	/**
	 * @method jsFunction_dismiss
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_dismiss(callback: JavaScriptFunctionCallback) {
		this.alertDialog?.hide()
	}
}