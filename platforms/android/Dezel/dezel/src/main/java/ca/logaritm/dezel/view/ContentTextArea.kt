package ca.logaritm.dezel.view

import android.content.Context
import android.graphics.Paint
import android.view.Gravity
import android.view.KeyEvent
import android.view.View
import android.view.inputmethod.EditorInfo
import android.widget.EditText
import ca.logaritm.dezel.application.DezelApplicationActivity
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.font.FontManager
import ca.logaritm.dezel.view.graphic.Color
import ca.logaritm.dezel.view.graphic.Convert
import ca.logaritm.dezel.view.type.TextAlignment
import ca.logaritm.dezel.view.type.TextDecoration
import ca.logaritm.dezel.view.type.TextPlacement
import ca.logaritm.dezel.view.type.TextTransform
import android.text.InputType as AndroidInputType

/**
 * @class ContentTextArea
 * @since 0.1.0
 * @hidden
 */
open class ContentTextArea(context: Context, listener: ContentTextAreaListener?) : EditText(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text area's value.
	 * @property value
	 * @since 0.1.0
	 */
	open var value: String by Delegates.OnSet("") { value ->
		this.setString(value)
	}

	/**
	 * The text area's placeholder.
	 * @property placeholder
	 * @since 0.1.0
	 */
	open var placeholder: String by Delegates.OnSet("") { value ->
		this.setPlaceholderText(value)
	}

	/**
	 * @property placeholderColor
	 * @since 0.1.0
	 * @hidden
	 */
	open var placeholderColor: Int by Delegates.OnSet(Color.parse("gray")) { value ->
		this.setPlaceholderTextColor(value)
	}

	/**
	 * The text area's font family.
	 * @property fontFamily
	 * @since 0.1.0
	 */
	open var fontFamily: String by Delegates.OnSet("") {
		this.invalidateFont()
	}

	/**
	 * The text area's font weight.
	 * @property fontWeight
	 * @since 0.1.0
	 */
	open var fontWeight: String by Delegates.OnSet("normal") {
		this.invalidateFont()
	}

	/**
	 * The text area's font style.
	 * @property fontStyle
	 * @since 0.1.0
	 */
	open var fontStyle: String by Delegates.OnSet("normal") {
		this.invalidateFont()
	}

	/**
	 * The text area's font size.
	 * @property fontSize
	 * @since 0.1.0
	 */
	open var fontSize: Float by Delegates.OnSet(0.0f) { value ->
		this.textSize = Convert.toDp(value)
	}

	/**
	 * The text area's text horizontal alignment.
	 * @property textAlignment
	 * @since 0.1.0
	 */
	open var textAlignment: TextAlignment by Delegates.OnSet(TextAlignment.START) {
		this.updateGravity()
	}

	/**
	 * The text area's text vertical alignment.
	 * @property textPlacement
	 * @since 0.1.0
	 */
	open var textPlacement: TextPlacement by Delegates.OnSet(TextPlacement.TOP) {
		this.updateGravity()
	}

	/**
	 * The text area's text kerning.
	 * @property textKerning
	 * @since 0.1.0
	 */
	open var textKerning: Float by Delegates.OnSet(0.0f) {
		this.invalidate()
	}

	/**
	 * The text area's text leading.
	 * @property textLeading
	 * @since 0.1.0
	 */
	open var textLeading: Float by Delegates.OnSet(0.0f) { value ->
		this.setLineSpacing(value, 0f)
	}

	/**
	 * The text area's text decoration.
	 * @property textDecoration
	 * @since 0.1.0
	 */
	open var textDecoration: TextDecoration by Delegates.OnSet(TextDecoration.NONE) { value ->

		this.paintFlags = this.paintFlags and Paint.STRIKE_THRU_TEXT_FLAG.inv()
		this.paintFlags = this.paintFlags and Paint.UNDERLINE_TEXT_FLAG.inv()

		when (value) {
			TextDecoration.UNDERLINE   -> this.paintFlags = this.paintFlags or Paint.UNDERLINE_TEXT_FLAG
			TextDecoration.LINETHROUGH -> this.paintFlags = this.paintFlags or Paint.STRIKE_THRU_TEXT_FLAG
			TextDecoration.NONE        -> {}
		}

		this.invalidate()
	}

	/**
	 * The text area's text transform.
	 * @property textTransform
	 * @since 0.1.0
	 */
	open var textTransform: TextTransform by Delegates.OnSet(TextTransform.NONE) {
		this.invalidate()
	}

	/**
	 * The text area's text shadow blur distance.
	 * @property textShadowBlur
	 * @since 0.1.0
	 */
	open var textShadowBlur: Float by Delegates.OnSet(0.0f) {
		this.invalidate()
	}

	/**
	 * The text area's text shadow color.
	 * @property textShadowColor
	 * @since 0.1.0
	 */
	open var textShadowColor: Int by Delegates.OnSet(Color.BLACK) {
		this.invalidate()
	}

	/**
	 * The text area's text shadow vertical offset.
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	open var textShadowOffsetTop: Float by Delegates.OnSet(0.0f) {
		this.invalidate()
	}

	/**
	 * The text area's text shadow horizontal offset.
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	open var textShadowOffsetLeft: Float by Delegates.OnSet(0.0f) {
		this.invalidate()
	}

	/**
	 * The text area's top padding.
	 * @property paddingTop
	 * @since 0.1.0
	 */
	open var paddingTop: Float  by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The text area's left padding.
	 * @property paddingLeft
	 * @since 0.1.0
	 */
	open var paddingLeft: Float  by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The text area's right padding.
	 * @property paddingRight
	 * @since 0.1.0
	 */
	open var paddingRight: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The text area's bottom padding.
	 * @property paddingBottom
	 * @since 0.1.0
	 */
	open var paddingBottom: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The text area autocorrect status.
	 * @property autocorrect
	 * @since 0.1.0
	 */
	open var autocorrect: Boolean by Delegates.OnSet(true) {
		this.updateType()
	}

	/**
	 * The text area autocapitalize status.
	 * @property autocapitalize
	 * @since 0.1.0
	 */
	open var autocapitalize: Boolean by Delegates.OnSet(true) {
		this.updateType()
	}

	/**
	 * @property contentViewListener
	 * @since 0.5.0
	 * @hidden
	 */
	internal var contentViewListener: ContentTextAreaListener? = null

	/**
	 * @property invalidFont
	 * @since 0.1.0
	 * @hidden
	 */
	private var invalidFont: Boolean = true

	/**
	 * @property focusChangeListener
	 * @since 0.1.0
	 * @hidden
	 */
	private val focusChangeListener: View.OnFocusChangeListener = View.OnFocusChangeListener { v, hasFocus ->

		if (hasFocus) {

			val application = this.context
			if (application is DezelApplicationActivity) {
				application.presentSoftKeyboard(v)
			}

			this.contentViewListener?.onFocus(this)

		} else {

			val application = this.context
			if (application is DezelApplicationActivity) {
				application.dismissSoftKeyboard(v)
			}

			this.contentViewListener?.onBlur(this)
		}
	}

	/**
	 * @property initialized
	 * @since 0.1.0
	 * @hidden
	 */
	private var initialized: Boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init {

		this.imeOptions = EditorInfo.IME_FLAG_NO_EXTRACT_UI

		this.background = null

		this.isFocusable = true
		this.isFocusableInTouchMode = true
		this.onFocusChangeListener = this.focusChangeListener

		this.textSize = 17f

		this.setTextColor(Color.BLACK)
		this.setPlaceholderText("")
		this.setPlaceholderTextColor(Color.parse("gray"))
		this.setPadding(0, 0, 0, 0)

		this.updateGravity()

		this.contentViewListener = listener

		this.initialized = true
	}

	/**
	 * @method focus
	 * @since 0.1.0
	 * @hidden
	 */
	open fun focus() {
		if (this.hasFocus() == false) {
			this.requestFocus()
		}
	}

	/**
	 * @method blur
	 * @since 0.1.0
	 * @hidden
	 */
	open fun blur() {
		if (this.hasFocus()) {
			this.clearFocus()
		}
	}

	/**
	 * @method onKeyPreIme
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onKeyPreIme(keyCode: Int, event: KeyEvent): Boolean {

		if (event.keyCode == KeyEvent.KEYCODE_BACK) {
			this.clearFocus()
			return false
		}

		return super.onKeyPreIme(keyCode, event)
	}

	/**
	 * @method onTextChanged
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onTextChanged(text: CharSequence?, start: Int, lengthBefore: Int, lengthAfter: Int) {
		if (this.initialized) {
			this.value = text.toString()
			this.contentViewListener?.onChange(this, text.toString())
		}
	}

	/**
	 * @method onPreDraw
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onPreDraw(): Boolean {

		if (this.invalidFont) {
			this.invalidFont = false
			this.typeface = FontManager.get(this.fontFamily, this.fontWeight, this.fontStyle)
		}

		this.setPadding(
			this.paddingLeft.toInt(),
			this.paddingTop.toInt(),
			this.paddingRight.toInt(),
			this.paddingBottom.toInt()
		)

		this.setShadowLayer(
			this.textShadowBlur,
			this.textShadowOffsetLeft,
			this.textShadowOffsetTop,
			this.shadowColor
		)

		return super.onPreDraw()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateFont
	 * @since 0.1.0
	 * @hidden
	 */
	private fun invalidateFont() {
		if (this.invalidFont == false) {
			this.invalidFont = true
			this.invalidate()
		}
	}

	/**
	 * @method setPlaceholderText
	 * @since 0.1.0
	 * @hidden
	 */
	private fun setPlaceholderText(text: String) {
		this.hint = text
	}

	/**
	 * @method setPlaceholderTextColor
	 * @since 0.1.0
	 * @hidden
	 */
	private fun setPlaceholderTextColor(color: Int) {
		this.setHintTextColor(color)
	}

	/**
	 * @method getString
	 * @since 0.4.0
	 * @hidden
	 */
	private fun getString(): String {
		return this.text.toString()
	}

	/**
	 * @method setString
	 * @since 0.6.0
	 * @hidden
	 */
	private fun setString(value: String) {
		if (this.getString() != value) {
			this.setTextKeepState(value)
		}
	}

	/**
	 * @method updateType
	 * @since 0.1.0
	 * @hidden
	 */
	private fun updateType() {

		var type = 0

		if (this.autocorrect == false) {
			type = type or AndroidInputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS
		}

		if (this.autocapitalize == true) {
			type = type or AndroidInputType.TYPE_TEXT_FLAG_CAP_SENTENCES
		}

		this.inputType = type
	}

	/**
	 * @method updateGravity
	 * @since 0.5.0
	 * @hidden
	 */
	private fun updateGravity() {

		val h = when (this.textAlignment) {
			TextAlignment.START   -> Gravity.START
			TextAlignment.END     -> Gravity.END
			TextAlignment.LEFT    -> Gravity.LEFT
			TextAlignment.CENTER  -> Gravity.CENTER
			TextAlignment.RIGHT   -> Gravity.RIGHT
		}

		val v = when (this.textPlacement) {
			TextPlacement.TOP    -> Gravity.TOP
			TextPlacement.MIDDLE -> Gravity.CENTER_VERTICAL
			TextPlacement.BOTTOM -> Gravity.BOTTOM
		}

		this.gravity = h or v
	}
}
