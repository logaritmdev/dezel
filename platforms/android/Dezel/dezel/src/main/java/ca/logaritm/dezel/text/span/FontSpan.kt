package ca.logaritm.dezel.text.span

import android.text.TextPaint
import android.text.style.MetricAffectingSpan
import ca.logaritm.dezel.font.Font

/**
 * Applies font properties to a text span.
 * @class FontSpan
 * @since 0.5.0
 */
open class FontSpan(font: Font): MetricAffectingSpan() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The font typeface.
	 * @property font
	 * @since 0.5.0
	 */
	public val font: Font = font

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method updateMeasureState
	 * @since 0.5.0
	 */
	override fun updateMeasureState(paint: TextPaint) {
		paint.typeface = this.font.typeface
		paint.textSize = this.font.size
	}

	/**
	 * @inherited
	 * @method updateDrawState
	 * @since 0.5.0
	 */
	override fun updateDrawState(paint: TextPaint) {
		paint.typeface = this.font.typeface
		paint.textSize = this.font.size
	}
}