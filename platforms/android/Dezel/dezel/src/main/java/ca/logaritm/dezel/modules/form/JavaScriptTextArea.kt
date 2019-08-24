package ca.logaritm.dezel.modules.form

import android.util.Log
import android.util.SizeF
import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.*
import ca.logaritm.dezel.extension.clamp
import ca.logaritm.dezel.extension.max
import ca.logaritm.dezel.layout.LayoutNode
import ca.logaritm.dezel.modules.view.JavaScriptView
import ca.logaritm.dezel.view.TextArea
import ca.logaritm.dezel.view.TextAreaListener
import ca.logaritm.dezel.view.graphic.Color
import ca.logaritm.dezel.view.graphic.Convert
import ca.logaritm.dezel.view.type.TextAlignment
import ca.logaritm.dezel.view.type.TextDecoration
import ca.logaritm.dezel.view.type.TextLocation
import ca.logaritm.dezel.view.type.TextTransform

/**
 * An editable text area.
 * @class JavaScriptTextArea
 * @since 0.7.0
 */
open class JavaScriptTextArea(context: JavaScriptContext) : JavaScriptView(context), TextAreaListener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text area's value.
	 * @property value
	 * @since 0.7.0
	 */
	open val value: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "") { value ->
			this.view.value = value.string
		}
	}

	/**
	 * The text area's placeholder.
	 * @property placeholder
	 * @since 0.7.0
	 */
	open val placeholder: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "") { value ->
			this.view.placeholder = value.string
		}
	}

	/**
	 * The text area's placeholder color.
	 * @property placeholderColor
	 * @since 0.7.0
	 */
	open val placeholderColor: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "gray") { value ->
			this.view.placeholderColor = Color.parse(value.string)
		}
	}

	/**
	 * The text area's autocorrect status.
	 * @property autocorrect
	 * @since 0.7.0
	 */
	open val autocorrect: JavaScriptProperty by lazy {
		JavaScriptProperty(context, true) { value ->
			this.view.autocorrect = value.boolean
		}
	}

	/**
	 * The text area's autocapitalize status.
	 * @property autocapitalize
	 * @since 0.7.0
	 */
	open val autocapitalize: JavaScriptProperty by lazy {
		JavaScriptProperty(context, true) { value ->
			this.view.autocapitalize = value.boolean
		}
	}

	/**
	 * The text area's font family.
	 * @property fontFamily
	 * @since 0.7.0
	 */
	open val fontFamily: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "default") { value ->
			this.view.fontFamily = value.string
		}
	}

	/**
	 * The text area's font weight.
	 * @property fontWeight
	 * @since 0.7.0
	 */
	open val fontWeight: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "normal") { value ->
			this.view.fontWeight = value.string
		}
	}

	/**
	 * The text area's font stylerNode.
	 * @property fontStyle
	 * @since 0.7.0
	 */
	open val fontStyle: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "normal") { value ->
			this.view.fontStyle = value.string
		}
	}

	/**
	 * The text area's font size.
	 * @property fontSize
	 * @since 0.7.0
	 */
	open val fontSize: JavaScriptProperty by lazy {
		JavaScriptProperty(context, 17.0) {
			this.invalidateFontSize()
		}
	}

	/**
	 * The text area's minimum font size.
	 * @property minFontSize
	 * @since 0.7.0
	 */
	open val minFontSize: JavaScriptProperty by lazy {
		JavaScriptProperty(context, 0.0) {
			this.invalidateFontSize()
		}
	}

	/**
	 * The text area's maximum font size.
	 * @property maxFontSize
	 * @since 0.7.0
	 */
	open val maxFontSize: JavaScriptProperty by lazy {
		JavaScriptProperty(context, Double.max) {
			this.invalidateFontSize()
		}
	}

	/**
	 * The text area's text color.
	 * @property textColor
	 * @since 0.7.0
	 */
	open val textColor: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "#000") { value ->
			this.view.setTextColor(Color.parse(value.string))
		}
	}

	/**
	 * The text area's text alignment.
	 * @property textAlignment
	 * @since 0.7.0
	 */
	open val textAlignment: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "start") { value ->
			this.view.textAlignment = this.getTextAlignment(value.string)
		}
	}

	/**
	 * The text area's text location.
	 * @property textLocation
	 * @since 0.7.0
	 */
	open val textLocation: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "middle") { value ->
			this.view.textLocation = this.getTextLocation(value.string)
		}
	}

	/**
	 * The text area's text kerning.
	 * @property textKerning
	 * @since 0.7.0
	 */
	open val textKerning: JavaScriptProperty by lazy {
		JavaScriptProperty(context, 0.0) { value ->
			this.view.textKerning = value.number.toFloat()
		}
	}

	/**
	 * The text area's text leading.
	 * @property textLeading
	 * @since 0.7.0
	 */
	open val textLeading: JavaScriptProperty by lazy {
		JavaScriptProperty(context, 0.0) { value ->
			this.view.textLeading = value.number.toFloat()
		}
	}

	/**
	 * The text area's text shadow blur.
	 * @property textShadowBlur
	 * @since 0.7.0
	 */
	open val textShadowBlur: JavaScriptProperty by lazy {
		JavaScriptProperty(context, 0.0) { value ->
			this.view.textShadowBlur = value.number.toFloat()
		}
	}

	/**
	 * The text area's text shadow color.
	 * @property textShadowColor
	 * @since 0.7.0
	 */
	open val textShadowColor: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "#000") { value ->
			this.view.textShadowColor = Color.parse(value.string)
		}
	}

	/**
	 * The text area's text shadow offset top.
	 * @property textShadowOffsetTop
	 * @since 0.7.0
	 */
	open val textShadowOffsetTop: JavaScriptProperty by lazy {
		JavaScriptProperty(context, 0.0) { value ->
			this.view.textShadowOffsetTop = value.number.toFloat()
		}
	}

	/**
	 * The text area's text shadow offset left.
	 * @property textShadowOffsetLeft
	 * @since 0.7.0
	 */
	open val textShadowOffsetLeft: JavaScriptProperty by lazy {
		JavaScriptProperty(context, 0.0) { value ->
			this.view.textShadowOffsetLeft = value.number.toFloat()
		}
	}

	/**
	 * The text area's text decoration.
	 * @property textDecoration
	 * @since 0.7.0
	 */
	open val textDecoration: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "none") { value ->
			this.view.textDecoration = this.getTextDecoration(value.string)
		}
	}

	/**
	 * The text area's text transform.
	 * @property textTransform
	 * @since 0.7.0
	 */
	open val textTransform: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "none") { value ->
			this.view.textTransform = this.getTextTransform(value.string)
		}
	}

	/**
	 * @property view
	 * @since 0.7.0
	 * @hidden
	 */
	private val view: TextArea
		get() = this.content as TextArea

	/**
	 * @property invalidFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidFontSize: Boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method createContentView
	 * @since 0.7.0
	 */
	override fun createContentView(): TextArea {
		return TextArea(this.context.application, this)
	}

	/**
	 * @inherited
	 * @method update
	 * @since 0.7.0
	 */
	override fun update() {

		super.update()

		if (this.invalidFontSize) {
			this.invalidFontSize = false
			this.updateFontSize()
		}
	}

	/**
	 * Updates the font size based on its utin.
	 * @method updateFontSize
	 * @since 0.7.0
	 */
	open fun updateFontSize() {

		val value: Float

		when (this.fontSize.unit) {
			JavaScriptPropertyUnit.PX -> value = Convert.toPx(this.fontSize.number)
			JavaScriptPropertyUnit.VW -> value = Convert.toPx(this.fontSize.number / 100 * this.layoutNode.viewportWidth)
			JavaScriptPropertyUnit.VH -> value = Convert.toPx(this.fontSize.number / 100 * this.layoutNode.viewportHeight)
			else                      -> value = Convert.toPx(this.fontSize.number)
		}

		this.view.fontSize = value.clamp(
			Convert.toPx(this.minFontSize.number),
			Convert.toPx(this.maxFontSize.number)
		)
	}

	//--------------------------------------------------------------------------
	// Methods - Content Text Input Observer
	//--------------------------------------------------------------------------

	/**
	 * @method onChange
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onChange(textArea: TextArea, value: String) {
		this.value.set(value)
		this.callMethod("nativeOnChange", arrayOf(this.context.createString(value)), null)
	}

	/**
	 * @method onFocus
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onFocus(textArea: TextArea) {
		this.callMethod("nativeOnFocus")
	}

	/**
	 * @method onBlur
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onBlur(textArea: TextArea) {
		this.callMethod("nativeOnBlur")
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	private fun invalidateFontSize() {
		if (this.invalidFontSize == false) {
			this.invalidFontSize = true
			this.scheduleUpdate()
		}
	}

	//--------------------------------------------------------------------------
	// Private API - Conversions
	//--------------------------------------------------------------------------

	/**
	 * @method getTextDecoration
	 * @since 0.7.0
	 * @hidden
	 */
	open fun getTextDecoration(value: String): TextDecoration {

		when (value) {
			"none"      -> return TextDecoration.NONE
			"underline" -> return TextDecoration.UNDERLINE
			else        -> Log.d("DEZEL", "Unrecognized handle for textDecoration: $value")
		}

		return TextDecoration.NONE
	}

	/**
	 * @method getTextTransform
	 * @since 0.7.0
	 * @hidden
	 */
	open fun getTextTransform(value: String): TextTransform {

		when (value) {
			"none"       -> return TextTransform.NONE
			"uppercase"  -> return TextTransform.UPPERCASE
			"lowercase"  -> return TextTransform.LOWERCASE
			"capitalize" -> return TextTransform.CAPITALIZE
			else         -> Log.d("DEZEL", "Unrecognized handle for textTransform: $value")
		}

		return TextTransform.NONE
	}

	/**
	 * @method getTextAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	open fun getTextAlignment(value: String): TextAlignment {

		when (value) {
			"start"  -> return TextAlignment.START
			"end"    -> return TextAlignment.END
			"left"   -> return TextAlignment.LEFT
			"right"  -> return TextAlignment.RIGHT
			"center" -> return TextAlignment.CENTER
			else     -> Log.d("DEZEL", "Unrecognized handle for textAlignment: $value")
		}

		return TextAlignment.START
	}

	/**
	 * @method getTextLocation
	 * @since 0.7.0
	 * @hidden
	 */
	open fun getTextLocation(value: String): TextLocation {

		when (value) {
			"top"    -> return TextLocation.TOP
			"middle" -> return TextLocation.MIDDLE
			"bottom" -> return TextLocation.BOTTOM
			else     -> Log.d("DEZEL", "Unrecognized handle for textLocation: $value")
		}

		return TextLocation.MIDDLE
	}

	//--------------------------------------------------------------------------
	// Layout Node Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method measure
	 * @since 0.7.0
	 */
	override fun measure(bounds: SizeF, min: SizeF, max: SizeF): SizeF {

		if (this.invalidFontSize) {
			this.invalidFontSize = false
			this.updateFontSize()
		}

		return SizeF(130f, 80f)
	}

	/**
	 * @inherited
	 * @method onResolvePadding
	 * @since 0.7.0
	 */
	override fun onResolvePadding(node: LayoutNode) {
		super.onResolvePadding(node)
		this.view.paddingTop = Convert.toPx(this.resolvedPaddingTop.toFloat())
		this.view.paddingLeft = Convert.toPx(this.resolvedPaddingLeft.toFloat())
		this.view.paddingRight = Convert.toPx(this.resolvedPaddingRight.toFloat())
		this.view.paddingBottom = Convert.toPx(this.resolvedPaddingBottom.toFloat())
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_value
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_value(callback: JavaScriptGetterCallback) {
		callback.returns(this.value)
	}

	/**
	 * @method jsSet_value
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_value(callback: JavaScriptSetterCallback) {
		this.value.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_placeholder
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_placeholder(callback: JavaScriptGetterCallback) {
		callback.returns(this.placeholder)
	}

	/**
	 * @method jsSet_placeholder
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_placeholder(callback: JavaScriptSetterCallback) {
		this.placeholder.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_placeholderColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_placeholderColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.placeholderColor)
	}

	/**
	 * @method jsSet_placeholderColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_placeholderColor(callback: JavaScriptSetterCallback) {
		this.placeholderColor.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_autocorrect
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_autocorrect(callback: JavaScriptGetterCallback) {
		callback.returns(this.autocorrect)
	}

	/**
	 * @method jsSet_autocorrect
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_autocorrect(callback: JavaScriptSetterCallback) {
		this.autocorrect.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_autocapitalize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_autocapitalize(callback: JavaScriptGetterCallback) {
		callback.returns(this.autocapitalize)
	}

	/**
	 * @method jsSet_autocapitalize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_autocapitalize(callback: JavaScriptSetterCallback) {
		this.autocapitalize.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontFamily
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_fontFamily(callback: JavaScriptGetterCallback) {
		callback.returns(this.fontFamily)
	}

	/**
	 * @method jsSet_fontFamily
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_fontFamily(callback: JavaScriptSetterCallback) {
		this.fontFamily.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontWeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_fontWeight(callback: JavaScriptGetterCallback) {
		callback.returns(this.fontWeight)
	}

	/**
	 * @method jsSet_fontWeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_fontWeight(callback: JavaScriptSetterCallback) {
		this.fontWeight.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_fontStyle(callback: JavaScriptGetterCallback) {
		callback.returns(this.fontStyle)
	}

	/**
	 * @method jsSet_fontStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_fontStyle(callback: JavaScriptSetterCallback) {
		this.fontStyle.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_fontSize(callback: JavaScriptGetterCallback) {
		callback.returns(this.fontSize)
	}

	/**
	 * @method jsSet_fontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_fontSize(callback: JavaScriptSetterCallback) {
		this.fontSize.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minFontSize(callback: JavaScriptGetterCallback) {
		callback.returns(this.minFontSize)
	}

	/**
	 * @method jsSet_minFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minFontSize(callback: JavaScriptSetterCallback) {
		this.minFontSize.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxFontSize(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxFontSize)
	}

	/**
	 * @method jsSet_maxFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxFontSize(callback: JavaScriptSetterCallback) {
		this.maxFontSize.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.textColor)
	}

	/**
	 * @method jsSet_textColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textColor(callback: JavaScriptSetterCallback) {
		this.textColor.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textAlignment(callback: JavaScriptGetterCallback) {
		callback.returns(this.textAlignment)
	}

	/**
	 * @method jsSet_textAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textAlignment(callback: JavaScriptSetterCallback) {
		this.textAlignment.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textLocation
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textLocation(callback: JavaScriptGetterCallback) {
		callback.returns(this.textLocation)
	}

	/**
	 * @method jsSet_textLocation
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textLocation(callback: JavaScriptSetterCallback) {
		this.textLocation.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textKerning
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textKerning(callback: JavaScriptGetterCallback) {
		callback.returns(this.textKerning)
	}

	/**
	 * @method jsSet_textKerning
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textKerning(callback: JavaScriptSetterCallback) {
		this.textKerning.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textLeading
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textLeading(callback: JavaScriptGetterCallback) {
		callback.returns(this.textLeading)
	}

	/**
	 * @method jsSet_textLeading
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textLeading(callback: JavaScriptSetterCallback) {
		this.textLeading.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textDecoration
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textDecoration(callback: JavaScriptGetterCallback) {
		callback.returns(this.textDecoration)
	}

	/**
	 * @method jsSet_textDecoration
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textDecoration(callback: JavaScriptSetterCallback) {
		this.textDecoration.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textTransform
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textTransform(callback: JavaScriptGetterCallback) {
		callback.returns(this.textTransform)
	}

	/**
	 * @method jsSet_textTransform
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textTransform(callback: JavaScriptSetterCallback) {
		this.textTransform.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textShadowBlur(callback: JavaScriptGetterCallback) {
		callback.returns(this.textShadowBlur)
	}

	/**
	 * @method jsSet_textShadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textShadowBlur(callback: JavaScriptSetterCallback) {
		this.textShadowBlur.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textShadowColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.textShadowColor)
	}

	/**
	 * @method jsSet_textShadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textShadowColor(callback: JavaScriptSetterCallback) {
		this.textShadowColor.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textShadowOffsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.textShadowOffsetTop)
	}

	/**
	 * @method jsSet_textShadowOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textShadowOffsetTop(callback: JavaScriptSetterCallback) {
		this.fontFamily.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textShadowOffsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.textShadowOffsetLeft)
	}

	/**
	 * @method jsSet_textShadowOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textShadowOffsetLeft(callback: JavaScriptSetterCallback) {
		this.textShadowOffsetLeft.set(callback.value, this)
	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_focus
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_focus(callback: JavaScriptFunctionCallback) {
		this.view.focus()
	}

	/**
	 * @method jsFunction_blur
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_blur(callback: JavaScriptFunctionCallback) {
		this.view.blur()
	}
}
