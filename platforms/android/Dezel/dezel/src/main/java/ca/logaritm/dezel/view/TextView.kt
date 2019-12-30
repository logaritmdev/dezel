package ca.logaritm.dezel.view

import android.animation.ValueAnimator
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.text.Spanned
import android.text.TextPaint
import android.util.SizeF
import android.view.MotionEvent
import android.view.View
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.text.SpannableString
import ca.logaritm.dezel.extension.type.isHTML
import ca.logaritm.dezel.extension.type.normalize
import ca.logaritm.dezel.extension.view.setMeasuredFrame
import ca.logaritm.dezel.view.text.TextLayout
import ca.logaritm.dezel.view.text.TextParser
import ca.logaritm.dezel.view.text.font.Font
import ca.logaritm.dezel.view.text.span.*
import ca.logaritm.dezel.util.geom.Rect
import ca.logaritm.dezel.util.geom.Size
import ca.logaritm.dezel.view.graphic.Convert
import ca.logaritm.dezel.view.animation.Animatable
import ca.logaritm.dezel.view.trait.Clippable
import ca.logaritm.dezel.view.trait.Resizable
import ca.logaritm.dezel.view.type.TextAlign
import ca.logaritm.dezel.view.type.TextDecoration
import ca.logaritm.dezel.view.type.TextOverflow
import ca.logaritm.dezel.view.type.TextTransform

/**
 * @class TextView
 * @super View
 * @since 0.7.0
 */
open class TextView(context: Context, observer: TextViewObserver) : View(context), Resizable, Clippable, Animatable {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property fontFamily
	 * @since 0.7.0
	 */
	open var fontFamily: String by Delegates.OnSet("") {
		this.font = null
		this.invalidateSpans()
		this.invalidateSpannedText()
	}

	/**
	 * @property fontWeight
	 * @since 0.7.0
	 */
	open var fontWeight: String by Delegates.OnSet("normal") {
		this.font = null
		this.invalidateSpans()
		this.invalidateSpannedText()
	}

	/**
	 * @property fontStyle
	 * @since 0.7.0
	 */
	open var fontStyle: String by Delegates.OnSet("normal") {
		this.font = null
		this.invalidateSpans()
		this.invalidateSpannedText()
	}

	/**
	 * @property fontSize
	 * @since 0.7.0
	 */
	open var fontSize: Float by Delegates.OnSet(17f) {
		this.font = null
		this.invalidateSpans()
		this.invalidateSpannedText()
	}

	/**
	 * @property text
	 * @since 0.7.0
	 */
	open var text: String by Delegates.OnSet("") {
		this.invalidateSpans()
		this.invalidateSpannedText()
		this.invalidate()
	}

	/**
	 * @property textColor
	 * @since 0.7.0
	 */
	open var textColor: Int by Delegates.OnSet(Color.BLACK) {
		this.invalidateSpans()
		this.invalidateSpannedText()
		this.invalidate()
	}

	/**
	 * @property textAlign
	 * @since 0.7.0
	 */
	open var textAlign: TextAlign by Delegates.OnSet(TextAlign.MIDDLE_LEFT) { value ->
		this.layout.textAlign = value
		this.invalidateSpans()
		this.invalidateSpannedText()
		this.invalidate()
	}

	/**
	 * @property textBaseline
	 * @since 0.7.0
	 */
	open var textBaseline: Float by Delegates.OnSet(0f) { value ->
		this.layout.textBaseline = value
		this.invalidate()
	}

	/**
	 * @property textKerning
	 * @since 0.7.0
	 */
	open var textKerning: Float by Delegates.OnSet(0f) { value ->
		this.layout.textKerning = value
		this.invalidateSpans()
		this.invalidateSpannedText()
		this.invalidate()
	}

	/**
	 * @property textLeading
	 * @since 0.7.0
	 */
	open var textLeading: Float by Delegates.OnSet(0f) { value ->
		this.layout.textLeading = value
		this.invalidateSpans()
		this.invalidateSpannedText()
		this.invalidate()
	}

	/**
	 * @property textOverflow
	 * @since 0.7.0
	 */
	open var textOverflow: TextOverflow by Delegates.OnSet(TextOverflow.ELLIPSIS) { value ->
		this.layout.textOverflow = value
		this.invalidate()
	}

	/**
	 * @property textDecoration
	 * @since 0.7.0
	 */
	open var textDecoration: TextDecoration by Delegates.OnSet(TextDecoration.NONE) {
		this.invalidateSpans()
		this.invalidateSpannedText()
		this.invalidate()
	}

	/**
	 * @property textTransform
	 * @since 0.7.0
	 */
	open var textTransform: TextTransform by Delegates.OnSet(TextTransform.NONE) {
		this.invalidateSpans()
		this.invalidateSpannedText()
		this.invalidate()
	}

