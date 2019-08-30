package ca.logaritm.dezel.text

import android.graphics.Canvas
import android.graphics.Rect
import android.text.Spanned
import android.text.StaticLayout
import android.text.TextPaint
import android.util.SizeF
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.text.SpannableString
import ca.logaritm.dezel.extension.type.max
import ca.logaritm.dezel.geom.Size
import ca.logaritm.dezel.text.layout.StaticLayoutBuilder
import ca.logaritm.dezel.view.type.TextLocation
import ca.logaritm.dezel.view.type.TextOverflow

/**
 * Break up text into lines that fits into specified bounds.
 * @class TextLayout
 * @since 0.5.0
 */
open class TextLayout {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text layout's text.
	 * @property text
	 * @since 0.5.0
	 */
	open var text: Spanned by Delegates.OnSet(SpannableString("") as Spanned) {
		this.invalidate()
	}

	/**
	 * The text layout's text kerning.
	 * @property textKerning
	 * @since 0.5.0
	 */
	open var textKerning: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The text layout's text leading.
	 * @property textLeading
	 * @since 0.5.0
	 */
	open var textLeading: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The text layout's text baseline offset.
	 * @property textBaseline
	 * @since 0.5.0
	 */
	open var textBaseline: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The text layout's text location.
	 * @property textLocation
	 * @since 0.7.0
	 */
	open var textLocation: TextLocation by Delegates.OnSet(TextLocation.MIDDLE) {
		this.invalidate()
	}

	/**
	 * The text layout's text overflow.
	 * @property textOverflow
	 * @since 0.5.0
	 */
	open var textOverflow: TextOverflow by Delegates.OnSet(TextOverflow.ELLIPSIS) {
		this.invalidate()
	}

	/**
	 * The text layout's maximum amount of lines.
	 * @property maxLines
	 * @since 0.7.0
	 */
	open var maxLines: Int by Delegates.OnSet(0) {
		this.invalidate()
	}

	/**
	 * The text layout size used to build.
	 * @property bounds
	 * @since 0.5.0
	 */
	public var bounds: Size = Size()
		private set

	/**
	 * The text layout's computed limits.
	 * @property extent
	 * @since 0.5.0
	 */
	public var limits: Size = Size()
		private set

	/**
	 * The text layout's size that is taken.
	 * @property extent
	 * @since 0.5.0
	 */
	public var extent: Size = Size()
		private set

	/**
	 * Whether the text layout is invalid.
	 * @property invalid
	 * @since 0.5.0
	 */
	public var invalid: Boolean = false
		private set

	/**
	 * @property layout
	 * @since 0.5.0
	 * @hidden
	 */
	private lateinit var layout: StaticLayout

	/**
	 * @property frame
	 * @since 0.5.0
	 * @hidden
	 */
	private var frame: Rect = Rect()

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Finds a character at the specified position.
	 * @method build
	 * @since 0.5.0
	 */
	open fun find(x: Float, y: Float): Spanned? {

		if (this.text.length == 0) {
			return null
		}

		val line = this.layout.getLineForVertical(y.toInt())
		if (line == -1) {
			return null
		}

		var index = this.layout.getOffsetForHorizontal(line, x)
		if (index == this.text.length) {
			index = this.text.length - 1
		}

		return this.text.subSequence(index, index + 1) as Spanned
	}

	/**
	 * Builds the layout.
	 * @method build
	 * @since 0.5.0
	 */
	open fun build(bounds: SizeF, paint: TextPaint) {
		this.build(Size(bounds), paint)
	}

	/**
	 * Builds the layout.
	 * @method build
	 * @since 0.5.0
	 */
	open fun build(bounds: Size, paint: TextPaint) {

		if (this.text.length == 0) {
			return
		}

		if (this.invalid == false) {
			if (this.bounds.equals(bounds) == false &&
				this.extent.equals(bounds) == false) {
				this.invalid = true
			}
		}

		this.bounds = Size(bounds)

		if (this.invalid == false) {
			return
		}

		var w = bounds.width
		var h = bounds.height

		if (w == 0f) w = Float.max
		if (h == 0f) h = Float.max

		val limits = Size(w, h)

		this.limits = limits
		this.extent = Size()

		this.layout = StaticLayoutBuilder.build(
			paint,
			this.bounds,
			this.limits,
			this.text,
			this.textLeading,
			this.textKerning,
			this.textOverflow,
			this.maxLines
		)

		val last = this.getLastLine()

		for (line in 0 until this.layout.lineCount) {

			val width = this.layout.getLineWidth(line)

			if (this.extent.width < width) {
				this.extent.width = width
			}

			this.extent.height = this.layout.getLineBottom(line).toFloat()

			if (line == last) {
				break
			}
		}

		if (this.extent.width < this.bounds.width) {
			this.extent.width = this.bounds.width
		}

		this.extent.ceil()

		this.invalid = false
	}

	/**
	 * Invalidates the layout.
	 * @method invalidate
	 * @since 0.5.0
	 */
	open fun invalidate() {
		this.invalid = true
	}

	/**
	 * Draws the text layout.
	 * @method invalidate
	 * @since 0.5.0
	 */
	open fun draw(canvas: Canvas) {

		val bounds = this.bounds
		val extent = this.extent

		var offset = 0f

		when (this.textLocation) {

			TextLocation.MIDDLE -> offset += extent.toMiddleOf(bounds).y
			TextLocation.BOTTOM -> offset += extent.toBottomOf(bounds).y
			TextLocation.TOP    -> {}

		}

		offset += this.textBaseline

		this.frame.set(
			0, 0,
			this.bounds.width.toInt(),
			this.bounds.height.toInt()
		)

		canvas.save()
		canvas.clipRect(this.frame)
		canvas.translate(0f, offset)

		this.layout.draw(canvas)

		canvas.restore()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	private fun getLastLine(): Int {
		return this.maxLines - 1
	}
}