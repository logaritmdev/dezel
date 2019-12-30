package ca.logaritm.dezel.modules.dialog

import android.app.AlertDialog
import android.content.DialogInterface
import android.graphics.Color
import android.graphics.Typeface
import android.os.Handler
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.core.JavaScriptPropertyType
import ca.logaritm.dezel.extension.core.activity
import ca.logaritm.dezel.extension.fatalError
import ca.logaritm.dezel.extension.widget.BottomSheetButton
import ca.logaritm.dezel.modules.graphic.ImageLoader
import ca.logaritm.dezel.view.graphic.Convert
import com.google.android.material.bottomsheet.BottomSheetDialog

/**
 * @class JavaScriptAlert
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptAlert(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property alertDialog
	 * @since 0.7.0
	 * @hidden
	 */
	private var alertDialog: AlertDialog? = null

	/**
	 * @property sheetDialog
	 * @since 0.7.0
	 * @hidden
	 */
	private var sheetDialog: BottomSheetDialog? = null

	/**
	 * @property loader
	 * @since 0.7.0
	 * @hidden
	 */
	private var loader: ImageLoader = ImageLoader(context.activity)

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_present
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_present(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 4) {
			fatalError("Method JavaScriptAlert.present() requires 4 arguments.")
		}

		this.protect()

		val style   = callback.argument(0).string
		val title   = callback.argument(1).string.trim()
		val message = callback.argument(2).string.trim()
		val buttons = mutableListOf<JavaScriptAlertButton>()

		callback.argument(3).forEach { _, value ->
			value.cast(JavaScriptAlertButton::class.java)?.let {
				buttons.add(it)
			}
		}

		when (style) {
			"alert" -> this.presentAlert(title, message, buttons)
			"sheet" -> this.presentSheet(title, message, buttons)
		}

		Handler().postDelayed({
			this.callMethod("nativeOnPresent")
		}, 50)
	}

	/**
	 * @method jsFunction_dismiss
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_dismiss(callback: JavaScriptFunctionCallback) {
		this.alertDialog?.dismiss()
		this.sheetDialog?.dismiss()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method presentAlert
	 * @since 0.7.0
	 * @hidden
	 */
	private fun presentAlert(title: String, message: String, buttons: List<JavaScriptAlertButton>) {

		val builder = AlertDialog.Builder(this.context.activity)
		builder.setTitle(title)
		builder.setMessage(message)

		builder.setOnDismissListener {
			Handler().postDelayed({
				this.callMethod("nativeOnDismiss")
				this.unprotect()
			}, 50)
		}

		var empty = true

		for (button in buttons) {

			val listener = DialogInterface.OnClickListener { _, _ ->
				button.callMethod("nativeOnPress")
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
		this.alertDialog?.setCancelable(false)
		this.alertDialog?.setCanceledOnTouchOutside(false)
		this.alertDialog?.show()
	}

	/**
	 * @method presentSheet
	 * @since 0.7.0
	 * @hidden
	 */
	private fun presentSheet(title: String, message: String, buttons: List<JavaScriptAlertButton>) {

		val normalButtons = mutableListOf<JavaScriptAlertButton>()
		val cancelButtons = mutableListOf<JavaScriptAlertButton>()
		var icons = false

		for (button in buttons) {

			if (button.style.string == "cancel") {
				cancelButtons.add(button)
			} else {
				normalButtons.add(button)
			}

			if (button.image.type == JavaScriptPropertyType.STRING ||
				button.image.type == JavaScriptPropertyType.OBJECT) {
				icons = true
			}
		}

		val sheet = BottomSheetDialog(this.context.activity)

		sheet.setOnDismissListener {
			Handler().postDelayed({
				this.callMethod("nativeOnDismiss")
				this.unprotect()
			}, 50)
		}

		val padding = Convert.toPx(12f).toInt()
		val heading = LinearLayout(this.context.activity)
		val content = LinearLayout(this.context.activity)

		heading.orientation = LinearLayout.VERTICAL
		content.orientation = LinearLayout.VERTICAL

		heading.setPadding(0, padding / 2, 0, padding / 2)
		content.setPadding(0, padding / 2, 0, padding / 2)

		if (title.length > 0) {
			heading.addView(this.createSheetTitleText(title))
		}

		if (message.length > 0) {
			heading.addView(this.createSheetContentText(message))
		}

		for (source in normalButtons) {
			content.addView(this.createSheetButton(sheet, source, icons))
		}

		for (source in cancelButtons) {
			content.addView(this.createSheetButton(sheet, source, icons))
		}

		val layout = LinearLayout(this.context.activity)

		layout.orientation = LinearLayout.VERTICAL

		layout.setPadding(
			padding,
			padding / 2,
			padding,
			padding / 2
		)

		if (heading.childCount > 0) layout.addView(heading)
		if (content.childCount > 0) layout.addView(content)

		sheet.setContentView(layout)
		sheet.show()

		this.sheetDialog = sheet
	}

	/**
	 * @method createSheetTitleText
	 * @since 0.7.0
	 * @hidden
	 */
	private fun createSheetTitleText(text: String): TextView {

		val padding = Convert.toPx(12f).toInt()

		val textView = TextView(this.context.activity)
		textView.text = text
		textView.textSize = 17f
		textView.typeface = Typeface.DEFAULT_BOLD

		textView.setPadding(
			padding,
			padding / 2,
			padding,
			padding / 2
		)

		return textView
	}

	/**
	 * @method createSheetContentText
	 * @since 0.7.0
	 * @hidden
	 */
	private fun createSheetContentText(text: String): TextView {

		val padding = Convert.toPx(12f).toInt()

		val textView = TextView(this.context.activity)
		textView.text = text
		textView.textSize = 15f
		textView.typeface = Typeface.DEFAULT

		textView.setPadding(
			padding,
			padding / 2,
			padding,
			padding / 2
		)

		return textView
	}

	/**
	 * @method createSheetButton
	 * @since 0.7.0
	 * @hidden
	 */
	private fun createSheetButton(sheet: BottomSheetDialog, source: JavaScriptAlertButton, icons: Boolean): Button {

		val button = BottomSheetButton(this.context.activity, source.label.string)

		if (source.style.string == "destructive") {
			button.setTextColor(Color.argb(255, 255, 0, 0))
		}

		val size = Convert.toPx(12f).toInt()

		if (source.image.type == JavaScriptPropertyType.STRING ||
			source.image.type == JavaScriptPropertyType.OBJECT) {

			this.loader.load(source.image) { image ->

				if (image == null) {
					return@load
				}

				button.setIcon(
					image,
					size * 2,
					size * 2,
					size * 3
				)
			}

		} else if (icons) {

			val paddingT = button.paddingTop
			val paddingL = button.paddingLeft
			val paddingR = button.paddingRight
			val paddingB = button.paddingBottom

			button.setPadding(
				paddingL + size * 5,
				paddingT,
				paddingR,
				paddingB
			)
		}

		button.setOnClickListener {
			source.callMethod("nativeOnPress")
			sheet.dismiss()
		}

		return button
	}
}