	/**
	 * @property textShadowBlur
	 * @since 0.7.0
	 */
	open var textShadowBlur: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * @property textShadowColor
	 * @since 0.7.0
	 */
	open var textShadowColor: Int by Delegates.OnSet(Color.BLACK) {
		this.invalidate()
	}

	/**
	 * @property textShadowOffsetTop
	 * @since 0.7.0
	 */
	open var textShadowOffsetTop: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * @property textShadowOffsetLeft
	 * @since 0.7.0
	 */
	open var textShadowOffsetLeft: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * @property maxLines
	 * @since 0.7.0
	 */
	open var maxLines: Int by Delegates.OnSet(0) { value ->
		this.layout.maxLines = value
		this.invalidate()
	}

	/**
	 * @property linkColor
	 * @since 0.7.0
	 */
	open var linkColor: Int by Delegates.OnSet(Color.BLUE) {
		this.invalidateSpans()
		this.invalidateSpannedText()
		this.invalidate()
	}

	/**
	 * @property linkDecoration
	 * @since 0.7.0
	 */
	private var linkDecoration: TextDecoration by Delegates.OnSet(TextDecoration.UNDERLINE) {
		this.invalidateSpans()
		this.invalidateSpannedText()
		this.invalidate()
	}

	/**
	 * @property paddingTop
	 * @since 0.7.0
	 */
	open var paddingTop: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * @property paddingLeft
	 * @since 0.7.0
	 */
	open var paddingLeft: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * @property paddingRight
	 * @since 0.7.0
	 */
	open var paddingRight: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * @property paddingBottom
	 * @since 0.7.0
	 */
	open var paddingBottom: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * @property observer
	 * @since 0.7.0
	 * @hidden
	 */
	private var observer: TextViewObserver

	/**
	 * @property layout
	 * @since 0.7.0
	 * @hidden
	 */
	private var layout: TextLayout = TextLayout()

	/**
	 * @property bounds
	 * @since 0.7.0
	 * @hidden
	 */
	private var bounds: Rect = Rect()

	/**
	 * @property paint
	 * @since 0.7.0
	 * @hidden
	 */
	private val paint: TextPaint = TextPaint()

	/**
	 * @property font
	 * @since 0.7.0
	 * @hidden
	 */
	private var font: Font? = null

	/**
	 * @property spans
	 * @since 0.7.0
	 * @hidden
	 */
	private var spans: List<Any> = listOf()

	/**
	 * @property spannedText
	 * @since 0.7.0
	 * @hidden
	 */
	private var spannedText: Spanned by Delegates.OnSet(SpannableString("") as Spanned) { value ->
		this.layout.text = value
	}

	/**
	 * @property invalidSpans
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidSpans: Boolean = false

	/**
	 * @property invalidSpannedText
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidSpannedText: Boolean = false

	/**
	 * @property textParserOptions
	 * @since 0.7.0
	 * @hidden
	 */
	private var textParserOptions: TextParser.Options = TextParser.Options(
		linkTextColor = Color.BLUE,
		linkTextDecoration = TextDecoration.UNDERLINE
	)

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {

		this.fontSize = Convert.toPx(17.0)

		this.paint.style = Paint.Style.FILL
		this.paint.isAntiAlias = true
		this.paint.isSubpixelText = true
		this.paint.isLinearText = true
		this.paint.linkColor = Color.BLUE

		this.setWillNotDraw(false)

		this.observer = observer
	}

