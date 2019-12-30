package ca.logaritm.dezel.view.text.font

import android.graphics.Paint
import android.graphics.Typeface
import android.text.TextPaint
import ca.logaritm.dezel.view.graphic.Convert

/**
 * @class Font
 * @since 0.5.0
 */
open class Font(family: String, weight: String, style: String, size: Float) {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * @property DEFAULT
		 * @since 0.5.0
		 */
		public val DEFAULT = Font("", "", "normal", Convert.toPx(17f))

	}

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * @property family
	 * @since 0.5.0
	 */
	public val family: String = family

	/**
	 * @property weight
	 * @since 0.5.0
	 */
	public val weight: String = weight

	/**
	 * @property style
	 * @since 0.5.0
	 */
	public val style: String = style

	/**
	 * @property size
	 * @since 0.5.0
	 */
	public val size: Float = size

	/**
	 * @property typeface
	 * @since 0.5.0
	 */
	public val typeface: Typeface = FontManager.get(family, weight, style)

	/**
	 * @property metrics
	 * @since 0.5.0
	 */
	public val metrics: Paint.FontMetrics
		get() = this.paint.fontMetrics

	/**
	 * @property paint
	 * @since 0.5.0
	 * @hidden
	 */
	private val paint: TextPaint = TextPaint()

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.5.0
	 */
	init {
		this.paint.typeface = this.typeface
		this.paint.textSize = this.size
	}

	/**
	 * @method withBold
	 * @since 0.5.0
	 */
	public fun withBold(): Font {
		return Font(this.family, "bold", this.style, this.size)
	}

	/**
	 * @method withItalic
	 * @since 0.5.0
	 */
	public fun withItalic(): Font {
		return Font(this.family, this.weight, "italic", this.size)
	}
}