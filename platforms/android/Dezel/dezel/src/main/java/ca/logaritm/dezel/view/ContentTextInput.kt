package ca.logaritm.dezel.view

import android.app.DatePickerDialog
import android.app.TimePickerDialog
import android.content.Context
import android.graphics.Paint
import android.text.method.PasswordTransformationMethod
import android.view.Gravity
import android.view.KeyEvent
import android.view.View
import android.view.inputmethod.EditorInfo
import android.widget.DatePicker
import android.widget.EditText
import android.widget.TimePicker
import ca.logaritm.dezel.application.ApplicationActivity
import ca.logaritm.dezel.date.DateParser
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.format
import ca.logaritm.dezel.extension.iso
import ca.logaritm.dezel.font.FontManager
import ca.logaritm.dezel.view.graphic.Color
import ca.logaritm.dezel.view.graphic.Convert
import ca.logaritm.dezel.view.type.*
import java.util.*
import android.text.InputType as AndroidInputType

/**
 * @class ContentTextInput
 * @since 0.1.0
 * @hidden
 */
open class ContentTextInput(context: Context, listener: ContentTextInputListener?) : EditText(context), View.OnClickListener, DatePickerDialog.OnDateSetListener, TimePickerDialog.OnTimeSetListener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text input's input type.
	 * @property type
	 * @since 0.1.0
	 */
	open var type: InputType by Delegates.OnSet(InputType.TEXT) {
		this.updateType()
	}

	/**
	 * The text input's value.
	 * @property value
	 * @since 0.1.0
	 */
	open var value: String by Delegates.OnSet("") { value ->

		if (this.type == InputType.DATE ||
			this.type == InputType.TIME) {

			val date = DateParser.parse(value)

			this.date = date

			this.setString(date.format(
				this.format,
				this.locale
			))

		} else {

			this.setString(value)

		}
	}

	/**
	 * The text input's placeholder.
	 * @property placeholder
	 * @since 0.1.0
	 */
	open var placeholder: String by Delegates.OnSet("") { value ->
		this.setPlaceholderText(value)
	}

	/**
	 * The text input's placeholder color.
	 * @property placeholderColor
	 * @since 0.1.0
	 */
	open var placeholderColor: Int by Delegates.OnSet(Color.parse("gray")) { value ->
		this.setPlaceholderTextColor(value)
	}

	/**
	 * The text input's value format.
	 * @property format
	 * @since 0.5.0
	 */
	open var format: String by Delegates.OnSet("") {
		this.invalidate()
	}

	/**
	 * The text input's value format locale.
	 * @property locale
	 * @since 0.5.0
	 */
	open var locale: String by Delegates.OnSet("") {
		this.invalidate()
	}

	/**
	 * The text input's font family.
	 * @property fontFamily
	 * @since 0.1.0
	 */
	open var fontFamily: String by Delegates.OnSet("") {
		this.invalidateFont()
	}

	/**
	 * The text input's font weight.
	 * @property fontWeight
	 * @since 0.1.0
	 */
	open var fontWeight: String by Delegates.OnSet("normal") {
		this.invalidateFont()
	}

	/**
	 * The text input's font style.
	 * @property fontStyle
	 * @since 0.1.0
	 */
	open var fontStyle: String by Delegates.OnSet("normal") {
		this.invalidateFont()
	}

	/**
	 * The text input's font size.
	 * @property fontSize
	 * @since 0.1.0
	 */
	open var fontSize: Float by Delegates.OnSet(0.0f) { value ->
		this.textSize = Convert.toDp(value)
	}

	/**
	 * The text input's text horizontal alignment.
	 * @property textAlignment
	 * @since 0.1.0
	 */
	open var textAlignment: TextAlignment by Delegates.OnSet(TextAlignment.START) {
		this.updateGravity()
	}

	/**
	 * The text input's text vertical alignment.
	 * @property textPlacement
	 * @since 0.1.0
	 */
	open var textPlacement: TextPlacement by Delegates.OnSet(TextPlacement.MIDDLE) {
		this.updateGravity()
	}

	/**
	 * The text input's text kerning.
	 * @property textKerning
	 * @since 0.1.0
	 */
	open var textKerning: Float by Delegates.OnSet(0.0f) {
		this.invalidate()
	}

	/**
	 * The text input's text leading.
	 * @property textLeading
	 * @since 0.1.0
	 */
	open var textLeading: Float by Delegates.OnSet(0.0f) { value ->
		this.setLineSpacing(value, 0f)
	}

	/**
	 * The text input's text decoration.
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
	 * The text input's text transform.
	 * @property textTransform
	 * @since 0.1.0
	 */
	open var textTransform: TextTransform by Delegates.OnSet(TextTransform.NONE) {
		this.invalidate()
	}

	/**
	 * The text input's text shadow blur distance.
	 * @property textShadowBlur
	 * @since 0.1.0
	 */
	open var textShadowBlur: Float by Delegates.OnSet(0.0f) {
		this.invalidate()
	}

	/**
	 * The text input's text shadow color.
	 * @property textShadowColor
	 * @since 0.1.0
	 */
	open var textShadowColor: Int by Delegates.OnSet(Color.BLACK) {
		this.invalidate()
	}

	/**
	 * The text input's text shadow vertical offset.
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	open var textShadowOffsetTop: Float by Delegates.OnSet(0.0f) {
		this.invalidate()
	}

	/**
	 * The text input's text shadow horizontal offset.
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	open var textShadowOffsetLeft: Float by Delegates.OnSet(0.0f) {
		this.invalidate()
	}

	/**
	 * The text input's top padding.
	 * @property paddingTop
	 * @since 0.1.0
	 */
	open var paddingTop: Float  by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The text input's left padding.
	 * @property paddingLeft
	 * @since 0.1.0
	 */
	open var paddingLeft: Float  by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The text input's right padding.
	 * @property paddingRight
	 * @since 0.1.0
	 */
	open var paddingRight: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The text input's bottom padding.
	 * @property paddingBottom
	 * @since 0.1.0
	 */
	open var paddingBottom: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The text input's autocorrect status.
	 * @property autocorrect
	 * @since 0.1.0
	 */
	open var autocorrect: Boolean by Delegates.OnSet(true) {
		this.updateType()
	}

	/**
	 * The text input's autocapitalize status.
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
	open var contentViewListener: ContentTextInputListener? = null

	/**
	 * @property date
	 * @since 0.5.0
	 * @hidden
	 */
	private var date: Date = Date()

	/**
	 * @property datePicker
	 * @since 0.5.0
	 * @hidden
	 */
	private var datePicker: DatePickerDialog? = null

	/**
	 * @property timePicker
	 * @since 0.5.0
	 * @hidden
	 */
	private var timePicker: TimePickerDialog? = null

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
			if (application is ApplicationActivity) {
				application.presentSoftKeyboard(v)
			}

			this.contentViewListener?.onFocus(this)

		} else {

			val application = this.context
			if (application is ApplicationActivity) {
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

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init {

		this.contentViewListener = listener

		this.imeOptions = EditorInfo.IME_FLAG_NO_EXTRACT_UI

		this.background = null
		this.isFocusable = true
		this.isFocusableInTouchMode = true
		this.onFocusChangeListener = this.focusChangeListener

		this.textSize = 17f
		this.maxLines = 1

		this.setHorizontallyScrolling(true)
		this.setTextColor(Color.BLACK)
		this.setPlaceholderText("")
		this.setPlaceholderTextColor(Color.parse("gray"))
		this.setPadding(0, 0, 0, 0)

		this.setOnClickListener(this)

		this.initialized = true
	}

	/**
	 * @method focus
	 * @since 0.1.0
	 * @hidden
	 */
	open fun focus() {

		val focused = this.hasFocus()
		if (focused) {
			return
		}

		if (this.type == InputType.DATE) {
			this.presentDatePicker()
			return
		}

		if (this.type == InputType.TIME) {
			this.presentTimePicker()
			return
		}

		this.requestFocus()
	}

	/**
	 * @method blur
	 * @since 0.1.0
	 * @hidden
	 */
	open fun blur() {

		val focused = this.hasFocus()
		if (focused == false) {
			return
		}

		if (this.type == InputType.DATE) {
			this.datePicker?.hide()
			return
		}

		if (this.type == InputType.TIME) {
			this.timePicker?.hide()
			return
		}

		this.clearFocus()
	}

	/**
	 * @method onKeyPreIme
	 * @since 0.1.0
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
	override fun onTextChanged(text: CharSequence, start: Int, lengthBefore: Int, lengthAfter: Int) {

		if (this.initialized == false) {

			/*
			 * This method might be called from the parent constructor before
			 * the class will be fully initialized
			 */

			return
		}

		if (this.type == InputType.DATE ||
			this.type == InputType.TIME) {
			return
		}

		this.updateValue(text.toString())
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
	// Click Listener
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onClick
	 * @since 0.5.0
	 */
	override fun onClick(view: View) {

		if (this.type == InputType.DATE) {
			this.presentDatePicker()
			return
		}

		if (this.type == InputType.TIME) {
			this.presentTimePicker()
			return
		}
	}

	//--------------------------------------------------------------------------
	// Date Picker Listener
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onDateSet
	 * @since 0.5.0
	 */
	override fun onDateSet(view: DatePicker, year: Int, month: Int, day: Int) {

		val calendar = Calendar.getInstance()
		calendar.set(Calendar.YEAR, year)
		calendar.set(Calendar.MONTH, month)
		calendar.set(Calendar.DAY_OF_MONTH, day)

		this.date = calendar.time
		this.updateValue(this.date.iso)
		this.contentViewListener?.onBlur(this)
	}

	//--------------------------------------------------------------------------
	// Time Picker Listener
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onTimeSet
	 * @since 0.5.0
	 */
	override fun onTimeSet(view: TimePicker, hour: Int, minute: Int) {

		val calendar = Calendar.getInstance()
		calendar.set(Calendar.HOUR_OF_DAY, hour)
		calendar.set(Calendar.MINUTE, minute)

		this.date = calendar.time
		this.updateValue(this.date.iso)
		this.contentViewListener?.onBlur(this)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method presentDatePicker
	 * @since 0.5.0
	 * @hidden
	 */
	private fun presentDatePicker() {

		var picker = this.datePicker
		if (picker != null) {
			return
		}

		val calendar = Calendar.getInstance()

		calendar.time = this.date

		picker = DatePickerDialog(
			this.context,
			this,
			calendar.get(Calendar.YEAR),
			calendar.get(Calendar.MONTH),
			calendar.get(Calendar.DAY_OF_MONTH)
		)

		picker.setOnCancelListener {
			this.contentViewListener?.onBlur(this)
		}

		picker.setOnDismissListener {
			this.datePicker = null
		}

		picker.show()

		this.datePicker = picker

		this.contentViewListener?.onFocus(this)
	}

	/**
	 * @method presentDatePicker
	 * @since 0.5.0
	 * @hidden
	 */
	private fun presentTimePicker() {

		var picker = this.timePicker
		if (picker != null) {
			return
		}

		val calendar = Calendar.getInstance()

		calendar.time = this.date

		picker = TimePickerDialog(
			this.context,
			this,
			calendar.get(Calendar.HOUR_OF_DAY),
			calendar.get(Calendar.MINUTE),
			true
		)

		picker.setOnCancelListener {
			this.contentViewListener?.onBlur(this)
		}

		picker.setOnDismissListener {
			this.datePicker = null
		}

		picker.show()

		this.timePicker = picker

		this.contentViewListener?.onFocus(this)
	}

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
	 * @since 0.5.0
	 * @hidden
	 */
	private fun getString(): String {
		return this.text.toString()
	}

	/**
	 * @method setString
	 * @since 0.5.0
	 * @hidden
	 */
	private fun setString(value: String) {
		if (this.getString() != value) {
			this.setTextKeepState(value)
		}
	}

	/**
	 * @method updateValue
	 * @since 0.5.0
	 * @hidden
	 */
	private fun updateValue(value: String) {

		if (this.initialized == false) {

			/*
			 * This method might be called from the parent constructor before
			 * the class will be fully initialized
			 */

			return
		}

		var normalized = value

		if (this.type == InputType.NUMBER) {

			/*
			 * In some locale such as french, the decimal separator is a comma
			 * which does not play nice with parsing
			 */

			normalized = normalized.replace(",", ".")
		}

		if (this.value == normalized) {
			return
		}

		this.value = normalized

		this.contentViewListener?.onChange(this, normalized)
	}

	/**
	 * @method updateType
	 * @since 0.1.0
	 * @hidden
	 */
	private fun updateType() {

		var type = AndroidInputType.TYPE_NULL

		this.isFocusable = true
		this.isFocusableInTouchMode = true
		this.transformationMethod = null

		when (this.type) {
			InputType.DATE     -> type = AndroidInputType.TYPE_NULL
			InputType.TIME     -> type = AndroidInputType.TYPE_NULL
			InputType.TEXT     -> type = AndroidInputType.TYPE_CLASS_TEXT
			InputType.EMAIL    -> type = AndroidInputType.TYPE_CLASS_TEXT or AndroidInputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS
			InputType.PHONE    -> type = AndroidInputType.TYPE_CLASS_PHONE
			InputType.NUMBER   -> type = AndroidInputType.TYPE_CLASS_NUMBER or AndroidInputType.TYPE_NUMBER_FLAG_DECIMAL
			InputType.PASSWORD -> type = AndroidInputType.TYPE_CLASS_TEXT or AndroidInputType.TYPE_TEXT_VARIATION_PASSWORD
		}

		if (this.type == InputType.DATE ||
			this.type == InputType.TIME) {

			this.isFocusable = false
			this.isFocusableInTouchMode = false

		} else if (this.type == InputType.PASSWORD) {

			this.transformationMethod = PasswordTransformationMethod.getInstance()
			this.typeface = null

		} else {

			if (this.autocorrect == false) {
				type = type or AndroidInputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS
			}

			if (this.autocapitalize == true) {
				type = type or AndroidInputType.TYPE_TEXT_FLAG_CAP_SENTENCES
			}
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
			TextAlignment.CENTER  -> Gravity.CENTER_HORIZONTAL
			TextAlignment.RIGHT   -> Gravity.RIGHT
		}

		val v = when (this.textPlacement) {
			TextPlacement.TOP    -> Gravity.TOP
			TextPlacement.MIDDLE -> Gravity.CENTER_VERTICAL
			TextPlacement.BOTTOM -> Gravity.BOTTOM
		}

		this.gravity = v or h
	}
}