	/**
	 * @method onResize
	 * @since 0.7.0
	 */
	override fun onResize(t: Int, l: Int, w: Int, h: Int) {

		this.setMeasuredFrame(t, l, w, h)

		val paddingT = this.paddingTop
		val paddingL = this.paddingLeft
		val paddingR = this.paddingRight
		val paddingB = this.paddingBottom

		this.bounds.x = paddingL
		this.bounds.y = paddingT
		this.bounds.width = this.width - paddingL - paddingR
		this.bounds.height = this.height - paddingT - paddingB
	}

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	open fun measure(bounds: SizeF, min: SizeF, max: SizeF): SizeF {

		if (this.text.length == 0) {
			return SizeF(0f, 0f)
		}

		val paddingT = this.paddingTop
		val paddingL = this.paddingLeft
		val paddingR = this.paddingRight
		val paddingB = this.paddingBottom

		val frame = Size(bounds)
		if (frame.width > 0) {

			frame.width -= paddingL
			frame.width -= paddingR

			if (frame.width < 0f) {
				frame.width = 1f
			}
		}

		if (frame.height > 0) {

			frame.height -= paddingT
			frame.height -= paddingB

			if (frame.height < 0f) {
				frame.height = 1f
			}
		}

		this.update(frame)

		return this.layout.extent.clamped(min, max)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 */
	open fun update() {
		this.update(this.bounds.size)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 */
	open fun update(size: Size) {

		if (this.invalidSpans) {
			this.invalidSpans = false
			this.updateSpans()
		}

		if (this.invalidSpannedText) {
			this.invalidSpannedText = false
			this.updateSpannedText()
		}

		this.layout.build(size, this.paint)
	}

	/**
	 * @method updateSpans
	 * @since 0.7.0
	 */
	open fun updateSpans() {

		val spans = mutableListOf<Any>()

		if (this.font == null) {
			this.font = Font(
				this.fontFamily,
				this.fontWeight,
				this.fontStyle,
				this.fontSize
			)
		}

		val font = this.font!!

		this.paint.typeface = font.typeface
		this.paint.textSize = font.size

		spans.add(FontSpan(font))
		spans.add(TextColorSpan(this.textColor))
		spans.add(TextLeadingSpan(this.textLeading))
		spans.add(TextKerningSpan(this.textKerning))
		spans.add(TextParagraphSpan(this.textAlign))
		spans.add(TextDecorationSpan(this.textDecoration))

		this.spans = spans
	}

	/**
	 * @method updateSpannedText
	 * @since 0.7.0
	 */
	open fun updateSpannedText() {

		if (this.text.length == 0) {
			return
		}

		var string = this.text.normalize()

		when (this.textTransform) {
			TextTransform.LOWERCASE  -> string = TextTransform.lowercase(string)
			TextTransform.UPPERCASE  -> string = TextTransform.uppercase(string)
			TextTransform.CAPITALIZE -> string = TextTransform.capitalize(string)
			TextTransform.NONE       -> {}
		}

		if (string.isHTML) {
			this.textParserOptions.linkTextColor = this.linkColor
			this.textParserOptions.linkTextDecoration = this.linkDecoration
			this.spannedText = TextParser(string, this.spans, this.textParserOptions).string
			return
		}

		this.spannedText = SpannableString(string, this.spans)
	}

	/**
	 * @method onTouchEvent
	 * @since 0.7.0
	 */
	override fun onTouchEvent(event: MotionEvent): Boolean {

		val result = super.onTouchEvent(event)

		if (event.action == MotionEvent.ACTION_DOWN) {
			// TODO
			// FIX LIKE ON IOS
			return true
		}

		if (event.action == MotionEvent.ACTION_UP) {

			val string = this.layout.string(event.x, event.y)
			if (string == null) {
				return result
			}

			string.getSpans(0, string.length, LinkSpan::class.javaObjectType).forEach {
				this.observer.onPressLink(this, it.url)
			}
		}

		return result
	}

	/**
	 * @method onDraw
	 * @since 0.7.0
	 */
	override fun onDraw(canvas: Canvas) {

		if (this.text.length == 0) {
			return
		}

		this.paint.setShadowLayer(
			this.textShadowBlur,
			this.textShadowOffsetLeft,
			this.textShadowOffsetTop,
			this.textShadowColor
		)

		this.update()

		val tx = this.paddingLeft
		val ty = this.paddingTop

		canvas.save()
		canvas.translate(tx, ty)

		this.layout.draw(canvas)

		canvas.restore()
	}

	//--------------------------------------------------------------------------
	// Animations
	//--------------------------------------------------------------------------

	/**
	 * @property animatable
	 * @since 0.7.0
	 */
	override val animatable: List<String> = listOf(
		"fontSize",
		"textColor",
		"textKerning",
		"textLeading",
		"textBaseline"		
	)

	/**
	 * @property animations
	 * @since 0.7.0
	 */
	override var animations: MutableMap<String, ValueAnimator> = mutableMapOf()
	
	/**
	 * @method onBeforeAnimate
	 * @since 0.7.0
	 */
	override fun animate(property: String, initialValue: Any, currentValue: Any): ValueAnimator? {
		return null
	}

	/**
	 * @method onBeforeAnimate
	 * @since 0.7.0
	 */
	override fun onBeforeAnimate(property: String) {

	}

	/**
	 * @method onBeginTransition
	 * @since 0.7.0
	 */
	override fun onBeginTransition() {

	}

	/**
	 * @method onCommitTransition
	 * @since 0.7.0
	 */
	override fun onCommitTransition() {

	}

	/**
	 * @method onFinishTransition
	 * @since 0.7.0
	 */
	override fun onFinishTransition() {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateSpans
	 * @since 0.7.0
	 * @hidden
	 */
	private fun invalidateSpans() {
		this.invalidSpans = true
	}

	/**
	 * @method invalidateSpannedText
	 * @since 0.7.0
	 * @hidden
	 */
	private fun invalidateSpannedText() {
		this.invalidSpannedText = true
	}
}