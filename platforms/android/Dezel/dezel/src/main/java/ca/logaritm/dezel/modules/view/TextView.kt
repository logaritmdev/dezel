package ca.logaritm.dezel.modules.view

import android.util.Log
import android.util.SizeF
import ca.logaritm.dezel.core.*
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.ceiled
import ca.logaritm.dezel.extension.clamp
import ca.logaritm.dezel.extension.max
import ca.logaritm.dezel.layout.LayoutNode
import ca.logaritm.dezel.view.ContentTextView
import ca.logaritm.dezel.view.ContentTextViewListener
import ca.logaritm.dezel.view.graphic.Color
import ca.logaritm.dezel.view.graphic.Convert
import ca.logaritm.dezel.view.type.*

/**
 * @class TextView
 * @since 0.1.0
 * @hidden
 */
open class TextView(context: JavaScriptContext) : View(context), ContentTextViewListener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text view's font family.
	 * @property fontFamily
	 * @since 0.1.0
	 */
	open var fontFamily: Property by Delegates.OnSet(Property("default")) { value ->

		this.view.fontFamily = value.string

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's font weight.
	 * @property fontWeight
	 * @since 0.1.0
	 */
	open var fontWeight: Property by Delegates.OnSet(Property("normal")) { value ->

		this.view.fontWeight = value.string

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's font stylerNode.
	 * @property fontStyle
	 * @since 0.1.0
	 */
	open var fontStyle: Property by Delegates.OnSet(Property("normal")) { value ->

		this.view.fontStyle = value.string

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's font viewport.
	 * @property fontSize
	 * @since 0.1.0
	 */
	open var fontSize: Property by Delegates.OnSet(Property(17.0)) {
		this.invalidateFontSize()
	}

	/**
	 * The text view's minimum font viewport.
	 * @property minFontSize
	 * @since 0.1.0
	 */
	open var minFontSize: Property by Delegates.OnSet(Property(0.0)) {
		this.invalidateFontSize()
	}

	/**
	 * The text view's maximum font viewport.
	 * @property maxFontSize
	 * @since 0.1.0
	 */
	open var maxFontSize: Property by Delegates.OnSet(Property(Double.max)) {
		this.invalidateFontSize()
	}

	/**
	 * The text view's text.
	 * @property text
	 * @since 0.1.0
	 */
	open var text: Property by Delegates.OnSet(Property("")) { value ->

		this.view.text = value.string

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text color.
	 * @property textColor
	 * @since 0.1.0
	 */
	open var textColor: Property by Delegates.OnSet(Property("#000")) { value ->
		this.view.textColor = Color.parse(value.string)
	}

	/**
	 * The text view's text alignment.
	 * @property textAlignment
	 * @since 0.1.0
	 */
	open var textAlignment: Property by Delegates.OnSet(Property("start")) { value ->
		this.view.textAlignment = this.getTextAlignment(value.string)
	}

	/**
	 * The text view's text placement.
	 * @property textPlacement
	 * @since 0.1.0
	 */
	open var textPlacement: Property by Delegates.OnSet(Property("middle")) { value ->
		this.view.textPlacement = this.getTextPlacement(value.string)
	}

	/**
	 * The text view's text baseline.
	 * @property textBaseline
	 * @since 0.1.0
	 */
	open var textBaseline: Property by Delegates.OnSet(Property(0.0)) { value ->

		this.view.textBaseline = Convert.toPx(value.number)

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text kerning.
	 * @property textKerning
	 * @since 0.1.0
	 */
	open var textKerning: Property by Delegates.OnSet(Property(0.0)) { value ->

		this.view.textKerning = Convert.toPx(value.number)

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text leading.
	 * @property textLeading
	 * @since 0.1.0
	 */
	open var textLeading: Property by Delegates.OnSet(Property(0.0)) { value ->

		this.view.textLeading = Convert.toPx(value.number)

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text shadow blur.
	 * @property textShadowBlur
	 * @since 0.1.0
	 */
	open var textShadowBlur: Property by Delegates.OnSet(Property(0.0)) { value ->
		this.view.textShadowBlur = Convert.toPx(value.number)
	}

	/**
	 * The text view's text shadow color.
	 * @property textShadowColor
	 * @since 0.1.0
	 */
	open var textShadowColor: Property by Delegates.OnSet(Property("#000")) { value ->
		this.view.textShadowColor = Color.parse(value.string)
	}

	/**
	 * The text view's text shadow offset top.
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	open var textShadowOffsetTop: Property by Delegates.OnSet(Property(0.0)) { value ->
		this.view.textShadowOffsetTop = Convert.toPx(value.number)
	}

	/**
	 * The text view's text shadow offset left.
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	open var textShadowOffsetLeft: Property by Delegates.OnSet(Property(0.0)) { value ->
		this.view.textShadowOffsetLeft = Convert.toPx(value.number)
	}

	/**
	 * The text view's text decoration.
	 * @property textDecoration
	 * @since 0.1.0
	 */
	open var textDecoration: Property by Delegates.OnSet(Property("none")) { value ->

		this.view.textDecoration = this.getTextDecoration(value.string)

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text transform.
	 * @property textTransform
	 * @since 0.1.0
	 */
	open var textTransform: Property by Delegates.OnSet(Property("none")) { value ->

		this.view.textTransform = this.getTextTransform(value.string)

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text overflow.
	 * @property textOverflow
	 * @since 0.1.0
	 */
	open var textOverflow: Property by Delegates.OnSet(Property("ellipsis")) { value ->

		this.view.textOverflow = this.getTextOverflow(value.string)

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's link color.
	 * @property linkColor
	 * @since 0.5.0
	 */
	open var linkColor: Property by Delegates.OnSet(Property("blue")) { value ->
		this.view.linkColor = Color.parse(value.string)
	}

	/**
	 * The text view's text lines.
	 * @property lines
	 * @since 0.1.0
	 */
	open var lines: Property by Delegates.OnSet(Property(0.0)) { value ->

		this.view.lineLimit = value.number.toInt()

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	/**
	 * @property view
	 * @since 0.1.0
	 * @hidden
	 */
	private val view: ContentTextView
		get() = this.content as ContentTextView

	/**
	 * @property invalidFontSize
	 * @since 0.1.0
	 * @hidden
	 */
	private var invalidFontSize: Boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Creates the text view.
	 * @method createContentView
	 * @since 0.1.0
	 */
	override fun createContentView(): ContentTextView {
		return ContentTextView(this.context.application, this)
	}

	/**
	 * @inherited
	 * @method measure
	 * @since 0.5.0
	 */
	override fun measure(bounds: SizeF, min: SizeF, max: SizeF): SizeF {

		if (this.invalidFontSize) {
			this.invalidFontSize = false
			this.updateFontSize()
		}

		val size = this.view.measure(
			Convert.toPx(bounds),
			Convert.toPx(min),
			Convert.toPx(max)
		)

		return Convert.toDp(size).ceiled()
	}

	/**
	 * @inherited
	 * @method update
	 * @since 0.1.0
	 */
	override fun update() {

		super.update()

		if (this.invalidFontSize) {
			this.invalidFontSize = false
			this.updateFontSize()
		}
	}

	/**
	 * Resolves the font viewport based on its unit.
	 * @method updateFontSize
	 * @since 0.1.0
	 */
	open fun updateFontSize() {

		val value: Float

		when (this.fontSize.unit) {
			PropertyUnit.PX -> value = Convert.toPx(this.fontSize.number)
			PropertyUnit.VW -> value = Convert.toPx(this.fontSize.number / 100 * this.layoutNode.viewportWidth)
			PropertyUnit.VH -> value = Convert.toPx(this.fontSize.number / 100 * this.layoutNode.viewportHeight)
			else            -> value = Convert.toPx(this.fontSize.number)
		}

		this.view.fontSize = value.clamp(
			Convert.toPx(this.minFontSize.number),
			Convert.toPx(this.maxFontSize.number)
		)

		if (this.layoutNode.wrapsContentWidth ||
			this.layoutNode.wrapsContentHeight) {
			this.layoutNode.invalidateSize()
		}
	}

	//--------------------------------------------------------------------------
	// Methods - Content Text View Listener
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @since 0.5.0
	 * @hidden
	 */
	override fun onPressLink(textView: ContentTextView, url: String) {
		this.holder.callMethod("nativePressLink", arrayOf(this.context.createString(url)))
	}

	//--------------------------------------------------------------------------
	// Layout Node Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onResolvePadding
	 * @since 0.1.0
	 */
	override fun onResolvePadding(node: LayoutNode) {
		super.onResolvePadding(node)
		this.view.paddingTop = Convert.toPx(this.resolvedPaddingTop.toFloat())
		this.view.paddingLeft = Convert.toPx(this.resolvedPaddingLeft.toFloat())
		this.view.paddingRight = Convert.toPx(this.resolvedPaddingRight.toFloat())
		this.view.paddingBottom = Convert.toPx(this.resolvedPaddingBottom.toFloat())
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateFontSize
	 * @since 0.1.0
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
	 * @since 0.1.0
	 * @hidden
	 */
	internal fun getTextDecoration(value: String): TextDecoration {

		when (value) {
			"none"      -> return TextDecoration.NONE
			"underline" -> return TextDecoration.UNDERLINE
		}

		Log.d("DEZEL", "Unrecognized handle for textDecoration: $value")

		return TextDecoration.NONE
	}

	/**
	 * @method getTextTransform
	 * @since 0.1.0
	 * @hidden
	 */
	internal fun getTextTransform(value: String): TextTransform {

		when (value) {
			"none"       -> return TextTransform.NONE
			"uppercase"  -> return TextTransform.UPPERCASE
			"lowercase"  -> return TextTransform.LOWERCASE
			"capitalize" -> return TextTransform.CAPITALIZE
		}

		Log.d("DEZEL", "Unrecognized handle for textTransform: $value")

		return TextTransform.NONE
	}

	/**
	 * @method getTextAlignment
	 * @since 0.1.0
	 * @hidden
	 */
	internal fun getTextAlignment(value: String): TextAlignment {

		when (value) {
			"start"  -> return TextAlignment.START
			"end"    -> return TextAlignment.END
			"left"   -> return TextAlignment.LEFT
			"right"  -> return TextAlignment.RIGHT
			"center" -> return TextAlignment.CENTER
		}

		Log.d("DEZEL", "Unrecognized handle for textAlignment: $value")

		return TextAlignment.START
	}

	/**
	 * @method getTextPlacement
	 * @since 0.1.0
	 * @hidden
	 */
	internal fun getTextPlacement(value: String): TextPlacement {

		when (value) {
			"top"    -> return TextPlacement.TOP
			"middle" -> return TextPlacement.MIDDLE
			"bottom" -> return TextPlacement.BOTTOM
		}

		Log.d("DEZEL", "Unrecognized handle for textPlacement: $value")

		return TextPlacement.MIDDLE
	}

	/**
	 * @method getTextOverflow
	 * @since 0.1.0
	 * @hidden
	 */
	internal fun getTextOverflow(value: String): TextOverflow {

		when (value) {
			"clip"     -> return TextOverflow.CLIP
			"ellipsis" -> return TextOverflow.ELLIPSIS
		}

		Log.d("DEZEL", "Unrecognized handle for textOverflow: $value")

		return TextOverflow.ELLIPSIS
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontFamily
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_fontFamily(callback: JavaScriptGetterCallback) {
		callback.returns(this.fontFamily)
	}

	/**
	 * @method jsSet_fontFamily
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_fontFamily(callback: JavaScriptSetterCallback) {
		this.fontFamily = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontWeight
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_fontWeight(callback: JavaScriptGetterCallback) {
		callback.returns(this.fontWeight)
	}

	/**
	 * @method jsSet_fontWeight
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_fontWeight(callback: JavaScriptSetterCallback) {
		this.fontWeight = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontStyle
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_fontStyle(callback: JavaScriptGetterCallback) {
		callback.returns(this.fontStyle)
	}

	/**
	 * @method jsSet_fontStyle
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_fontStyle(callback: JavaScriptSetterCallback) {
		this.fontStyle = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_fontSize(callback: JavaScriptGetterCallback) {
		callback.returns(this.fontSize)
	}

	/**
	 * @method jsSet_fontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_fontSize(callback: JavaScriptSetterCallback) {
		this.fontSize = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minFontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minFontSize(callback: JavaScriptGetterCallback) {
		callback.returns(this.minFontSize)
	}

	/**
	 * @method jsSet_minFontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minFontSize(callback: JavaScriptSetterCallback) {
		this.minFontSize = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxFontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxFontSize(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxFontSize)
	}

	/**
	 * @method jsSet_maxFontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxFontSize(callback: JavaScriptSetterCallback) {
		this.maxFontSize = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_text
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_text(callback: JavaScriptGetterCallback) {
		callback.returns(this.text)
	}

	/**
	 * @method jsSet_text
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_text(callback: JavaScriptSetterCallback) {
		this.text = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textColor
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.textColor)
	}

	/**
	 * @method jsSet_textColor
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textColor(callback: JavaScriptSetterCallback) {
		this.textColor = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textAlignment
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textAlignment(callback: JavaScriptGetterCallback) {
		callback.returns(this.textAlignment)
	}

	/**
	 * @method jsSet_textAlignment
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textAlignment(callback: JavaScriptSetterCallback) {
		this.textAlignment = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textPlacement
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textPlacement(callback: JavaScriptGetterCallback) {
		callback.returns(this.textPlacement)
	}

	/**
	 * @method jsSet_textPlacement
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textPlacement(callback: JavaScriptSetterCallback) {
		this.textPlacement = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textBaseline
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textBaseline(callback: JavaScriptGetterCallback) {
		callback.returns(this.textBaseline)
	}

	/**
	 * @method jsSet_textBaseline
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textBaseline(callback: JavaScriptSetterCallback) {
		this.textBaseline = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textKerning
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textKerning(callback: JavaScriptGetterCallback) {
		callback.returns(this.textKerning)
	}

	/**
	 * @method jsSet_textKerning
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textKerning(callback: JavaScriptSetterCallback) {
		this.textKerning = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textLeading
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textLeading(callback: JavaScriptGetterCallback) {
		callback.returns(this.textLeading)
	}

	/**
	 * @method jsSet_textLeading
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textLeading(callback: JavaScriptSetterCallback) {
		this.textLeading = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textDecoration
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textDecoration(callback: JavaScriptGetterCallback) {
		callback.returns(this.textDecoration)
	}

	/**
	 * @method jsSet_textDecoration
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textDecoration(callback: JavaScriptSetterCallback) {
		this.textDecoration = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textTransform
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textTransform(callback: JavaScriptGetterCallback) {
		callback.returns(this.textTransform)
	}

	/**
	 * @method jsSet_textTransform
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textTransform(callback: JavaScriptSetterCallback) {
		this.textTransform = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowBlur
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textShadowBlur(callback: JavaScriptGetterCallback) {
		callback.returns(this.textShadowBlur)
	}

	/**
	 * @method jsSet_textShadowBlur
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textShadowBlur(callback: JavaScriptSetterCallback) {
		this.textShadowBlur = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowColor
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textShadowColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.textShadowColor)
	}

	/**
	 * @method jsSet_textShadowColor
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textShadowColor(callback: JavaScriptSetterCallback) {
		this.textShadowColor = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowOffsetTop
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textShadowOffsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.textShadowOffsetTop)
	}

	/**
	 * @method jsSet_textShadowOffsetTop
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textShadowOffsetTop(callback: JavaScriptSetterCallback) {
		this.textShadowOffsetTop = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowOffsetLeft
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textShadowOffsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.textShadowOffsetLeft)
	}

	/**
	 * @method jsSet_textShadowOffsetLeft
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textShadowOffsetLeft(callback: JavaScriptSetterCallback) {
		this.textShadowOffsetLeft = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textOverflow
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_textOverflow(callback: JavaScriptGetterCallback) {
		callback.returns(this.textOverflow)
	}

	/**
	 * @method jsSet_textOverflow
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_textOverflow(callback: JavaScriptSetterCallback) {
		this.textOverflow = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_linkColor
	 * @since 0.5.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_linkColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.linkColor)
	}

	/**
	 * @method jsSet_linkColor
	 * @since 0.5.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_linkColor(callback: JavaScriptSetterCallback) {
		this.linkColor = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_lines
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_lines(callback: JavaScriptGetterCallback) {
		callback.returns(this.lines)
	}

	/**
	 * @method jsSet_lines
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_lines(callback: JavaScriptSetterCallback) {
		this.lines = Property(callback.value)
	}
}

